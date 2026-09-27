ShowGameProgressScreen:
	push de ; $7263
	ld de, SAVEFLAG_COURT_STAR ; $7264
	farcall TestSaveFlag ; $7267
	pop de ; $726a
	jr z, .setFlag ; $726b
	set_flag FLAG_TEMP_PROGRESS_SCREEN_OPEN ; $726d
.setFlag:
	set_flag FLAG_TEMP_WIDE_GLYPH_STREAM ; $7270
	call BuildGameProgressScreen ; $7273
	clear_flag FLAG_TEMP_WIDE_GLYPH_STREAM ; $7276
	call ClearFrameTasks ; $7279
	ret ; $727c
InitGameProgressScreen:
	sound BGM_STATUS_SCREEN ; $727d
	call ClearFrameTasks ; $727f
	call ClearSpriteQueue ; $7282
	xor a ; $7285
	ldh [hScrollX], a ; $7286
	ldh [hScrollY], a ; $7288
	farcall ResetTextWindowState ; $728a
	ld de, wWindowShadowTilemap ; $728d
	ld hl, wShadowTilemapPtr ; $7290
	ld a, e ; $7293
	ld [hl+], a ; $7294
	ld [hl], d ; $7295
	ld a, $05 ; $7296
	ld [wShadowTilemapBank], a ; $7298
	ld a, $00 ; $729b
	ld [wWindowTileAttr], a ; $729d
	ld [wMenuWindowId], a ; $72a0
	ld a, $ff ; $72a3
	ld c, $30 ; $72a5
	ld hl, wProgressVisibleEntries ; $72a7
.loop:
	ld [hl+], a ; $72aa
	dec c ; $72ab
	jr nz, .loop ; $72ac
	ret ; $72ae
BuildGameProgressScreen:
	push_wram_bank WRAM_TEXT ; $72af
	ld c, $10 ; $72b8
	call BeginFadeOut ; $72ba
	call WaitFadeEnd ; $72bd
	call DisableLCDSafely ; $72c0
	call InitGameProgressScreen ; $72c3
	call LoadGameProgressScreenAssets ; $72c6
	test_flag FLAG_TEMP_PROGRESS_SCREEN_OPEN ; $72c9
	jr nz, .isTempProgressScreenOpen ; $72cc
	jr .runRewardCategoryList ; $72ce
.isTempProgressScreenOpen:
	ld a, $05 ; $72d0
	call RunRewardCategoryList ; $72d2
.runRewardCategoryList:
	ld a, $00 ; $72d5
	call RunRewardCategoryList ; $72d7
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $72da
	jr nz, .isWonJuniorSinglesRank1 ; $72dd
	jr .checkFlag ; $72df
.isWonJuniorSinglesRank1:
	ld a, $01 ; $72e1
	call RunRewardCategoryList ; $72e3
.checkFlag:
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $72e6
	jr nz, .isWonSeniorSinglesRank1 ; $72e9
	jr .checkFlag2 ; $72eb
.isWonSeniorSinglesRank1:
	ld a, $02 ; $72ed
	call RunRewardCategoryList ; $72ef
.checkFlag2:
	test_flag FLAG_WON_VARSITY_SINGLES_RANK_4 ; $72f2
	jr nz, .isWonVarsitySinglesRank4 ; $72f5
	jr .checkFlag3 ; $72f7
.isWonVarsitySinglesRank4:
	ld a, $03 ; $72f9
	call RunRewardCategoryList ; $72fb
.checkFlag3:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; $72fe
	jr nz, .isWonIslandOpenSinglesFinal ; $7301
	jr .buildProgressEntryEarnedTable ; $7303
.isWonIslandOpenSinglesFinal:
	ld a, $04 ; $7305
	call RunRewardCategoryList ; $7307
.buildProgressEntryEarnedTable:
	call BuildProgressEntryEarnedTable ; $730a
	call BuildVisibleProgressEntryList ; $730d
	call CreateProgressListWindow ; $7310
	ld [wCharPosX + 1], a ; $7313
	ld a, [wCharPosX + 1] ; $7316
	set_flag FLAG_TEXT_RENDER_ACTIVE ; $7319
	farcall DrawTextWindowFrame ; $731c
	clear_flag FLAG_TEXT_RENDER_ACTIVE ; $731f
	call DrawProgressListRows ; $7322
	farcall RedrawWindowRows ; $7325
	call LoadGameProgressScreenTiles ; $7328
	call LoadProgressScreenIconTiles ; $732b
	call EnableLCD ; $732e
	ld a, $01 ; $7331
	ld [wAnimatedTileSet], a ; $7333
	ld a, $03 ; $7336
	ld [wAnimatedTilePeriod], a ; $7338
	ld a, $01 ; $733b
	ld hl, UpdateProgressScreenAnimatedTiles ; $733d
	call RegisterFrameTask ; $7340
	ld a, $01 ; $7343
	ld hl, DrawProgressScreenSprites ; $7345
	call RegisterFrameTask ; $7348
	script_fade_in $10 ; $734b
	call WaitFadeEnd ; $7350
.loop:
	call AdvanceFrame ; $7353
	wram_bank WRAM_TEXT ; $7356
	ldh a, [hInputPressed] ; $735c
	bit PADB_UP, a ; $735e
	call nz, ScrollProgressListUp ; $7360
	bit 7, a ; $7363
	call nz, ScrollProgressListDown ; $7365
	bit 0, a ; $7368
	jr nz, .playSfx2 ; $736a
	bit 1, a ; $736c
	jr nz, .playSfx ; $736e
	jr .loop ; $7370
.playSfx:
	sound SFX_MENU_CANCEL ; $7372
	jr .restore ; $7374
.playSfx2:
	sound SFX_MENU_SELECT ; $7376
.restore:
	pop_wram_bank ; $7378
	ret ; $737d
UpdateProgressScreenAnimatedTiles:
	farcall UpdateAnimatedTiles ; $737e
	ret ; $7381
ScrollProgressListDown:
	push af ; $7382
	farcall ResetGlyphStream ; $7383
	wram_bank WRAM_CHAR1 ; $7386
	ld a, [wProgressVisibleCount] ; $738c
	sub $06 ; $738f
	jr c, .restore ; $7391
	ld b, a ; $7393
	ld hl, wProgressListIndex ; $7394
	ld a, [hl] ; $7397
	inc a ; $7398
	cp b ; $7399
	jr nc, .restore ; $739a
	ld [hl], a ; $739c
	sound SFX_MENU_MOVE ; $739d
	ld a, [wCharPosX + 1] ; $739f
	set_flag FLAG_TEXT_RENDER_ACTIVE ; $73a2
	farcall DrawTextWindowFrame ; $73a5
	clear_flag FLAG_TEXT_RENDER_ACTIVE ; $73a8
	call DrawProgressListRows ; $73ab
.restore:
	pop af ; $73ae
	ret ; $73af
ScrollProgressListUp:
	push af ; $73b0
	farcall ResetGlyphStream ; $73b1
	wram_bank WRAM_CHAR1 ; $73b4
	ld hl, wProgressListIndex ; $73ba
	ld a, [hl] ; $73bd
	dec a ; $73be
	bit 7, a ; $73bf
	jr nz, .restore ; $73c1
	ld [hl], a ; $73c3
	sound SFX_MENU_MOVE ; $73c4
	ld a, [wCharPosX + 1] ; $73c6
	set_flag FLAG_TEXT_RENDER_ACTIVE ; $73c9
	farcall DrawTextWindowFrame ; $73cc
	clear_flag FLAG_TEXT_RENDER_ACTIVE ; $73cf
	call DrawProgressListRows ; $73d2
.restore:
	pop af ; $73d5
	ret ; $73d6
; CreateProgressListWindow with a 16 x 3 window at (2, 0) in place of the 18 x 15 list at (1, 3): the header the progress screen never draws. Nothing calls it.
UnusedCreateProgressHeaderWindow:
	ld d, $02 ; $73d7
	ld e, $00 ; $73d9
	ld b, $10 ; $73db
	ld c, $03 ; $73dd
	farcall CreateWindowFromScreenRect ; $73df
	ret ; $73e2
CreateProgressListWindow:
	ld d, $01 ; $73e3
	ld e, $03 ; $73e5
	ld b, $12 ; $73e7
	ld c, $0f ; $73e9
	farcall CreateWindowFromScreenRect ; $73eb
	ret ; $73ee
TestProgressEntryFlag:
	push hl ; $73ef
	push de ; $73f0
	ld hl, ProgressEntryFlagList_1e ; $73f1
	add a ; $73f4
	add l ; $73f5
	ld l, a ; $73f6
	jr nc, .read ; $73f7
	inc h ; $73f9
.read:
	ld a, [hl+] ; $73fa
	ld d, [hl] ; $73fb
	ld e, a ; $73fc
	call TestGameFlag ; $73fd
	ld a, $01 ; $7400
	jr nz, .restore ; $7402
	xor a ; $7404
.restore:
	pop de ; $7405
	pop hl ; $7406
	ret ; $7407
RunRewardCategoryList:
	ld hl, RewardCategoryEntryListPtrs_1e ; $7408
	add a ; $740b
	add l ; $740c
	ld l, a ; $740d
	jr nc, .readList ; $740e
	inc h ; $7410
.readList:
	ld a, [hl+] ; $7411
	ld d, [hl] ; $7412
	ld e, a ; $7413
.entryLoop:
	ld a, [de] ; $7414
	cp $ff ; $7415
	jr z, .done ; $7417
	push de ; $7419
	push af ; $741a
	ld hl, RewardCategoryFlagTable_1e ; $741b
	add a ; $741e
	add l ; $741f
	ld l, a ; $7420
	jr nc, .readFlagId ; $7421
	inc h ; $7423
.readFlagId:
	ld a, [hl+] ; $7424
	ld d, [hl] ; $7425
	ld e, a ; $7426
	ld a, d ; $7427
	or e ; $7428
	ld a, $01 ; $7429
	jr z, .storeState ; $742b
	call TestGameFlag ; $742d
	ld a, $01 ; $7430
	jr nz, .storeState ; $7432
	xor a ; $7434
.storeState:
	ld e, a ; $7435
	pop af ; $7436
	ld hl, wProgressEntryUnlocked ; $7437
	add l ; $743a
	ld l, a ; $743b
	jr nc, .writeSlot ; $743c
	inc h ; $743e
.writeSlot:
	ld [hl], e ; $743f
	pop de ; $7440
	inc de ; $7441
	jr .entryLoop ; $7442
.done:
	ret ; $7444
RewardCategoryEntryListPtrs_1e:
	; $7445, 12 bytes (records:2)
	dw RewardCategoryEntryList0_1e ; record 0
	dw RewardCategoryEntryList1_1e ; record 1
	dw RewardCategoryEntryList2_1e ; record 2
	dw RewardCategoryEntryList3_1e ; record 3
	dw RewardCategoryEntryList4_1e ; record 4
	dw RewardCategoryEntryList5_1e ; record 5
RewardCategoryEntryList0_1e:
	; $7451, 21 bytes (bytes:16)
	db $03, $04, $05, $06, $07, $08, $0b, $0e, $11, $14, $17, $1a, $1d, $1e, $1f, $20 ; 0x00
	db $21, $22, $23, $24, $ff ; 0x10
RewardCategoryEntryList1_1e:
	; $7466, 7 bytes (bytes:16)
	db $0c, $0f, $12, $15, $18, $1b, $ff ; 0x00
RewardCategoryEntryList2_1e:
	; $746d, 7 bytes (bytes:16)
	db $0d, $10, $13, $16, $19, $1c, $ff ; 0x00
RewardCategoryEntryList3_1e:
	; $7474, 3 bytes (bytes:16)
	db $09, $0a, $ff ; 0x00
RewardCategoryEntryList4_1e:
	; $7477, 3 bytes (bytes:16)
	db $01, $02, $ff ; 0x00
RewardCategoryEntryList5_1e:
	; $747a, 2 bytes (bytes:16)
	db $00, $ff ; 0x00
BuildVisibleProgressEntryList:
	ld c, $00 ; $747c
	ld b, $00 ; $747e
	ld hl, wProgressEntryUnlocked ; $7480
	ld de, wProgressVisibleEntries ; $7483
.loop:
	ld a, [hl+] ; $7486
	or a ; $7487
	jr z, .zero ; $7488
	inc b ; $748a
	ld a, c ; $748b
	ld [de], a ; $748c
	inc de ; $748d
.zero:
	inc c ; $748e
	ld a, c ; $748f
	cp $30 ; $7490
	jr c, .loop ; $7492
	ld a, b ; $7494
	ld [wProgressVisibleCount], a ; $7495
	ret ; $7498
BuildProgressEntryEarnedTable:
	ld hl, wProgressEntryEarned ; $7499
	ld c, $25 ; $749c
	xor a ; $749e
.entryLoop:
	push af ; $749f
	call TestProgressEntryFlag ; $74a0
	ld [hl+], a ; $74a3
	pop af ; $74a4
	inc a ; $74a5
	dec c ; $74a6
	jr nz, .entryLoop ; $74a7
	ret ; $74a9
GetProgressEntryEarned:
	push hl ; $74aa
	ld hl, wProgressEntryEarned ; $74ab
	add l ; $74ae
	ld l, a ; $74af
	jr nc, .read ; $74b0
	inc h ; $74b2
.read:
	ld a, [hl] ; $74b3
	pop hl ; $74b4
	ret ; $74b5
DrawProgressListRows:
	farcall PrepareGlyphBuffer ; $74b6
	ld hl, wShadowTilemapPtr ; $74b9
	ld a, [hl+] ; $74bc
	ld d, [hl] ; $74bd
	ld e, a ; $74be
	ld hl, $0082 ; $74bf
	add hl, de ; $74c2
	ld d, h ; $74c3
	ld e, l ; $74c4
	ld a, [wProgressListIndex] ; $74c5
	ld hl, wProgressVisibleEntries ; $74c8
	add l ; $74cb
	ld l, a ; $74cc
	jr nc, .gotPtr ; $74cd
	inc h ; $74cf
.gotPtr:
	ld c, $07 ; $74d0
.loop:
	ld a, [hl+] ; $74d2
	cp $ff ; $74d3
	jr z, .eqff ; $74d5
	push hl ; $74d7
	ld hl, Text_31_160 ; $74d8
	add l ; $74db
	ld l, a ; $74dc
	jr nc, .renderProportionalTextAt ; $74dd
	inc h ; $74df
.renderProportionalTextAt:
	push bc ; $74e0
	ld c, $10 ; $74e1
	farcall RenderProportionalTextAt ; $74e3
	pop bc ; $74e6
	ld hl, $0040 ; $74e7
	add hl, de ; $74ea
	ld d, h ; $74eb
	ld e, l ; $74ec
	pop hl ; $74ed
	dec c ; $74ee
	jr nz, .loop ; $74ef
.eqff:
	ld a, $70 ; $74f1
	ld [wGlyphRowStartCol], a ; $74f3
	farcall UploadGlyphBuffer ; $74f6
	ret ; $74f9
LoadGameProgressScreenAssets:
	farcall LoadMenuFontTiles ; $74fa
	call FillProgressListRowTiles ; $74fd
	call FillProgressListRowAttrs ; $7500
	ret ; $7503
LoadGameProgressScreenTiles:
	push_wram_bank WRAM_STAGING ; $7504
	ld hl, GameProgressHeaderGfx_1e ; $750d
	ld de, wDecompBuffer ; $7510
	call DecompressData ; $7513
	ld hl, wDecompBuffer ; $7516
	ld de, vTiles2 + VRAM_BANK1 ; $7519
	ld c, GameProgressHeaderGfx_1e_SIZE / 16 ; $751c
	call QueueVRAMCopy ; $751e
	ld hl, GameProgressHeaderTilemap_1e ; $7521
	ld de, wDecompBuffer ; $7524
	call DecompressData ; $7527
	ld hl, wDecompBuffer ; $752a
	ld de, vBGMap0 ; $752d
	ld c, GameProgressHeaderTilemap_1e_SIZE / 16 ; $7530
	call QueueVRAMCopy ; $7532
	ld hl, GameProgressHeaderAttrmap_1e ; $7535
	ld de, wDecompBuffer ; $7538
	call DecompressData ; $753b
	ld hl, wDecompBuffer ; $753e
	ld a, $09 ; $7541
	ld c, $03 ; $7543
.loop:
	ld [hl+], a ; $7545
	ld [hl+], a ; $7546
	ld [hl+], a ; $7547
	ld [hl+], a ; $7548
	ld de, $000c ; $7549
	add hl, de ; $754c
	ld [hl+], a ; $754d
	ld [hl+], a ; $754e
	ld [hl+], a ; $754f
	ld [hl+], a ; $7550
	ld de, $000c ; $7551
	add hl, de ; $7554
	dec c ; $7555
	jr nz, .loop ; $7556
	ld hl, wDecompBuffer ; $7558
	ld de, vBGMap0 + VRAM_BANK1 ; $755b
	ld c, $06 ; $755e
	call QueueVRAMCopy ; $7560
	ld hl, GameProgressScreenPalettes0 ; $7563
	ld d, $00 ; $7566
	ld e, $02 ; $7568
	call LoadPaletteShadow ; $756a
	pop_wram_bank ; $756d
	ld hl, GameProgressScreenTiles0 ; $7572
	ld de, vTiles0 + VRAM_BANK1 ; $7575
	ld c, (GameProgressScreenPalettes1 - GameProgressScreenTiles0) / 16 ; $7578
	call QueueVRAMCopy ; $757a
	ld hl, GameProgressScreenTiles2 ; $757d
	ld de, vTiles0 + $10 * TILE_SIZE + VRAM_BANK1 ; $7580
	ld c, $04 ; $7583 -- 4 of GameProgressScreenTiles2's 8 tiles
	call QueueVRAMCopy ; $7585
	ld hl, GameProgressScreenTiles1 ; $7588
	ld de, vTiles0 + $20 * TILE_SIZE + VRAM_BANK1 ; $758b
	ld c, (GameProgressScreenTiles2 - GameProgressScreenTiles1) / 16 ; $758e
	call QueueVRAMCopy ; $7590
	ld hl, GameProgressScreenPalettes1 ; $7593
	lb de, $0a, $01 ; $7596 palette index, count
	call LoadPaletteShadow ; $7599
	ld hl, GameProgressScreenPalettes2 ; $759c
	lb de, $09, $01 ; $759f palette index, count
	call LoadPaletteShadow ; $75a2
	ret ; $75a5
GameProgressHeaderGfx_1e:
	INCBIN "data/bank_01e/lz_GameProgressHeaderGfx_1e.bin" ; $75a6, 236 bytes
	INCLUDE "data/bank_01e/lz_GameProgressHeaderGfx_1e.inc" ; DEF GameProgressHeaderGfx_1e_SIZE EQU its decoded length, generated from the .bin by make
GameProgressHeaderTilemap_1e:
	INCBIN "data/bank_01e/lz_GameProgressHeaderTilemap_1e.bin" ; $7692, 80 bytes
	INCLUDE "data/bank_01e/lz_GameProgressHeaderTilemap_1e.inc" ; DEF GameProgressHeaderTilemap_1e_SIZE EQU its decoded length, generated from the .bin by make
GameProgressHeaderAttrmap_1e:
	INCBIN "data/bank_01e/lz_GameProgressHeaderAttrmap_1e.bin" ; $76e2, 24 bytes
	; $76fa, 6 bytes (fill)
	ds 6, $00
GameProgressScreenPalettes0:
	INCLUDE "data/bank_01e/GameProgressScreenPalettes0.asm" ; $7700, 16 bytes (palettes)
	ds ALIGN[4]
GameProgressScreenTiles0:
	INCLUDE "data/bank_01e/GameProgressScreenTiles0.asm" ; $7710, 256 bytes (palettes)
GameProgressScreenPalettes1:
	INCLUDE "data/bank_01e/GameProgressScreenPalettes1.asm" ; $7810, 16 bytes (palettes)
	ds ALIGN[4]
GameProgressScreenTiles1:
	INCLUDE "data/bank_01e/GameProgressScreenTiles1.asm" ; $7820, 320 bytes (palettes)
	ds ALIGN[4]
GameProgressScreenTiles2:
	INCLUDE "data/bank_01e/GameProgressScreenTiles2.asm" ; $7960, 128 bytes (palettes)
GameProgressScreenPalettes2:
	INCLUDE "data/bank_01e/GameProgressScreenPalettes2.asm" ; $79e0, 8 bytes (palettes)
