StubNop_3b_4:
	ret ; $61e9
	; $61ea, 6 bytes (ram_ptrs:3)
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 0
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 1
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 2
RunMinigameSelect:
	ld hl, rIE ; $61f0
	res 2, [hl] ; $61f3
	sound BGM_MARIO_MINIGAME ; $61f5
	xor a ; $61f7
	ld [wMinigameSelectUnused], a ; $61f8
	call BuildMarioCastUnlockMask ; $61fb
	call LoadMinigameSelectGfx ; $61fe
	wram_bank WRAM_SCREEN ; $6201
	call CheckMinigameGridExpanded ; $6207
	or a ; $620a
	jr nz, .checkMenuSlideDirection ; $620b
	ld a, [wMenuSlideDirection] ; $620d
	ld b, a ; $6210
	call MinigameSelectSlideIn6 ; $6211
	jr .initMenuBgScroll ; $6214
.checkMenuSlideDirection:
	ld a, [wMenuSlideDirection] ; $6216
	ld b, a ; $6219
	call MinigameSelectSlideIn9 ; $621a
.initMenuBgScroll:
	farcall InitMenuBgScroll ; $621d
	ld b, $01 ; $6220
	ld c, $01 ; $6222
	farcall LoadMenuSpritePalettePair ; $6224
	ld a, [wSelectedMinigame] ; $6227
	ld c, a ; $622a
	ld b, $03 ; $622b
	call SetMenuCursorFromIndex_3b ; $622d
	ld a, $01 ; $6230
	ld hl, MinigameSelectCursorSpriteTask ; $6232
	call RegisterFrameTask ; $6235
	call DrawMinigameSelectCaption ; $6238
	call CheckMinigameGridExpanded ; $623b
	or a ; $623e
	jr nz, .drawMinigameSelectGrid9 ; $623f
	call DrawMinigameSelectGrid6 ; $6241
	jr .storeMenuInputPressed ; $6244
.drawMinigameSelectGrid9:
	call DrawMinigameSelectGrid9 ; $6246
.storeMenuInputPressed:
	wram_bank WRAM_SCREEN ; $6249
.loop:
	ldh a, [hInputPressed] ; $624f
	ld [wMenuInputPressed], a ; $6251
	call CheckMinigameGridExpanded ; $6254
	or a ; $6257
	jr nz, .nonZero ; $6258
	farcall MoveMinigameGridCursor ; $625a
	or a ; $625d
	jr z, .advanceFrame ; $625e
	sound SFX_MENU_MOVE ; $6260
	call DrawMinigameSelectCaption ; $6262
	call DrawMinigameSelectGrid6 ; $6265
	jr .advanceFrame ; $6268
.nonZero:
	ld b, $03 ; $626a
	ld c, $03 ; $626c
	call MoveMenuCursorGrid_3b ; $626e
	or a ; $6271
	jr z, .advanceFrame ; $6272
	sound SFX_MENU_MOVE ; $6274
	call DrawMinigameSelectCaption ; $6276
	call DrawMinigameSelectGrid9 ; $6279
.advanceFrame:
	call AdvanceFrame ; $627c
	ld a, [wMenuInputPressed] ; $627f
	bit PADB_A, a ; $6282
	jr nz, .getMenuCursorCellIndex ; $6284
	bit 1, a ; $6286
	jr nz, .playSfx2 ; $6288
	jr .loop ; $628a
.getMenuCursorCellIndex:
	ld c, $03 ; $628c
	call GetMenuCursorIndex_3b ; $628e
	ld c, a ; $6291
	call GetUnlockedMarioCastCharAtGridSlot ; $6292
	cp CHAR_UNUSED_15 ; $6295
	jr nz, .playSfx ; $6297
	sound SFX_MENU_LOCKED ; $6299
	jr .loop ; $629b
.playSfx:
	sound SFX_MENU_SELECT ; $629d
	call ClearFrameTasks ; $629f
	ld hl, rIE ; $62a2
	set 2, [hl] ; $62a5
	call CheckMinigameGridExpanded ; $62a7
	or a ; $62aa
	jr nz, .nonZero2 ; $62ab
	ld b, $01 ; $62ad
	call MinigameSelectSlideOut6 ; $62af
	jr .storeMenuSlideDirection ; $62b2
.nonZero2:
	ld b, $01 ; $62b4
	call MinigameSelectSlideOut9 ; $62b6
.storeMenuSlideDirection:
	ld a, MENUSLIDE_FORWARD ; $62b9
	ld [wMenuSlideDirection], a ; $62bb
	xor a ; $62be
	ld [wMinigameSelectUnused], a ; $62bf
	ld c, $03 ; $62c2
	call GetMenuCursorIndex_3b ; $62c4
	ld [wSelectedMinigame], a ; $62c7
	ret ; $62ca
.playSfx2:
	sound SFX_MENU_CANCEL ; $62cb
	call ClearFrameTasks ; $62cd
	ld hl, rIE ; $62d0
	set 2, [hl] ; $62d3
	call CheckMinigameGridExpanded ; $62d5
	or a ; $62d8
	jr nz, .nonZero3 ; $62d9
	ld b, $00 ; $62db
	call MinigameSelectSlideOut6 ; $62dd
	jr .storeMenuSlideDirection2 ; $62e0
.nonZero3:
	ld b, $00 ; $62e2
	call MinigameSelectSlideOut9 ; $62e4
.storeMenuSlideDirection2:
	ld a, MENUSLIDE_BACK ; $62e7
	ld [wMenuSlideDirection], a ; $62e9
	ld a, $ff ; $62ec
	ret ; $62ee
LoadMinigameSelectGfx:
	push_wram_bank WRAM_STAGING ; $62ef
	ld c, $00 ; $62f8
.loop:
	push bc ; $62fa
	call GetUnlockedMarioCastCharAtGridSlot ; $62fb
	ld b, a ; $62fe
	ld de, wDecompBuffer ; $62ff
	farcall DecompressCharacterPortrait ; $6302
	pop bc ; $6305
	push bc ; $6306
	ld a, c ; $6307
	add a ; $6308
	ld hl, MinigameSelectTable ; $6309
	add l ; $630c
	ld l, a ; $630d
	jr nc, .read ; $630e
	inc h ; $6310
.read:
	ld a, [hl+] ; $6311
	ld d, [hl] ; $6312
	ld e, a ; $6313
	ld hl, wDecompBuffer ; $6314
	ld c, $09 ; $6317
	call QueueVRAMCopy ; $6319
	pop bc ; $631c
	call AdvanceFrame ; $631d
	ld a, c ; $6320
	inc a ; $6321
	ld c, a ; $6322
	cp $09 ; $6323
	jr nz, .loop ; $6325
	ld b, TILEBLOCK_MinigameSelectGfx0 ; $6327
	ld c, MinigameSelectGfx0_SIZE / 16 ; $6329
	ld de, vTiles0 + VRAM_BANK1 ; $632b
	farcall LoadCompressedTileBlock ; $632e
	call AdvanceFrame ; $6331
	ld b, TILEBLOCK_MinigameSelectGfx1 ; $6334
	ld c, MinigameSelectGfx1_SIZE / 16 ; $6336
	ld de, vTiles0 + $10 * TILE_SIZE + VRAM_BANK1 ; $6338
	farcall LoadCompressedTileBlock ; $633b
	call AdvanceFrame ; $633e
	ld b, TILEBLOCK_MinigameSelectGfx2 ; $6341
	ld c, MinigameSelectGfx2_SIZE / 16 ; $6343
	ld de, vTiles0 + $20 * TILE_SIZE + VRAM_BANK1 ; $6345
	farcall LoadCompressedTileBlock ; $6348
	call AdvanceFrame ; $634b
	ld b, TILEBLOCK_MinigameSelectGfx3 ; $634e
	ld c, MinigameSelectGfx3_SIZE / 16 ; $6350
	ld de, vTiles0 + $30 * TILE_SIZE + VRAM_BANK1 ; $6352
	farcall LoadCompressedTileBlock ; $6355
	call AdvanceFrame ; $6358
	ld b, TILEBLOCK_MinigameSelectGfx4 ; $635b
	ld c, MinigameSelectGfx4_SIZE / 16 ; $635d
	ld de, vTiles0 + $40 * TILE_SIZE + VRAM_BANK1 ; $635f
	farcall LoadCompressedTileBlock ; $6362
	call AdvanceFrame ; $6365
	ld b, TILEBLOCK_MinigameSelectGfx5 ; $6368
	ld c, MinigameSelectGfx5_SIZE / 16 ; $636a
	ld de, vTiles0 + $50 * TILE_SIZE + VRAM_BANK1 ; $636c
	farcall LoadCompressedTileBlock ; $636f
	call AdvanceFrame ; $6372
	ld_slot hl, DataPtr_MinigameSelectIconGfx0 ; $6375
	ld de, wDecompBuffer ; $6378
	call DecompressDataFromBank ; $637b
	ld hl, wDecompBuffer ; $637e
	ld de, vTiles0 + $20 * TILE_SIZE ; $6381
	ld c, $10 ; $6384
	call QueueVRAMCopy ; $6386
	ld_slot hl, DataPtr_MinigameSelectIconGfx1 ; $6389
	ld de, wDecompBuffer + 64 * TILE_SIZE ; $638c
	call DecompressDataFromBank ; $638f
	ld hl, wDecompBuffer + 64 * TILE_SIZE ; $6392
	ld de, vTiles0 + $30 * TILE_SIZE ; $6395
	ld c, $10 ; $6398
	call QueueVRAMCopy ; $639a
	call AdvanceFrame ; $639d
	ld_slot hl, DataPtr_MinigameSelectIconGfx2 ; $63a0
	ld de, wDecompBuffer ; $63a3
	call DecompressDataFromBank ; $63a6
	ld hl, wDecompBuffer ; $63a9
	ld de, vTiles0 + $40 * TILE_SIZE ; $63ac
	ld c, $10 ; $63af
	call QueueVRAMCopy ; $63b1
	call AdvanceFrame ; $63b4
	ld b, TILEBLOCK_SharedMenuGfx111 ; $63b7
	ld c, $12 ; $63b9 -- 18 of SharedMenuGfx111's 16 tiles
	ld de, vTiles0 + $50 * TILE_SIZE ; $63bb
	farcall LoadCompressedTileBlock ; $63be
	call AdvanceFrame ; $63c1
	ld b, TILEBLOCK_MinigameSelectGfx6 ; $63c4
	ld c, MinigameSelectGfx6_SIZE / 16 ; $63c6
	ld de, vTiles0 ; $63c8
	farcall LoadCompressedTileBlock ; $63cb
	call AdvanceFrame ; $63ce
	ld b, TILEBLOCK_SharedMenuGfx27 ; $63d1
	ld c, SharedMenuGfx27_SIZE / 16 ; $63d3
	ld de, vTiles0 + $70 * TILE_SIZE + VRAM_BANK1 ; $63d5
	farcall LoadCompressedTileBlock ; $63d8
	ld b, $08 ; $63db
	ld c, $10 ; $63dd
	farcall LoadIndexedPalette ; $63df
	pop_wram_bank ; $63e2
	ret ; $63e7
	; $63e8, 14 bytes (bytes:2)
	db $62, $3c ; 0x00
	db $64, $3c ; 0x02
	db $66, $3c ; 0x04
	db $68, $3c ; 0x06
	db $6a, $3c ; 0x08
	db $6c, $3c ; 0x0a
	db $6e, $3c ; 0x0c
MinigameSelectTable:
	; $63f6, 20 bytes (bytes:2)
	db $80, $b6 ; 0x00
	db $10, $b7 ; 0x02
	db $00, $af ; 0x04
	db $00, $a8 ; 0x06
	db $00, $a9 ; 0x08
	db $00, $aa ; 0x0a
	db $00, $ab ; 0x0c
	db $00, $ac ; 0x0e
	db $00, $ad ; 0x10
	db $00, $ae ; 0x12
MinigameSelectSlideIn9:
	ld a, b ; $640a
	or a ; $640b
	jr z, .zero ; $640c
	ld c, $00 ; $640e
.loop:
	call AdvanceFrame ; $6410
	ld b, $04 ; $6413
	farcall RestoreMenuBgAndDrawPanel ; $6415
	ld b, $00 ; $6418
	farcall FlushWram3MapRows ; $641a
	ld a, c ; $641d
	inc a ; $641e
	ld c, a ; $641f
	cp $0e ; $6420
	jr nz, .loop ; $6422
	ret ; $6424
.zero:
	ld c, $0c ; $6425
.loopB:
	call AdvanceFrame ; $6427
	ld b, $05 ; $642a
	farcall RestoreMenuBgAndDrawPanel ; $642c
	ld b, $00 ; $642f
	farcall FlushWram3MapRows ; $6431
	ld a, c ; $6434
	dec a ; $6435
	ld c, a ; $6436
	cp $ff ; $6437
	jr nz, .loopB ; $6439
	ret ; $643b
MinigameSelectSlideOut9:
	ld a, b ; $643c
	or a ; $643d
	jr z, .zero ; $643e
	ld c, $00 ; $6440
.loop:
	call AdvanceFrame ; $6442
	ld b, $05 ; $6445
	farcall RestoreMenuBgAndDrawPanel ; $6447
	ld b, $00 ; $644a
	farcall FlushWram3MapRows ; $644c
	ld a, c ; $644f
	inc a ; $6450
	ld c, a ; $6451
	cp $0b ; $6452
	jr nz, .loop ; $6454
	ret ; $6456
.zero:
	ld c, $0d ; $6457
.loopB:
	call AdvanceFrame ; $6459
	ld b, $04 ; $645c
	farcall RestoreMenuBgAndDrawPanel ; $645e
	ld b, $00 ; $6461
	farcall FlushWram3MapRows ; $6463
	ld a, c ; $6466
	dec a ; $6467
	ld c, a ; $6468
	or a ; $6469
	jr nz, .loopB ; $646a
	ret ; $646c
MinigameSelectCursorSpriteTask:
	farcall TickMenuBgScroll ; $646d
	ld c, $03 ; $6470
	call GetMenuCursorIndex_3b ; $6472
	push af ; $6475
	ld hl, MinigameSelectCursorSpriteTaskTable1 ; $6476
	add l ; $6479
	ld l, a ; $647a
	jr nc, .read ; $647b
	inc h ; $647d
.read:
	ld c, [hl] ; $647e
	pop af ; $647f
	push af ; $6480
	call GetMinigameCursorPosTable ; $6481
	add a ; $6484
	add l ; $6485
	ld l, a ; $6486
	jr nc, .readB ; $6487
	inc h ; $6489
.readB:
	ld a, [hl+] ; $648a
	ld d, [hl] ; $648b
	ld e, a ; $648c
	farcall ApplySpriteBobOffset ; $648d
	pop af ; $6490
	ld hl, MinigameSelectCursorSpriteTaskTable0 ; $6491
	add l ; $6494
	ld l, a ; $6495
	jr nc, .read2 ; $6496
	inc h ; $6498
.read2:
	ld b, [hl] ; $6499
	call OverrideMinigameCursorIfLocked ; $649a
	ld hl, MinigameSelectCursorSpriteTask_SpriteTemplate0 ; $649d
	push de ; $64a0
	call QueueSpriteTemplate ; $64a1
	pop de ; $64a4
	ld hl, $17f8 ; $64a5
	add hl, de ; $64a8
	ld d, h ; $64a9
	ld e, l ; $64aa
	ld hl, MinigameSelectCursorSpriteTask_SpriteTemplate1 ; $64ab
	ld b, $08 ; $64ae
	ld c, $70 ; $64b0
	call QueueSpriteTemplate ; $64b2
	ret ; $64b5
GetMinigameCursorPosTable:
	push de ; $64b6
	push bc ; $64b7
	push af ; $64b8
	call CheckMinigameGridExpanded ; $64b9
	jr nz, .altTable ; $64bc
	ld hl, MinigameCursorPosTable1 ; $64be
	jr .done ; $64c1
.altTable:
	ld hl, MinigameCursorPosTable0 ; $64c3
.done:
	pop af ; $64c6
	pop bc ; $64c7
	pop de ; $64c8
	ret ; $64c9
MinigameSelectCursorSpriteTask_SpriteTemplate0:
	; $64ca, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
MinigameSelectCursorSpriteTask_SpriteTemplate1:
	; $64eb, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
MinigameSelectCursorSpriteTaskTable0:
	; $64f4, 9 bytes (bytes:9)
	db $08, $00, $08, $00, $08, $00, $08, $08, $08 ; 0x00
MinigameCursorPosTable0:
	; $64fd, 18 bytes (bytes:16)
	db $30, $fc, $30, $2c, $30, $5c, $50, $fc, $50, $2c, $50, $5e, $6c, $fc, $6c, $2c ; 0x00
	db $6c, $5e ; 0x10
MinigameCursorPosTable1:
	; $650f, 12 bytes (bytes:12)
	db $38, $fc, $38, $2c, $38, $5c, $60, $14, $60, $44, $60, $44 ; 0x00
MinigameSelectCursorSpriteTaskTable1:
	; $651b, 50 bytes (bytes:16)
	db $00, $30, $50, $40, $20, $20, $40, $10, $30, $10, $08, $00, $00, $10, $10, $02 ; 0x00
	db $00, $10, $18, $04, $00, $10, $20, $06, $00, $10, $28, $08, $00, $10, $30, $0a ; 0x10
	db $00, $10, $38, $0c, $00, $10, $40, $0e, $00, $10, $48, $10, $00, $10, $50, $12 ; 0x20
	db $00, $80 ; 0x30
OverrideMinigameCursorIfLocked:
	push bc ; $654d
	push hl ; $654e
	push de ; $654f
	ld c, $03 ; $6550
	call GetMenuCursorIndex_3b ; $6552
	ld c, a ; $6555
	call GetUnlockedMarioCastCharAtGridSlot ; $6556
	cp CHAR_UNUSED_15 ; $6559
	jr z, .eq15 ; $655b
	pop de ; $655d
	pop hl ; $655e
	pop bc ; $655f
	ret ; $6560
.eq15:
	ld c, $50 ; $6561
	ld b, $00 ; $6563
	pop de ; $6565
	pop hl ; $6566
	pop af ; $6567
	ret ; $6568
DrawMinigameSelectCaption:
	wram_bank WRAM_SCREEN ; $6569
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH ; $656f
	ld b, $14 ; $6572
	ld c, $01 ; $6574
	ld h, $03 ; $6576
	farcall FillTilemapRect ; $6578
	ld a, $02 ; $657b
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH], a ; $657d
	ld a, $04 ; $6580
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH + 19], a ; $6582
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $6585
	ld b, $12 ; $6588
	ld c, $01 ; $658a
	ld h, $20 ; $658c
	farcall FillTilemapRect ; $658e
	call RenderMinigameNameText ; $6591
	ld hl, wShadowTilemap + 15 * TILEMAP_WIDTH ; $6594
	ld de, vBGMap0 + 15 * TILEMAP_WIDTH ; $6597
	ld c, $04 ; $659a
	call QueueVRAMCopy ; $659c
	ret ; $659f
RenderMinigameNameText:
	wram_bank WRAM_SCREEN ; $65a0
	ld c, $03 ; $65a6
	call GetMenuCursorIndex_3b ; $65a8
	push af ; $65ab
	ld c, a ; $65ac
	call GetUnlockedMarioCastCharAtGridSlot ; $65ad
	cp CHAR_UNUSED_15 ; $65b0
	jr nz, .restore ; $65b2
	pop af ; $65b4
	ld hl, $00bb ; $65b5
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $65b8
	jr .renderTextToBuffer64 ; $65bb
.restore:
	pop af ; $65bd
	ld b, a ; $65be
	add a ; $65bf
	ld hl, RenderMinigameNameTextTable ; $65c0
	add l ; $65c3
	ld l, a ; $65c4
	jr nc, .read ; $65c5
	inc h ; $65c7
.read:
	ld a, [hl+] ; $65c8
	ld d, [hl] ; $65c9
	ld e, a ; $65ca
	ld a, b ; $65cb
	ld hl, $00b2 ; $65cc
	add l ; $65cf
	ld l, a ; $65d0
	jr nc, .renderTextToBuffer64 ; $65d1
	inc h ; $65d3
.renderTextToBuffer64:
	ld c, $20 ; $65d4
	farcall RenderTextToBuffer64 ; $65d6
	ret ; $65d9
RenderMinigameNameTextTable:
	; $65da, 18 bytes (ram_ptrs:3)
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 0
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 1
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 2
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 3
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 4
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 5
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 6
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 7
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 8
DrawMinigameSelectGrid9:
	wram_bank WRAM_SCREEN ; $65ec
	ld b, $00 ; $65f2
	ld c, $00 ; $65f4
.loop:
	call FillMinigameSelectCell ; $65f6
	ld a, b ; $65f9
	inc a ; $65fa
	ld b, a ; $65fb
	cp $09 ; $65fc
	jr nz, .loop ; $65fe
	ld c, $03 ; $6600
	call GetMenuCursorIndex_3b ; $6602
	ld b, a ; $6605
	ld c, $01 ; $6606
	call FillMinigameSelectCell ; $6608
	ld c, $03 ; $660b
	call GetMenuCursorIndex_3b ; $660d
	call LoadMinigameCharPalette ; $6610
	ld hl, wShadowAttrmap + 3 * TILEMAP_WIDTH ; $6613
	ld de, vBGMap0 + 3 * TILEMAP_WIDTH + VRAM_BANK1 ; $6616
	ld c, $06 ; $6619
	call QueueVRAMCopy ; $661b
	ld hl, wShadowAttrmap + 7 * TILEMAP_WIDTH ; $661e
	ld de, vBGMap0 + 7 * TILEMAP_WIDTH + VRAM_BANK1 ; $6621
	ld c, $06 ; $6624
	call QueueVRAMCopy ; $6626
	ld hl, wShadowAttrmap + 11 * TILEMAP_WIDTH ; $6629
	ld de, vBGMap0 + 11 * TILEMAP_WIDTH + VRAM_BANK1 ; $662c
	ld c, $06 ; $662f
	call QueueVRAMCopy ; $6631
	ret ; $6634
FillMinigameSelectCell:
	push af ; $6635
	push bc ; $6636
	push de ; $6637
	push hl ; $6638
	ld d, c ; $6639
	ld e, b ; $663a
	ld b, $03 ; $663b
	ld c, $03 ; $663d
	ld a, d ; $663f
	or a ; $6640
	jr z, .zero ; $6641
	ld h, $0c ; $6643
	jr .step2 ; $6645
.zero:
	ld h, $0d ; $6647
.step2:
	push hl ; $6649
	ld hl, FillMinigameSelectCellTable ; $664a
	ld a, e ; $664d
	add a ; $664e
	add l ; $664f
	ld l, a ; $6650
	jr nc, .read ; $6651
	inc h ; $6653
.read:
	ld a, [hl+] ; $6654
	ld d, [hl] ; $6655
	ld e, a ; $6656
	pop hl ; $6657
	farcall FillTilemapRect ; $6658
	pop hl ; $665b
	pop de ; $665c
	pop bc ; $665d
	pop af ; $665e
	ret ; $665f
FillMinigameSelectCellTable:
	; $6660, 18 bytes (ram_ptrs:3)
	dw wShadowAttrmap + 3 * TILEMAP_WIDTH + 2 ; record 0
	dw wShadowAttrmap + 3 * TILEMAP_WIDTH + 8 ; record 1
	dw wShadowAttrmap + 3 * TILEMAP_WIDTH + 14 ; record 2
	dw wShadowAttrmap + 7 * TILEMAP_WIDTH + 2 ; record 3
	dw wShadowAttrmap + 7 * TILEMAP_WIDTH + 8 ; record 4
	dw wShadowAttrmap + 7 * TILEMAP_WIDTH + 14 ; record 5
	dw wShadowAttrmap + 11 * TILEMAP_WIDTH + 2 ; record 6
	dw wShadowAttrmap + 11 * TILEMAP_WIDTH + 8 ; record 7
	dw wShadowAttrmap + 11 * TILEMAP_WIDTH + 14 ; record 8
LoadMinigameCharPalette:
	ld c, a ; $6672
	call GetMarioCastCharAtGridSlot ; $6673
	farcall GetCharPaletteIndex ; $6676
	ld d, $04 ; $6679
	farcall LoadIndexedPalette_18 ; $667b
	ret ; $667e
