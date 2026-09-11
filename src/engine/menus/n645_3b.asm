SavedDataCellPalette0:
	; $70f0, 8 bytes (bytes:8)
	db $9f, $5a, $ff, $6b, $1f, $00, $00, $00 ; 0x00
SavedDataCellPalette1:
	; $70f8, 8 bytes (bytes:8)
	db $cc, $3a, $ff, $6b, $40, $65, $00, $00 ; 0x00
DrawEraseSavedDataCaption:
	push_wram_bank $03 ; $7100
	ld c, $03 ; $7109
	call GetMenuCursorIndex_3b ; $710b
	ld b, a ; $710e
	cp $03 ; $710f
	jp nc, .ge03 ; $7111
	add a ; $7114
	add a ; $7115
	add a ; $7116
	add a ; $7117
	ld bc, wShadowTilemap + 24 * TILEMAP_WIDTH ; $7118
	add c ; $711b
	ld c, a ; $711c
	jr nc, .gotPtr ; $711d
	inc b ; $711f
.gotPtr:
	ld hl, $0000 ; $7120
	add hl, bc ; $7123
	ld a, [hl] ; $7124
	cp $3f ; $7125
	jr z, .eq3f ; $7127
	ld hl, $0003 ; $7129
	add hl, bc ; $712c
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $712d
	call DrawNameWithDiacritics_3b ; $7130
	ld a, $4c ; $7133
	ld [wShadowTilemap + 16 * TILEMAP_WIDTH + 9], a ; $7135
	ld a, $56 ; $7138
	ld [wShadowTilemap + 16 * TILEMAP_WIDTH + 10], a ; $713a
	push af ; $713d
	push bc ; $713e
	push de ; $713f
	push hl ; $7140
	ld hl, $0002 ; $7141
	add hl, bc ; $7144
	ld a, [hl] ; $7145
	ld h, $00 ; $7146
	ld l, a ; $7148
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 12 ; $7149
	ld bc, wShadowTilemap + 25 * TILEMAP_WIDTH + 16 ; $714c
	call PrintNumberRightAligned ; $714f
	pop hl ; $7152
	pop de ; $7153
	pop bc ; $7154
	pop af ; $7155
	push af ; $7156
	push bc ; $7157
	push de ; $7158
	push hl ; $7159
	ld hl, $000f ; $715a
	add hl, bc ; $715d
	ld a, [hl] ; $715e
	ld h, $00 ; $715f
	ld l, a ; $7161
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 15 ; $7162
	ld bc, wShadowTilemap + 25 * TILEMAP_WIDTH + 16 ; $7165
	call Print2DigitNumberRightAligned ; $7168
	pop hl ; $716b
	pop de ; $716c
	pop bc ; $716d
	pop af ; $716e
	ld hl, $000e ; $716f
	add hl, bc ; $7172
	ld a, [hl] ; $7173
	ld h, $00 ; $7174
	ld l, a ; $7176
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 18 ; $7177
	ld bc, wShadowTilemap + 25 * TILEMAP_WIDTH + 16 ; $717a
	call Print2DigitNumberRightAligned ; $717d
	ld a, $3a ; $7180
	ld [wShadowTilemap + 16 * TILEMAP_WIDTH + 16], a ; $7182
	pop_wram_bank ; $7185
	ret ; $718a
.eq3f:
	ld hl, Text_30_206 ; $718b
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $718e
	ld c, $20 ; $7191
	farcall RenderTextToBuffer64 ; $7193
	jr .restore ; $7196
.ge03:
	ld hl, $00cc ; $7198
	sub $03 ; $719b
	add l ; $719d
	ld l, a ; $719e
	jr nc, .renderTextToBuffer64 ; $719f
	inc h ; $71a1
.renderTextToBuffer64:
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $71a2
	ld c, $20 ; $71a5
	farcall RenderTextToBuffer64 ; $71a7
.restore:
	pop_wram_bank ; $71aa
	ret ; $71af
RunN64RecordTypeSelect:
	sound BGM_MENU ; $71b0
	ld hl, rIE ; $71b2
	res 2, [hl] ; $71b5
	call LoadN64RecordTypeGfx ; $71b7
	farcall InitMenuBgScroll ; $71ba
	ld b, $01 ; $71bd
	ld c, $01 ; $71bf
	farcall LoadMenuSpritePalettePair ; $71c1
	wram_bank $03 ; $71c4
	ld a, [wMenuSlideDirection] ; $71ca
	ld b, a ; $71cd
	call N64RecordTypeSlideIn ; $71ce
	ld a, [wSubMenuCursor] ; $71d1
	ld c, a ; $71d4
	ld b, $03 ; $71d5
	call SetMenuCursorFromIndex_3b ; $71d7
	ld a, $01 ; $71da
	ld hl, N64RecordTypeCursorSpriteTask ; $71dc
	call RegisterFrameTask ; $71df
	call DrawN64RecordTypeGrid ; $71e2
	wram_bank $03 ; $71e5
.loop:
	call AdvanceFrame ; $71eb
	ldh a, [hInputPressed] ; $71ee
	ld [wMenuInputPressed], a ; $71f0
	ld b, $03 ; $71f3
	ld c, $01 ; $71f5
	call MoveMenuCursorGrid_3b ; $71f7
	or a ; $71fa
	jr z, .checkMenuInputPressed ; $71fb
	sound SFX_MENU_MOVE ; $71fd
	call DrawN64RecordTypeGrid ; $71ff
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $7202
	bit PADB_A, a ; $7205
	jr nz, .playSfx ; $7207
	bit 1, a ; $7209
	jr nz, .playSfx2 ; $720b
	jr .loop ; $720d
.playSfx:
	sound SFX_MENU_SELECT ; $720f
	call ClearFrameTasks ; $7211
	ld hl, rIE ; $7214
	set 2, [hl] ; $7217
	ld b, $01 ; $7219
	call N64RecordTypeSlideOut ; $721b
	ld a, MENUSLIDE_FORWARD ; $721e
	ld [wMenuSlideDirection], a ; $7220
	ld c, $03 ; $7223
	call GetMenuCursorIndex_3b ; $7225
	ld [wSubMenuCursor], a ; $7228
	ret ; $722b
.playSfx2:
	sound SFX_MENU_CANCEL ; $722c
	call ClearFrameTasks ; $722e
	ld hl, rIE ; $7231
	set 2, [hl] ; $7234
	ld b, $00 ; $7236
	call N64RecordTypeSlideOut ; $7238
	ld a, MENUSLIDE_BACK ; $723b
	ld [wMenuSlideDirection], a ; $723d
	ld a, $ff ; $7240
	ret ; $7242
LoadN64RecordTypeGfx:
	push_wram_bank $01 ; $7243
	ld c, $00 ; $724c
.loop:
	ld a, c ; $724e
	add a ; $724f
	ld hl, N64RecordTypeTable0 ; $7250
	add l ; $7253
	ld l, a ; $7254
	jr nc, .read ; $7255
	inc h ; $7257
.read:
	ld a, [hl+] ; $7258
	ld h, [hl] ; $7259
	ld l, a ; $725a
	push af ; $725b
	push bc ; $725c
	push de ; $725d
	push hl ; $725e
	ld de, wDecompBuffer ; $725f
	call DecompressDataFromBank ; $7262
	pop hl ; $7265
	pop de ; $7266
	pop bc ; $7267
	pop af ; $7268
	ld hl, N64RecordTypeTable1 ; $7269
	ld a, c ; $726c
	add a ; $726d
	add l ; $726e
	ld l, a ; $726f
	jr nc, .readB ; $7270
	inc h ; $7272
.readB:
	ld a, [hl+] ; $7273
	ld d, [hl] ; $7274
	ld e, a ; $7275
	ld hl, wDecompBuffer ; $7276
	push af ; $7279
	push bc ; $727a
	push de ; $727b
	push hl ; $727c
	ld bc, $0010 ; $727d
	call QueueVRAMCopy ; $7280
	pop hl ; $7283
	pop de ; $7284
	pop bc ; $7285
	pop af ; $7286
	ld a, c ; $7287
	inc a ; $7288
	ld c, a ; $7289
	call AdvanceFrame ; $728a
	ld a, c ; $728d
	cp $03 ; $728e
	jr nz, .loop ; $7290
	ld b, TILEBLOCK_N64RecordTypeGfx0 ; $7292
	ld c, N64RecordTypeGfx0_SIZE / 16 ; $7294
	ld de, vTiles0 + VRAM_BANK1 ; $7296
	farcall LoadCompressedTileBlock ; $7299
	call AdvanceFrame ; $729c
	ld b, TILEBLOCK_SharedMenuGfx29 ; $729f
	ld c, SharedMenuGfx29_SIZE / 16 ; $72a1
	ld de, vTiles0 + $10 * TILE_SIZE + VRAM_BANK1 ; $72a3
	farcall LoadCompressedTileBlock ; $72a6
	call AdvanceFrame ; $72a9
	ld b, TILEBLOCK_N64RecordTypeGfx1 ; $72ac
	ld c, N64RecordTypeGfx1_SIZE / 16 ; $72ae
	ld de, vTiles0 + $20 * TILE_SIZE + VRAM_BANK1 ; $72b0
	farcall LoadCompressedTileBlock ; $72b3
	call AdvanceFrame ; $72b6
	ld b, TILEBLOCK_SharedMenuGfx27 ; $72b9
	ld c, SharedMenuGfx27_SIZE / 16 ; $72bb
	ld de, vTiles0 + $70 * TILE_SIZE + VRAM_BANK1 ; $72bd
	farcall LoadCompressedTileBlock ; $72c0
	call AdvanceFrame ; $72c3
	ld b, TILEBLOCK_N64RecordTypeGfx2 ; $72c6
	ld c, N64RecordTypeGfx2_SIZE / 16 ; $72c8
	ld de, vTiles0 ; $72ca
	farcall LoadCompressedTileBlock ; $72cd
	call AdvanceFrame ; $72d0
	ld b, $08 ; $72d3
	ld c, $10 ; $72d5
	farcall LoadIndexedPalette ; $72d7
	pop_wram_bank ; $72da
	ret ; $72df
N64RecordTypeTable0:
	; $72e0, 6 bytes (bytes:2)
	db $78, $3c ; 0x00
	db $7a, $3c ; 0x02
	db $7c, $3c ; 0x04
N64RecordTypeTable1:
	; $72e6, 6 bytes (bytes:2)
	db $00, $a8 ; 0x00
	db $00, $a9 ; 0x02
	db $00, $aa ; 0x04
N64RecordTypeSlideIn:
	ld a, b ; $72ec
	or a ; $72ed
	jr z, .zero ; $72ee
	ld c, $00 ; $72f0
.loop:
	call AdvanceFrame ; $72f2
	ld b, $0a ; $72f5
	farcall RestoreMenuBgAndDrawPanel ; $72f7
	ld b, $03 ; $72fa
	farcall FlushWram3MapRows ; $72fc
	ld a, c ; $72ff
	inc a ; $7300
	ld c, a ; $7301
	cp $0d ; $7302
	jr nz, .loop ; $7304
	ret ; $7306
.zero:
	ld c, $0a ; $7307
.loopB:
	call AdvanceFrame ; $7309
	ld b, $0b ; $730c
	farcall RestoreMenuBgAndDrawPanel ; $730e
	ld b, $03 ; $7311
	farcall FlushWram3MapRows ; $7313
	ld a, c ; $7316
	dec a ; $7317
	ld c, a ; $7318
	cp $ff ; $7319
	jr nz, .loopB ; $731b
	ret ; $731d
N64RecordTypeSlideOut:
	ld a, b ; $731e
	or a ; $731f
	jr z, .slideIn ; $7320
	ld c, $00 ; $7322
.outLoop:
	call AdvanceFrame ; $7324
	ld b, $0b ; $7327
	farcall RestoreMenuBgAndDrawPanel ; $7329
	ld b, $03 ; $732c
	farcall FlushWram3MapRows ; $732e
	ld a, c ; $7331
	inc a ; $7332
	ld c, a ; $7333
	cp $0b ; $7334
	jr nz, .outLoop ; $7336
	ret ; $7338
.slideIn:
	ld c, $0c ; $7339
.inLoop:
	call AdvanceFrame ; $733b
	ld b, $0a ; $733e
	farcall RestoreMenuBgAndDrawPanel ; $7340
	ld b, $03 ; $7343
	farcall FlushWram3MapRows ; $7345
	ld a, c ; $7348
	dec a ; $7349
	ld c, a ; $734a
	or a ; $734b
	jr nz, .inLoop ; $734c
	ret ; $734e
N64RecordTypeCursorSpriteTask:
	farcall TickMenuBgScroll ; $734f
	ld c, $03 ; $7352
	call GetMenuCursorIndex_3b ; $7354
	push af ; $7357
	ld hl, N64RecordTypeCursorSpriteTaskTable1 ; $7358
	add l ; $735b
	ld l, a ; $735c
	jr nc, .read ; $735d
	inc h ; $735f
.read:
	ld c, [hl] ; $7360
	pop af ; $7361
	ld hl, N64RecordTypeCursorSpriteTaskTable0 ; $7362
	add a ; $7365
	add l ; $7366
	ld l, a ; $7367
	jr nc, .readB ; $7368
	inc h ; $736a
.readB:
	ld a, [hl+] ; $736b
	ld d, [hl] ; $736c
	ld e, a ; $736d
	farcall ApplySpriteBobOffset ; $736e
	ld b, $08 ; $7371
	ld hl, N64RecordTypeCursorSpriteTask_SpriteTemplate0 ; $7373
	push de ; $7376
	call QueueSpriteTemplate ; $7377
	pop de ; $737a
	ld hl, $17f8 ; $737b
	add hl, de ; $737e
	ld d, h ; $737f
	ld e, l ; $7380
	ld hl, N64RecordTypeCursorSpriteTask_SpriteTemplate1 ; $7381
	ld b, $08 ; $7384
	ld c, $70 ; $7386
	call QueueSpriteTemplate ; $7388
	ret ; $738b
N64RecordTypeCursorSpriteTask_SpriteTemplate0:
	; $738c, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
N64RecordTypeCursorSpriteTask_SpriteTemplate1:
	; $73ad, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
N64RecordTypeCursorSpriteTaskTable0:
	; $73b6, 6 bytes (bytes:6)
	db $50, $fc, $50, $2c, $50, $5c ; 0x00
N64RecordTypeCursorSpriteTaskTable1:
	; $73bc, 3 bytes (bytes:3)
	db $00, $10, $20 ; 0x00
DrawN64RecordTypeGrid:
	wram_bank $03 ; $73bf
	ld b, $00 ; $73c5
	ld c, $00 ; $73c7
.loop:
	call FillN64RecordTypeCell ; $73c9
	ld a, b ; $73cc
	inc a ; $73cd
	ld b, a ; $73ce
	cp $03 ; $73cf
	jr nz, .loop ; $73d1
	ld c, $03 ; $73d3
	call GetMenuCursorIndex_3b ; $73d5
	ld b, a ; $73d8
	ld c, $01 ; $73d9
	call FillN64RecordTypeCell ; $73db
	ld c, $03 ; $73de
	call GetMenuCursorIndex_3b ; $73e0
	call LoadN64RecordTypeCellPalette ; $73e3
	wram_bank $03 ; $73e6
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH ; $73ec
	ld b, $14 ; $73ef
	ld c, $01 ; $73f1
	ld h, $03 ; $73f3
	farcall FillTilemapRect ; $73f5
	ld a, $02 ; $73f8
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH], a ; $73fa
	ld a, $04 ; $73fd
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH + 19], a ; $73ff
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $7402
	ld b, $12 ; $7405
	ld c, $01 ; $7407
	ld h, $20 ; $7409
	farcall FillTilemapRect ; $740b
	call DrawN64RecordTypeCaption ; $740e
	ld hl, wShadowAttrmap + 7 * TILEMAP_WIDTH ; $7411
	ld de, vBGMap0 + 7 * TILEMAP_WIDTH + VRAM_BANK1 ; $7414
	ld c, $06 ; $7417
	call QueueVRAMCopy ; $7419
	ld hl, wShadowTilemap + 15 * TILEMAP_WIDTH ; $741c
	ld de, vBGMap0 + 15 * TILEMAP_WIDTH ; $741f
	ld c, $04 ; $7422
	call QueueVRAMCopy ; $7424
	ret ; $7427
FillN64RecordTypeCell:
	push af ; $7428
	push bc ; $7429
	push de ; $742a
	push hl ; $742b
	ld a, c ; $742c
	or a ; $742d
	jr z, .zero ; $742e
	ld h, $0c ; $7430
	jr .step2 ; $7432
.zero:
	ld h, $0d ; $7434
.step2:
	push hl ; $7436
	ld hl, FillN64RecordTypeCellTable ; $7437
	ld a, b ; $743a
	add a ; $743b
	add l ; $743c
	ld l, a ; $743d
	jr nc, .read ; $743e
	inc h ; $7440
.read:
	ld a, [hl+] ; $7441
	ld d, [hl] ; $7442
	ld e, a ; $7443
	pop hl ; $7444
	ld b, $05 ; $7445
	ld c, $03 ; $7447
	farcall FillTilemapRect ; $7449
	pop hl ; $744c
	pop de ; $744d
	pop bc ; $744e
	pop af ; $744f
	ret ; $7450
FillN64RecordTypeCellTable:
	; $7451, 12 bytes (ram_ptrs:3)
	dw wShadowAttrmap + 7 * TILEMAP_WIDTH + 1 ; record 0
	dw wShadowAttrmap + 7 * TILEMAP_WIDTH + 7 ; record 1
	dw wShadowAttrmap + 7 * TILEMAP_WIDTH + 13 ; record 2
	dw wShadowAttrmap + 11 * TILEMAP_WIDTH + 1 ; record 3
	dw wShadowAttrmap + 11 * TILEMAP_WIDTH + 7 ; record 4
	dw wShadowAttrmap + 11 * TILEMAP_WIDTH + 13 ; record 5
LoadN64RecordTypeCellPalette:
	ld hl, N64RecordTypeCellPalettePtrs ; $745d
	add a ; $7460
	add l ; $7461
	ld l, a ; $7462
	jr nc, .read ; $7463
	inc h ; $7465
.read:
	ld a, [hl+] ; $7466
	ld h, [hl] ; $7467
	ld l, a ; $7468
	lb de, $04, $01 ; $7469 palette index, count
	call LoadPaletteShadow ; $746c
	ret ; $746f
N64RecordTypeCellPalettePtrs:
	; $7470, 18 bytes (records:2)
	dw N64RecordTypeCellPalette0 ; record 0
	dw N64RecordTypeCellPalette2 ; record 1
	dw N64RecordTypeCellPalette1 ; record 2
	dw N64RecordTypeCellPalette0 ; record 3
	dw N64RecordTypeCellPalette0 ; record 4
	dw N64RecordTypeCellPalette0 ; record 5
	dw N64RecordTypeCellPalette0 ; record 6
	dw N64RecordTypeCellPalette0 ; record 7
	dw N64RecordTypeCellPalette0 ; record 8
N64RecordTypeCellPalette0:
	; $7482, 8 bytes (bytes:8)
	db $9f, $3e, $ff, $6b, $4a, $50, $00, $00 ; 0x00
N64RecordTypeCellPalette1:
	; $748a, 8 bytes (bytes:8)
	db $cc, $3a, $ff, $6b, $40, $65, $00, $00 ; 0x00
N64RecordTypeCellPalette2:
	; $7492, 8 bytes (bytes:8)
	db $32, $1b, $ff, $6b, $e0, $15, $00, $00 ; 0x00
DrawN64RecordTypeCaption:
	push_wram_bank $03 ; $749a
	ld c, $03 ; $74a3
	call GetMenuCursorIndex_3b ; $74a5
	ld b, a ; $74a8
	ld hl, $00cf ; $74a9
	add l ; $74ac
	ld l, a ; $74ad
	jr nc, .renderTextToBuffer64 ; $74ae
	inc h ; $74b0
.renderTextToBuffer64:
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $74b1
	ld c, $20 ; $74b4
	farcall RenderTextToBuffer64 ; $74b6
	pop_wram_bank ; $74b9
	ret ; $74be
RunN64TransferItemSelect:
	sound BGM_MENU ; $74bf
	ld hl, rIE ; $74c1
	res 2, [hl] ; $74c4
	call LoadN64TransferItemGfx ; $74c6
	wram_bank $03 ; $74c9
	ld a, [wMenuSlideDirection] ; $74cf
	ld b, a ; $74d2
	farcall OpenCourtSelect4Panel ; $74d3
	farcall InitMenuBgScroll ; $74d6
	ld b, $01 ; $74d9
	ld c, $01 ; $74db
	farcall LoadMenuSpritePalettePair ; $74dd
	ld a, [wN64TransferMenuCursor] ; $74e0
	ld c, a ; $74e3
	ld b, $02 ; $74e4
	call SetMenuCursorFromIndex_3b ; $74e6
	ld a, $01 ; $74e9
	ld hl, N64TransferItemCursorSpriteTask ; $74eb
	call RegisterFrameTask ; $74ee
	call DrawN64TransferItemGrid ; $74f1
	wram_bank $03 ; $74f4
.loop:
	call AdvanceFrame ; $74fa
	ldh a, [hInputPressed] ; $74fd
	ld [wMenuInputPressed], a ; $74ff
	ld b, $02 ; $7502
	ld c, $02 ; $7504
	call MoveMenuCursorGrid_3b ; $7506
	or a ; $7509
	jr z, .checkMenuInputPressed ; $750a
	sound SFX_MENU_MOVE ; $750c
	call DrawN64TransferItemGrid ; $750e
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $7511
	bit PADB_A, a ; $7514
	jr nz, .playSfx ; $7516
	bit 1, a ; $7518
	jr nz, .playSfx2 ; $751a
	jr .loop ; $751c
.playSfx:
	sound SFX_MENU_SELECT ; $751e
	call ClearFrameTasks ; $7520
	ld hl, rIE ; $7523
	set 2, [hl] ; $7526
	ld b, $01 ; $7528
	farcall CloseCourtSelect4Panel ; $752a
	ld a, MENUSLIDE_FORWARD ; $752d
	ld [wMenuSlideDirection], a ; $752f
	ld c, $02 ; $7532
	call GetMenuCursorIndex_3b ; $7534
	ld [wN64TransferMenuCursor], a ; $7537
	ret ; $753a
.playSfx2:
	sound SFX_MENU_CANCEL ; $753b
	call ClearFrameTasks ; $753d
	ld hl, rIE ; $7540
	set 2, [hl] ; $7543
	ld b, $00 ; $7545
	farcall CloseCourtSelect4Panel ; $7547
	ld a, MENUSLIDE_BACK ; $754a
	ld [wMenuSlideDirection], a ; $754c
	ld a, $ff ; $754f
	ret ; $7551
LoadN64TransferItemGfx:
	push_wram_bank $01 ; $7552
	ld c, $00 ; $755b
.loop:
	ld a, c ; $755d
	add a ; $755e
	ld hl, N64TransferItemTable0 ; $755f
	add l ; $7562
	ld l, a ; $7563
	jr nc, .read ; $7564
	inc h ; $7566
.read:
	ld a, [hl+] ; $7567
	ld h, [hl] ; $7568
	ld l, a ; $7569
	push af ; $756a
	push bc ; $756b
	push de ; $756c
	push hl ; $756d
	ld de, wDecompBuffer ; $756e
	call DecompressDataFromBank ; $7571
	pop hl ; $7574
	pop de ; $7575
	pop bc ; $7576
	pop af ; $7577
	ld hl, N64TransferItemTable1 ; $7578
	ld a, c ; $757b
	add a ; $757c
	add l ; $757d
	ld l, a ; $757e
	jr nc, .readB ; $757f
	inc h ; $7581
.readB:
	ld a, [hl+] ; $7582
	ld d, [hl] ; $7583
	ld e, a ; $7584
	ld hl, wDecompBuffer ; $7585
	push af ; $7588
	push bc ; $7589
	push de ; $758a
	push hl ; $758b
	ld bc, $0010 ; $758c
	call QueueVRAMCopy ; $758f
	pop hl ; $7592
	pop de ; $7593
	pop bc ; $7594
	pop af ; $7595
	ld a, c ; $7596
	inc a ; $7597
	ld c, a ; $7598
	call AdvanceFrame ; $7599
	ld a, c ; $759c
	cp $04 ; $759d
	jr nz, .loop ; $759f
	ld b, TILEBLOCK_N64TransferItemGfx0 ; $75a1
	ld c, N64TransferItemGfx0_SIZE / 16 ; $75a3
	ld de, vTiles0 + VRAM_BANK1 ; $75a5
	farcall LoadCompressedTileBlock ; $75a8
	call AdvanceFrame ; $75ab
	ld b, TILEBLOCK_N64TransferItemGfx4 ; $75ae
	ld c, N64TransferItemGfx4_SIZE / 16 ; $75b0
	ld de, vTiles0 + $10 * TILE_SIZE + VRAM_BANK1 ; $75b2
	farcall LoadCompressedTileBlock ; $75b5
	call AdvanceFrame ; $75b8
	ld b, TILEBLOCK_N64TransferItemGfx1 ; $75bb
	ld c, N64TransferItemGfx1_SIZE / 16 ; $75bd
	ld de, vTiles0 + $20 * TILE_SIZE + VRAM_BANK1 ; $75bf
	farcall LoadCompressedTileBlock ; $75c2
	call AdvanceFrame ; $75c5
	ld b, TILEBLOCK_N64TransferItemGfx2 ; $75c8
	ld c, N64TransferItemGfx2_SIZE / 16 ; $75ca
	ld de, vTiles0 + $30 * TILE_SIZE + VRAM_BANK1 ; $75cc
	farcall LoadCompressedTileBlock ; $75cf
	call AdvanceFrame ; $75d2
	ld b, TILEBLOCK_SharedMenuGfx27 ; $75d5
	ld c, SharedMenuGfx27_SIZE / 16 ; $75d7
	ld de, vTiles0 + $70 * TILE_SIZE + VRAM_BANK1 ; $75d9
	farcall LoadCompressedTileBlock ; $75dc
	call AdvanceFrame ; $75df
	ld b, TILEBLOCK_N64TransferItemGfx3 ; $75e2
	ld c, N64TransferItemGfx3_SIZE / 16 ; $75e4
	ld de, vTiles0 ; $75e6
	farcall LoadCompressedTileBlock ; $75e9
	call AdvanceFrame ; $75ec
	ld b, $08 ; $75ef
	ld c, $10 ; $75f1
	farcall LoadIndexedPalette ; $75f3
	pop_wram_bank ; $75f6
	ret ; $75fb
N64TransferItemTable0:
	; $75fc, 8 bytes (bytes:2)
	db $02, $3d ; 0x00
	db $06, $3d ; 0x02
	db $00, $3d ; 0x04
	db $04, $3d ; 0x06
N64TransferItemTable1:
	; $7604, 8 bytes (bytes:2)
	db $00, $a8 ; 0x00
	db $00, $a9 ; 0x02
	db $00, $aa ; 0x04
	db $00, $ab ; 0x06
DrawN64TransferItemGrid:
	wram_bank $03 ; $760c
	ld b, $00 ; $7612
	ld c, $00 ; $7614
.loop:
	farcall SetCourtSelect4TabAttrRect ; $7616
	ld a, b ; $7619
	inc a ; $761a
	ld b, a ; $761b
	cp $04 ; $761c
	jr nz, .loop ; $761e
	ld c, $02 ; $7620
	call GetMenuCursorIndex_3b ; $7622
	ld b, a ; $7625
	ld c, $01 ; $7626
	farcall SetCourtSelect4TabAttrRect ; $7628
	ld c, $02 ; $762b
	call GetMenuCursorIndex_3b ; $762d
	call LoadN64TransferItemCellPalette ; $7630
	wram_bank $03 ; $7633
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH ; $7639
	ld b, $14 ; $763c
	ld c, $01 ; $763e
	ld h, $03 ; $7640
	farcall FillTilemapRect ; $7642
	ld a, $02 ; $7645
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH], a ; $7647
	ld a, $04 ; $764a
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH + 19], a ; $764c
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $764f
	ld b, $12 ; $7652
	ld c, $01 ; $7654
	ld h, $20 ; $7656
	farcall FillTilemapRect ; $7658
	call DrawN64TransferItemCaption ; $765b
	ld hl, wShadowAttrmap + 4 * TILEMAP_WIDTH ; $765e
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH + VRAM_BANK1 ; $7661
	ld c, $06 ; $7664
	call QueueVRAMCopy ; $7666
	ld hl, wShadowAttrmap + 9 * TILEMAP_WIDTH ; $7669
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH + VRAM_BANK1 ; $766c
	ld c, $06 ; $766f
	call QueueVRAMCopy ; $7671
	ld hl, wShadowTilemap + 15 * TILEMAP_WIDTH ; $7674
	ld de, vBGMap0 + 15 * TILEMAP_WIDTH ; $7677
	ld c, $04 ; $767a
	call QueueVRAMCopy ; $767c
	ret ; $767f
LoadN64TransferItemCellPalette:
	ld hl, N64TransferItemCellPalettePtrs ; $7680
	add a ; $7683
	add l ; $7684
	ld l, a ; $7685
	jr nc, .read ; $7686
	inc h ; $7688
.read:
	ld a, [hl+] ; $7689
	ld h, [hl] ; $768a
	ld l, a ; $768b
	lb de, $04, $01 ; $768c palette index, count
	call LoadPaletteShadow ; $768f
	ret ; $7692
N64TransferItemCellPalettePtrs:
	; $7693, 18 bytes (records:2)
	dw N64TransferItemCellPalette0 ; record 0
	dw N64TransferItemCellPalette3 ; record 1
	dw N64TransferItemCellPalette1 ; record 2
	dw N64TransferItemCellPalette2 ; record 3
	dw N64TransferItemCellPalette2 ; record 4
	dw N64TransferItemCellPalette0 ; record 5
	dw N64TransferItemCellPalette0 ; record 6
	dw N64TransferItemCellPalette0 ; record 7
	dw N64TransferItemCellPalette0 ; record 8
N64TransferItemCellPalette0:
	; $76a5, 8 bytes (bytes:8)
	db $9f, $5a, $ff, $6b, $1f, $00, $00, $00 ; 0x00
N64TransferItemCellPalette1:
	; $76ad, 8 bytes (bytes:8)
	db $cc, $3a, $ff, $6b, $40, $65, $00, $00 ; 0x00
N64TransferItemCellPalette2:
	; $76b5, 8 bytes (bytes:8)
	db $ff, $29, $ff, $6b, $4a, $50, $00, $00 ; 0x00
N64TransferItemCellPalette3:
	; $76bd, 8 bytes (bytes:8)
	db $bf, $02, $ff, $6b, $57, $05, $00, $00 ; 0x00
DrawN64TransferItemCaption:
	push_wram_bank $03 ; $76c5
	ld c, $02 ; $76ce
	call GetMenuCursorIndex_3b ; $76d0
	ld b, a ; $76d3
	ld hl, $00d2 ; $76d4
	add l ; $76d7
	ld l, a ; $76d8
	jr nc, .renderTextToBuffer64 ; $76d9
	inc h ; $76db
.renderTextToBuffer64:
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $76dc
	ld c, $20 ; $76df
	farcall RenderTextToBuffer64 ; $76e1
	pop_wram_bank ; $76e4
	ret ; $76e9
N64TransferItemCursorSpriteTask:
	farcall TickMenuBgScroll ; $76ea
	ld c, $02 ; $76ed
	call GetMenuCursorIndex_3b ; $76ef
	push af ; $76f2
	ld hl, N64TransferItemCursorSpriteTaskTable1 ; $76f3
	add l ; $76f6
	ld l, a ; $76f7
	jr nc, .read ; $76f8
	inc h ; $76fa
.read:
	ld c, [hl] ; $76fb
	pop af ; $76fc
	ld hl, N64TransferItemCursorSpriteTaskTable0 ; $76fd
	add a ; $7700
	add l ; $7701
	ld l, a ; $7702
	jr nc, .readB ; $7703
	inc h ; $7705
.readB:
	ld a, [hl+] ; $7706
	ld d, [hl] ; $7707
	ld e, a ; $7708
	farcall ApplySpriteBobOffset ; $7709
	ld b, $08 ; $770c
	ld hl, N64TransferItemCursorSpriteTask_SpriteTemplate0 ; $770e
	push de ; $7711
	call QueueSpriteTemplate ; $7712
	pop de ; $7715
	ld hl, $17f8 ; $7716
	add hl, de ; $7719
	ld d, h ; $771a
	ld e, l ; $771b
	ld hl, N64TransferItemCursorSpriteTask_SpriteTemplate1 ; $771c
	ld b, $08 ; $771f
	ld c, $70 ; $7721
	call QueueSpriteTemplate ; $7723
	ret ; $7726
N64TransferItemCursorSpriteTask_SpriteTemplate0:
	; $7727, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
N64TransferItemCursorSpriteTask_SpriteTemplate1:
	; $7748, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
N64TransferItemCursorSpriteTaskTable0:
	; $7751, 8 bytes (bytes:8)
	db $38, $14, $38, $4c, $60, $14, $60, $4a ; 0x00
N64TransferItemCursorSpriteTaskTable1:
	; $7759, 4 bytes (bytes:4)
	db $00, $10, $20, $30 ; 0x00
