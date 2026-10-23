EraseAllDataPalette:
	INCLUDE "data/engine/menus/main_menu/EraseAllDataPalette.asm" ; $70f0, 8 bytes (palettes)
EraseN64DataPalette:
	INCLUDE "data/engine/menus/main_menu/EraseN64DataPalette.asm" ; $70f8, 8 bytes (palettes)
DrawEraseSavedDataCaption:
	push_wram_bank WRAM_SCREEN ; $7100
	ld c, $03 ; $7109
	call GetMenuCursorIndex_3b ; $710b
	ld b, a ; $710e
	cp $03 ; $710f
	jp nc, .nonSlotItem ; $7111
	add a ; $7114
	add a ; $7115
	add a ; $7116
	add a ; $7117
	ld bc, wSaveSlotSummaries ; $7118
	add_bc_a ; $711b
	ld hl, SLOTSUM_CHAR ; $7120
	add hl, bc ; $7123
	ld a, [hl] ; $7124
	cp CHAR_EMPTY_SLOT ; $7125
	jr z, .emptySlot ; $7127
	ld hl, SLOTSUM_NAME ; $7129
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
	ld hl, SLOTSUM_LEVEL ; $7141
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
	ld hl, SLOTSUM_HOURS ; $715a
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
	ld hl, SLOTSUM_MINUTES ; $716f
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
.emptySlot:
	ld hl, Text_EraseCaptionNoDataInFile ; $718b
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $718e
	ld c, $20 ; $7191
	farcall RenderTextToBuffer64 ; $7193
	jr .restore ; $7196
.nonSlotItem:
	ld hl, Text_EraseN64DataCaption ; $7198
	sub $03 ; $719b
	add_hl_a ; $719d
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $71a2
	ld c, $20 ; $71a5
	farcall RenderTextToBuffer64 ; $71a7
.restore:
	pop_wram_bank ; $71aa
	ret ; $71af
RunN64RecordTypeSelect:
	sound BGM_MENU ; $71b0
	ld hl, rIE ; $71b2
	res B_IE_TIMER, [hl] ; $71b5
	call LoadN64RecordTypeGfx ; $71b7
	farcall InitMenuTitleScroller ; $71ba
	ld b, $01 ; $71bd
	ld c, $01 ; $71bf
	farcall LoadMenuSpritePalettePair ; $71c1
	wram_bank WRAM_SCREEN ; $71c4
	ld a, [wMenuSlideDirection] ; $71ca
	ld b, a ; $71cd
	call ThreeChoiceSlideIn ; $71ce
	ld a, [wSubMenuCursor] ; $71d1
	ld c, a ; $71d4
	ld b, $03 ; $71d5
	call SetMenuCursorFromIndex_3b ; $71d7
	frame_task N64RecordTypeCursorSpriteTask ; $71da
	call DrawN64RecordTypeGrid ; $71e2
	wram_bank WRAM_SCREEN ; $71e5
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
	jr nz, .playSelectSfx ; $7207
	bit PADB_B, a ; $7209
	jr nz, .playCancelSfx ; $720b
	jr .loop ; $720d
.playSelectSfx:
	sound SFX_MENU_SELECT ; $720f
	call ClearFrameTasks ; $7211
	ld hl, rIE ; $7214
	set B_IE_TIMER, [hl] ; $7217
	ld b, MENUSLIDE_FORWARD ; $7219
	call ThreeChoiceSlideOut ; $721b
	ld a, MENUSLIDE_FORWARD ; $721e
	ld [wMenuSlideDirection], a ; $7220
	ld c, $03 ; $7223
	call GetMenuCursorIndex_3b ; $7225
	ld [wSubMenuCursor], a ; $7228
	ret ; $722b
.playCancelSfx:
	sound SFX_MENU_CANCEL ; $722c
	call ClearFrameTasks ; $722e
	ld hl, rIE ; $7231
	set B_IE_TIMER, [hl] ; $7234
	ld b, MENUSLIDE_BACK ; $7236
	call ThreeChoiceSlideOut ; $7238
	ld a, MENUSLIDE_BACK ; $723b
	ld [wMenuSlideDirection], a ; $723d
	ld a, $ff ; $7240
	ret ; $7242
LoadN64RecordTypeGfx:
	push_wram_bank WRAM_STAGING ; $7243
	ld c, $00 ; $724c
.loop:
	ld a, c ; $724e
	add a ; $724f
	ld hl, N64RecordTypeIconTilePtrs ; $7250
	add_hl_a ; $7253
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
	ld hl, N64RecordTypeIconTileVramDests ; $7269
	ld a, c ; $726c
	add a ; $726d
	add_hl_a ; $726e
	ld a, [hl+] ; $7273
	ld d, [hl] ; $7274
	ld e, a ; $7275
	ld hl, wDecompBuffer ; $7276
	push af ; $7279
	push bc ; $727a
	push de ; $727b
	push hl ; $727c
	ld bc, 16 ; $727d
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
	ld b, TILEBLOCK_TournamentLabelGfx ; $7292
	ld c, TournamentLabelGfx_SIZE / 16 ; $7294
	ld de, vTiles0 + VRAM_BANK1 ; $7296
	farcall LoadCompressedTileBlock ; $7299
	call AdvanceFrame ; $729c
	ld b, TILEBLOCK_ExhibitionLabelGfx ; $729f
	ld c, ExhibitionLabelGfx_SIZE / 16 ; $72a1
	ld de, vTiles0 tile $10 + VRAM_BANK1 ; $72a3
	farcall LoadCompressedTileBlock ; $72a6
	call AdvanceFrame ; $72a9
	ld b, TILEBLOCK_RingShotLabelGfx ; $72ac
	ld c, RingShotLabelGfx_SIZE / 16 ; $72ae
	ld de, vTiles0 tile $20 + VRAM_BANK1 ; $72b0
	farcall LoadCompressedTileBlock ; $72b3
	call AdvanceFrame ; $72b6
	ld b, TILEBLOCK_SharedMenuGfx27 ; $72b9
	ld c, SharedMenuGfx27_SIZE / 16 ; $72bb
	ld de, vTiles0 tile $70 + VRAM_BANK1 ; $72bd
	farcall LoadCompressedTileBlock ; $72c0
	call AdvanceFrame ; $72c3
	ld b, TILEBLOCK_N64DataTitleGfx ; $72c6
	ld c, N64DataTitleGfx_SIZE / 16 ; $72c8
	ld de, vTiles0 ; $72ca
	farcall LoadCompressedTileBlock ; $72cd
	call AdvanceFrame ; $72d0
	ld b, $08 ; $72d3
	ld c, $10 ; $72d5
	farcall LoadIndexedPalette ; $72d7
	pop_wram_bank ; $72da
	ret ; $72df
N64RecordTypeIconTilePtrs:
	; $72e0, 3 slot words
	dslot DataPtr_TournamentIconTiles ; record 0
	dslot DataPtr_ExhibitionIconTiles ; record 1
	dslot DataPtr_RingShotIconTiles ; record 2
N64RecordTypeIconTileVramDests:
	; $72e6, 6 bytes (records:2)
	dw vTiles1 + VRAM_BANK1 ; record 0
	dw vTiles1 tile $10 + VRAM_BANK1 ; record 1
	dw vTiles1 tile $20 + VRAM_BANK1 ; record 2
ThreeChoiceSlideIn:
	ld a, b ; $72ec
	or a ; $72ed
	jr z, .slideBack ; $72ee
	ld c, $00 ; $72f0
.slideForwardLoop:
	call AdvanceFrame ; $72f2
	ld b, PANELANIM_THREE_CHOICE_IN ; $72f5
	farcall RestoreMenuBgAndDrawPanel ; $72f7
	ld b, MAPROWS_BAND_7 ; $72fa
	farcall FlushWram3MapRows ; $72fc
	ld a, c ; $72ff
	inc a ; $7300
	ld c, a ; $7301
	cp $0d ; $7302
	jr nz, .slideForwardLoop ; $7304
	ret ; $7306
.slideBack:
	ld c, $0a ; $7307
.slideBackLoop:
	call AdvanceFrame ; $7309
	ld b, PANELANIM_THREE_CHOICE_OUT ; $730c
	farcall RestoreMenuBgAndDrawPanel ; $730e
	ld b, MAPROWS_BAND_7 ; $7311
	farcall FlushWram3MapRows ; $7313
	ld a, c ; $7316
	dec a ; $7317
	ld c, a ; $7318
	cp $ff ; $7319
	jr nz, .slideBackLoop ; $731b
	ret ; $731d
ThreeChoiceSlideOut:
	ld a, b ; $731e
	or a ; $731f
	jr z, .slideBack ; $7320
	ld c, $00 ; $7322
.slideForwardLoop:
	call AdvanceFrame ; $7324
	ld b, PANELANIM_THREE_CHOICE_OUT ; $7327
	farcall RestoreMenuBgAndDrawPanel ; $7329
	ld b, MAPROWS_BAND_7 ; $732c
	farcall FlushWram3MapRows ; $732e
	ld a, c ; $7331
	inc a ; $7332
	ld c, a ; $7333
	cp $0b ; $7334
	jr nz, .slideForwardLoop ; $7336
	ret ; $7338
.slideBack:
	ld c, $0c ; $7339
.slideBackLoop:
	call AdvanceFrame ; $733b
	ld b, PANELANIM_THREE_CHOICE_IN ; $733e
	farcall RestoreMenuBgAndDrawPanel ; $7340
	ld b, MAPROWS_BAND_7 ; $7343
	farcall FlushWram3MapRows ; $7345
	ld a, c ; $7348
	dec a ; $7349
	ld c, a ; $734a
	or a ; $734b
	jr nz, .slideBackLoop ; $734c
	ret ; $734e
N64RecordTypeCursorSpriteTask:
	farcall TickMenuTitleScroller ; $734f
	ld c, $03 ; $7352
	call GetMenuCursorIndex_3b ; $7354
	push af ; $7357
	ld hl, N64RecordTypeCursorTileBases ; $7358
	add_hl_a ; $735b
	ld c, [hl] ; $7360
	pop af ; $7361
	ld hl, N64RecordTypeCursorPositions ; $7362
	add a ; $7365
	add_hl_a ; $7366
	ld a, [hl+] ; $736b
	ld d, [hl] ; $736c
	ld e, a ; $736d
	farcall ApplySpriteBobOffset ; $736e
	ld b, OAM_BANK1 ; $7371
	ld hl, N64RecordTypeLabelTemplate ; $7373
	push de ; $7376
	call QueueSpriteTemplate ; $7377
	pop de ; $737a
	ld hl, $17f8 ; $737b
	add hl, de ; $737e
	ld d, h ; $737f
	ld e, l ; $7380
	ld hl, N64RecordTypeLabelTailTemplate ; $7381
	sprite_attr_tile OAM_BANK1, $70 ; $7384
	call QueueSpriteTemplate ; $7388
	ret ; $738b
N64RecordTypeLabelTemplate:
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
N64RecordTypeLabelTailTemplate:
	; $73ad, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
N64RecordTypeCursorPositions:
	; $73b6, 6 bytes (bytes:6)
	db $50, $fc, $50, $2c, $50, $5c ; 0x00
N64RecordTypeCursorTileBases:
	; $73bc, 3 bytes (bytes:3)
	db $00, $10, $20 ; 0x00
DrawN64RecordTypeGrid:
	wram_bank WRAM_SCREEN ; $73bf
	ld b, $00 ; $73c5
	ld c, ATTRRECT_INACTIVE ; $73c7
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
	ld c, ATTRRECT_SELECTED ; $73d9
	call FillN64RecordTypeCell ; $73db
	ld c, $03 ; $73de
	call GetMenuCursorIndex_3b ; $73e0
	call LoadN64RecordTypeCellPalette ; $73e3
	wram_bank WRAM_SCREEN ; $73e6
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH ; $73ec
	rect_size $14, $01 ; $73ef
	ld h, $03 ; $73f3
	farcall FillTilemapRect ; $73f5
	ld a, $02 ; $73f8
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH], a ; $73fa
	ld a, $04 ; $73fd
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH + 19], a ; $73ff
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $7402
	rect_size $12, $01 ; $7405
	ld h, $20 ; $7409
	farcall FillTilemapRect ; $740b
	call DrawN64RecordTypeCaption ; $740e
	ld hl, wShadowAttrmap + 7 * TILEMAP_WIDTH ; $7411
	ld de, vBGMap0 + 7 * TILEMAP_WIDTH + VRAM_BANK1 ; $7414
	ld c, 3 * TILEMAP_WIDTH / 16 ; $7417
	call QueueVRAMCopy ; $7419
	ld hl, wShadowTilemap + 15 * TILEMAP_WIDTH ; $741c
	ld de, vBGMap0 + 15 * TILEMAP_WIDTH ; $741f
	ld c, 2 * TILEMAP_WIDTH / 16 ; $7422
	call QueueVRAMCopy ; $7424
	ret ; $7427
FillN64RecordTypeCell:
	push af ; $7428
	push bc ; $7429
	push de ; $742a
	push hl ; $742b
	ld a, c ; $742c
	or a ; $742d
	jr z, .unhighlighted ; $742e
	ld h, $0c ; $7430
	jr .fill ; $7432
.unhighlighted:
	ld h, $0d ; $7434
.fill:
	push hl ; $7436
	ld hl, FillN64RecordTypeCellTable ; $7437
	ld a, b ; $743a
	add a ; $743b
	add_hl_a ; $743c
	ld a, [hl+] ; $7441
	ld d, [hl] ; $7442
	ld e, a ; $7443
	pop hl ; $7444
	rect_size $05, $03 ; $7445
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
	add_hl_a ; $7461
	ld a, [hl+] ; $7466
	ld h, [hl] ; $7467
	ld l, a ; $7468
	ld_bg_pals de, 4, 1 ; $7469
	call LoadPaletteShadow ; $746c
	ret ; $746f
N64RecordTypeCellPalettePtrs:
	; $7470, 18 bytes (records:2)
	dw N64RecordTournamentPalette ; record 0
	dw N64RecordExhibitionPalette ; record 1
	dw N64RecordRingShotPalette ; record 2
	dw N64RecordTournamentPalette ; record 3
	dw N64RecordTournamentPalette ; record 4
	dw N64RecordTournamentPalette ; record 5
	dw N64RecordTournamentPalette ; record 6
	dw N64RecordTournamentPalette ; record 7
	dw N64RecordTournamentPalette ; record 8
N64RecordTournamentPalette:
	INCLUDE "data/engine/menus/main_menu/N64RecordTournamentPalette.asm" ; $7482, 8 bytes (palettes)
N64RecordRingShotPalette:
	INCLUDE "data/engine/menus/main_menu/N64RecordRingShotPalette.asm" ; $748a, 8 bytes (palettes)
N64RecordExhibitionPalette:
	INCLUDE "data/engine/menus/main_menu/N64RecordExhibitionPalette.asm" ; $7492, 8 bytes (palettes)
DrawN64RecordTypeCaption:
	push_wram_bank WRAM_SCREEN ; $749a
	ld c, $03 ; $74a3
	call GetMenuCursorIndex_3b ; $74a5
	ld b, a ; $74a8
	ld hl, Text_N64TournamentData ; $74a9
	add_hl_a ; $74ac
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $74b1
	ld c, $20 ; $74b4
	farcall RenderTextToBuffer64 ; $74b6
	pop_wram_bank ; $74b9
	ret ; $74be
RunGbDataItemSelect:
	sound BGM_MENU ; $74bf
	ld hl, rIE ; $74c1
	res B_IE_TIMER, [hl] ; $74c4
	call LoadGbDataItemGfx ; $74c6
	wram_bank WRAM_SCREEN ; $74c9
	ld a, [wMenuSlideDirection] ; $74cf
	ld b, a ; $74d2
	farcall OpenCourtSelect4Panel ; $74d3
	farcall InitMenuTitleScroller ; $74d6
	ld b, $01 ; $74d9
	ld c, $01 ; $74db
	farcall LoadMenuSpritePalettePair ; $74dd
	ld a, [wGbDataMenuCursor] ; $74e0
	ld c, a ; $74e3
	ld b, $02 ; $74e4
	call SetMenuCursorFromIndex_3b ; $74e6
	frame_task GbDataItemCursorSpriteTask ; $74e9
	call DrawGbDataItemGrid ; $74f1
	wram_bank WRAM_SCREEN ; $74f4
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
	call DrawGbDataItemGrid ; $750e
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $7511
	bit PADB_A, a ; $7514
	jr nz, .playSelectSfx ; $7516
	bit PADB_B, a ; $7518
	jr nz, .playCancelSfx ; $751a
	jr .loop ; $751c
.playSelectSfx:
	sound SFX_MENU_SELECT ; $751e
	call ClearFrameTasks ; $7520
	ld hl, rIE ; $7523
	set B_IE_TIMER, [hl] ; $7526
	ld b, MENUSLIDE_FORWARD ; $7528
	farcall CloseCourtSelect4Panel ; $752a
	ld a, MENUSLIDE_FORWARD ; $752d
	ld [wMenuSlideDirection], a ; $752f
	ld c, $02 ; $7532
	call GetMenuCursorIndex_3b ; $7534
	ld [wGbDataMenuCursor], a ; $7537
	ret ; $753a
.playCancelSfx:
	sound SFX_MENU_CANCEL ; $753b
	call ClearFrameTasks ; $753d
	ld hl, rIE ; $7540
	set B_IE_TIMER, [hl] ; $7543
	ld b, MENUSLIDE_BACK ; $7545
	farcall CloseCourtSelect4Panel ; $7547
	ld a, MENUSLIDE_BACK ; $754a
	ld [wMenuSlideDirection], a ; $754c
	ld a, $ff ; $754f
	ret ; $7551
LoadGbDataItemGfx:
	push_wram_bank WRAM_STAGING ; $7552
	ld c, $00 ; $755b
.loop:
	ld a, c ; $755d
	add a ; $755e
	ld hl, GbDataItemIconTilePtrs ; $755f
	add_hl_a ; $7562
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
	ld hl, GbDataItemIconTileVramDests ; $7578
	ld a, c ; $757b
	add a ; $757c
	add_hl_a ; $757d
	ld a, [hl+] ; $7582
	ld d, [hl] ; $7583
	ld e, a ; $7584
	ld hl, wDecompBuffer ; $7585
	push af ; $7588
	push bc ; $7589
	push de ; $758a
	push hl ; $758b
	ld bc, 16 ; $758c
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
	ld b, TILEBLOCK_CharacterDataLabelGfx ; $75a1
	ld c, CharacterDataLabelGfx_SIZE / 16 ; $75a3
	ld de, vTiles0 + VRAM_BANK1 ; $75a5
	farcall LoadCompressedTileBlock ; $75a8
	call AdvanceFrame ; $75ab
	ld b, TILEBLOCK_ClearStatusLabelGfx ; $75ae
	ld c, ClearStatusLabelGfx_SIZE / 16 ; $75b0
	ld de, vTiles0 tile $10 + VRAM_BANK1 ; $75b2
	farcall LoadCompressedTileBlock ; $75b5
	call AdvanceFrame ; $75b8
	ld b, TILEBLOCK_N64TournamentsLabelGfx ; $75bb
	ld c, N64TournamentsLabelGfx_SIZE / 16 ; $75bd
	ld de, vTiles0 tile $20 + VRAM_BANK1 ; $75bf
	farcall LoadCompressedTileBlock ; $75c2
	call AdvanceFrame ; $75c5
	ld b, TILEBLOCK_SetItemsLabelGfx ; $75c8
	ld c, SetItemsLabelGfx_SIZE / 16 ; $75ca
	ld de, vTiles0 tile $30 + VRAM_BANK1 ; $75cc
	farcall LoadCompressedTileBlock ; $75cf
	call AdvanceFrame ; $75d2
	ld b, TILEBLOCK_SharedMenuGfx27 ; $75d5
	ld c, SharedMenuGfx27_SIZE / 16 ; $75d7
	ld de, vTiles0 tile $70 + VRAM_BANK1 ; $75d9
	farcall LoadCompressedTileBlock ; $75dc
	call AdvanceFrame ; $75df
	ld b, TILEBLOCK_GbDataTitleGfx ; $75e2
	ld c, GbDataTitleGfx_SIZE / 16 ; $75e4
	ld de, vTiles0 ; $75e6
	farcall LoadCompressedTileBlock ; $75e9
	call AdvanceFrame ; $75ec
	ld b, $08 ; $75ef
	ld c, $10 ; $75f1
	farcall LoadIndexedPalette ; $75f3
	pop_wram_bank ; $75f6
	ret ; $75fb
GbDataItemIconTilePtrs:
	; $75fc, 4 slot words
	dslot DataPtr_CharacterDataIconTiles ; record 0
	dslot DataPtr_ClearStatusIconTiles ; record 1
	dslot DataPtr_N64TournamentsIconTiles ; record 2
	dslot DataPtr_SetItemsIconTiles ; record 3
GbDataItemIconTileVramDests:
	; $7604, 8 bytes (records:2)
	dw vTiles1 + VRAM_BANK1 ; record 0
	dw vTiles1 tile $10 + VRAM_BANK1 ; record 1
	dw vTiles1 tile $20 + VRAM_BANK1 ; record 2
	dw vTiles1 tile $30 + VRAM_BANK1 ; record 3
DrawGbDataItemGrid:
	wram_bank WRAM_SCREEN ; $760c
	ld b, $00 ; $7612
	ld c, ATTRRECT_INACTIVE ; $7614
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
	ld c, ATTRRECT_SELECTED ; $7626
	farcall SetCourtSelect4TabAttrRect ; $7628
	ld c, $02 ; $762b
	call GetMenuCursorIndex_3b ; $762d
	call LoadGbDataItemCellPalette ; $7630
	wram_bank WRAM_SCREEN ; $7633
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH ; $7639
	rect_size $14, $01 ; $763c
	ld h, $03 ; $7640
	farcall FillTilemapRect ; $7642
	ld a, $02 ; $7645
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH], a ; $7647
	ld a, $04 ; $764a
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH + 19], a ; $764c
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $764f
	rect_size $12, $01 ; $7652
	ld h, $20 ; $7656
	farcall FillTilemapRect ; $7658
	call DrawGbDataItemCaption ; $765b
	ld hl, wShadowAttrmap + 4 * TILEMAP_WIDTH ; $765e
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH + VRAM_BANK1 ; $7661
	ld c, 3 * TILEMAP_WIDTH / 16 ; $7664
	call QueueVRAMCopy ; $7666
	ld hl, wShadowAttrmap + 9 * TILEMAP_WIDTH ; $7669
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH + VRAM_BANK1 ; $766c
	ld c, 3 * TILEMAP_WIDTH / 16 ; $766f
	call QueueVRAMCopy ; $7671
	ld hl, wShadowTilemap + 15 * TILEMAP_WIDTH ; $7674
	ld de, vBGMap0 + 15 * TILEMAP_WIDTH ; $7677
	ld c, 2 * TILEMAP_WIDTH / 16 ; $767a
	call QueueVRAMCopy ; $767c
	ret ; $767f
LoadGbDataItemCellPalette:
	ld hl, GbDataItemCellPalettePtrs ; $7680
	add a ; $7683
	add_hl_a ; $7684
	ld a, [hl+] ; $7689
	ld h, [hl] ; $768a
	ld l, a ; $768b
	ld_bg_pals de, 4, 1 ; $768c
	call LoadPaletteShadow ; $768f
	ret ; $7692
GbDataItemCellPalettePtrs:
	; $7693, 18 bytes (records:2)
	dw GbDataCharacterDataPalette ; record 0
	dw GbDataClearStatusPalette ; record 1
	dw GbDataN64TournamentsPalette ; record 2
	dw GbDataSetItemsPalette ; record 3
	dw GbDataSetItemsPalette ; record 4
	dw GbDataCharacterDataPalette ; record 5
	dw GbDataCharacterDataPalette ; record 6
	dw GbDataCharacterDataPalette ; record 7
	dw GbDataCharacterDataPalette ; record 8
GbDataCharacterDataPalette:
	INCLUDE "data/engine/menus/main_menu/GbDataCharacterDataPalette.asm" ; $76a5, 8 bytes (palettes)
GbDataN64TournamentsPalette:
	INCLUDE "data/engine/menus/main_menu/GbDataN64TournamentsPalette.asm" ; $76ad, 8 bytes (palettes)
GbDataSetItemsPalette:
	INCLUDE "data/engine/menus/main_menu/GbDataSetItemsPalette.asm" ; $76b5, 8 bytes (palettes)
GbDataClearStatusPalette:
	INCLUDE "data/engine/menus/main_menu/GbDataClearStatusPalette.asm" ; $76bd, 8 bytes (palettes)
DrawGbDataItemCaption:
	push_wram_bank WRAM_SCREEN ; $76c5
	ld c, $02 ; $76ce
	call GetMenuCursorIndex_3b ; $76d0
	ld b, a ; $76d3
	ld hl, Text_GbDataCharPartnerData ; $76d4
	add_hl_a ; $76d7
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $76dc
	ld c, $20 ; $76df
	farcall RenderTextToBuffer64 ; $76e1
	pop_wram_bank ; $76e4
	ret ; $76e9
GbDataItemCursorSpriteTask:
	farcall TickMenuTitleScroller ; $76ea
	ld c, $02 ; $76ed
	call GetMenuCursorIndex_3b ; $76ef
	push af ; $76f2
	ld hl, GbDataItemCursorTileBases ; $76f3
	add_hl_a ; $76f6
	ld c, [hl] ; $76fb
	pop af ; $76fc
	ld hl, GbDataItemCursorPositions ; $76fd
	add a ; $7700
	add_hl_a ; $7701
	ld a, [hl+] ; $7706
	ld d, [hl] ; $7707
	ld e, a ; $7708
	farcall ApplySpriteBobOffset ; $7709
	ld b, OAM_BANK1 ; $770c
	ld hl, GbDataItemLabelTemplate ; $770e
	push de ; $7711
	call QueueSpriteTemplate ; $7712
	pop de ; $7715
	ld hl, $17f8 ; $7716
	add hl, de ; $7719
	ld d, h ; $771a
	ld e, l ; $771b
	ld hl, GbDataItemLabelTailTemplate ; $771c
	sprite_attr_tile OAM_BANK1, $70 ; $771f
	call QueueSpriteTemplate ; $7723
	ret ; $7726
GbDataItemLabelTemplate:
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
GbDataItemLabelTailTemplate:
	; $7748, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
GbDataItemCursorPositions:
	; $7751, 8 bytes (bytes:8)
	db $38, $14, $38, $4c, $60, $14, $60, $4a ; 0x00
GbDataItemCursorTileBases:
	; $7759, 4 bytes (bytes:4)
	db $00, $10, $20, $30 ; 0x00
