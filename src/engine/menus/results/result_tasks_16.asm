	twin_in get_menu_cursor_index_from_ptr, Unused_16_GetMenuCursorIndexFromPtr, 16 ; $4399 Unused_16_GetMenuCursorIndexFromPtr
	twin_in set_menu_cursor_from_index, Unused_16_SetMenuCursorFromIndex, 16 ; $43a9 Unused_16_SetMenuCursorFromIndex
	twin_in set_menu_cursor_from_index_to_ptr, Unused_16_SetMenuCursorFromIndexToPtr, 16 ; $43bb Unused_16_SetMenuCursorFromIndexToPtr
Unused_16_ClearWram3Row64:
	push_wram_bank WRAM_SCREEN ; $43c9
	xor a ; $43d2
	ld c, $40 ; $43d3
.loop:
	ld [hl+], a ; $43d5
	dec c ; $43d6
	jr nz, .loop ; $43d7
	pop_wram_bank ; $43d9
	ret ; $43de
Unused_16_ClearWram3Row64Alt:
	push_wram_bank WRAM_SCREEN ; $43df
	ld a, $00 ; $43e8
	ld c, $40 ; $43ea
.loop:
	ld [hl+], a ; $43ec
	dec c ; $43ed
	jr nz, .loop ; $43ee
	pop_wram_bank ; $43f0
	ret ; $43f5
UpdateResultScreenAnimatedTilesTask:
	farcall UpdateAnimatedTiles ; $43f6
	ret ; $43f9
Unused_16_PlaceTextWithDiacritics:
	push af ; $43fa
	push bc ; $43fb
.loop:
	ld a, [hl] ; $43fc
	cp $00 ; $43fd
	jr z, .restore ; $43ff
	ld [de], a ; $4401
	inc hl ; $4402
	ld a, [hl] ; $4403
	cp TX_DAKUTEN ; $4404
	jr z, .diacritic ; $4406
	cp TX_HANDAKUTEN ; $4408
	jr nz, .nextCell ; $440a
.diacritic:
	push hl ; $440c
	push bc ; $440d
	ld h, d ; $440e
	ld l, e ; $440f
	ld bc, -32 ; $4410
	add hl, bc ; $4413
	ld b, a ; $4414
	ld a, [hl] ; $4415
	cp $03 ; $4416
	ld a, b ; $4418
	jr nz, .store ; $4419
	sub $d0 ; $441b
.store:
	ld [hl], a ; $441d
	pop bc ; $441e
	pop hl ; $441f
	inc hl ; $4420
.nextCell:
	inc de ; $4421
	ld a, e ; $4422
	and $1f ; $4423
	jr nz, Unused_16_PlaceTextWithDiacritics.loop ; $4425
	push hl ; $4427
	ld h, d ; $4428
	ld l, e ; $4429
	add hl, de ; $442a
	ld d, h ; $442b
	ld e, l ; $442c
	pop hl ; $442d
	jr Unused_16_PlaceTextWithDiacritics.loop ; $442e
.restore:
	pop bc ; $4430
	pop af ; $4431
	ret ; $4432
Unused_16_PrintDecimalNumber:
	push af ; $4433
	push bc ; $4434
	push hl ; $4435
	add sp, -10 ; $4436
	push bc ; $4438
	push de ; $4439
	ld c, l ; $443a
	ld b, h ; $443b
	ld hl, sp + 4 ; $443c
	ld e, l ; $443e
	ld d, h ; $443f
	ld l, c ; $4440
	ld h, b ; $4441
	ld c, e ; $4442
.formatDigits:
	ld b, d ; $4443
	call FormatDecimalNumber ; $4444
	ld l, c ; $4447
	ld h, b ; $4448
	pop de ; $4449
	pop bc ; $444a
	call Unused_16_PrintNumberString ; $444b
	add sp, 10 ; $444e
	pop hl ; $4450
	pop bc ; $4451
	pop af ; $4452
	ret ; $4453
Unused_16_PrintNumberString:
	ld a, [hl+] ; $4454
	and a ; $4455
	jr z, .done ; $4456
	call Unused_16_DrawAsciiDigitChar ; $4458
	jr Unused_16_PrintNumberString ; $445b
.done:
	ret ; $445d
	twin_in draw_ascii_digit_char, Unused_16_DrawAsciiDigitChar, 16 ; $445e Unused_16_DrawAsciiDigitChar
RunMatchWinLoseScreen:
	ld a, [wMatchAbortFlag] ; $4477
	bit MATCHABORTB_MATCH, a ; $447a
	ret nz ; $447c
	call DisableLCDSafely ; $447d
	call ClearFrameTasks ; $4480
	wram_bank WRAM_SCREEN ; $4483
	ld a, [wGameMode] ; $4489
	cp GAMEMODE_EXHIBITION ; $448c
	jr z, .versusMatch ; $448e
	cp GAMEMODE_LINK_MATCH ; $4490
	jr z, .versusMatch ; $4492
	jr .storyMatch ; $4494
.versusMatch:
	ld a, $01 ; $4496
	jr .store ; $4498
.storyMatch:
	xor a ; $449a
.store:
	ld [wResultScreenIsVersus], a ; $449b
	ld [wResultScreenMode], a ; $449e
	ld a, [wMatchWinLoseFlag] ; $44a1
	ld [wSavedMatchWinLoseFlag], a ; $44a4
	call ApplyLinkRoleToWinLoseFlag ; $44a7
	ld a, $ff ; $44aa
	ld a, [wMatchWinLoseFlag] ; $44ac
	cp WINLOSE_LOSE ; $44af
	jr z, .playLoseBgm ; $44b1
	sound BGM_WIN ; $44b3
	jr .initMatchWinLoseScreen ; $44b5
.playLoseBgm:
	sound BGM_LOSE ; $44b7
.initMatchWinLoseScreen:
	call InitMatchWinLoseScreen ; $44b9
	farcall UpdateAnimatedTiles ; $44bc
	frame_task UpdateResultScreenAnimatedTilesTask ; $44bf
	frame_task QueueResultScreenSprites ; $44c7
	call EnableLCD ; $44cf
	script_fade_in 16 ; $44d2
	call WaitFadeEnd ; $44d7
	ld a, STAT_MODE_0 ; $44da
	ldh [rSTAT], a ; $44dc
	ld hl, rIE ; $44de
	set B_IE_STAT, [hl] ; $44e1
	ld a, $48 ; $44e3
	ld [wRasterScrollStartLY], a ; $44e5
	ld a, $57 ; $44e8
	ld [wRasterScrollEndLY], a ; $44ea
	xor a ; $44ed
	ld [wRasterScrollX], a ; $44ee
	frame_task AdvanceResultScreenTimer ; $44f1
.loop:
	call AdvanceFrame ; $44f9
	ld a, [wCurrentMatchIndex] ; $44fc
	push de ; $44ff
	push af ; $4500
	ld a, a ; $4501
	ld_cell de, $03, $03 ; $4502
	call PrintDecimalByte ; $4505
	pop af ; $4508
	pop de ; $4509
	ldh a, [hInputPressed] ; $450a
	ld [wMenuInputPressed], a ; $450c
	bit PADB_A, a ; $450f
	jr nz, .playSelectSfx ; $4511
	bit PADB_B, a ; $4513
	jr nz, .playSelectSfx ; $4515
	bit PADB_RIGHT, a ; $4517
	jr nz, .pressedRight ; $4519
	jr .loop ; $451b
.playSelectSfx:
	sound SFX_MENU_SELECT ; $451d
	call ClearFrameTasks ; $451f
	script_fade_out 64 ; $4522
	call WaitFadeEnd ; $4527
	ld hl, rIE ; $452a
	res B_IE_STAT, [hl] ; $452d
	ld a, $03 ; $452f
	ld [wAnimatedTilePeriod], a ; $4531
	ld a, [wSavedMatchWinLoseFlag] ; $4534
	ld [wMatchWinLoseFlag], a ; $4537
	ret ; $453a
.pressedRight:
	script_fade_out 64 ; $453b
	call WaitFadeEnd ; $4540
	ld hl, rIE ; $4543
	res B_IE_STAT, [hl] ; $4546
	call ClearFrameTasks ; $4548
	call RunMatchStatsScreen ; $454b
	push af ; $454e
	ld a, [wSavedMatchWinLoseFlag] ; $454f
	ld [wMatchWinLoseFlag], a ; $4552
	pop af ; $4555
	cp $ff ; $4556
	jp nz, RunMatchWinLoseScreen ; $4558
	call ClearFrameTasks ; $455b
	script_fade_out 8 ; $455e
	call WaitFadeEnd ; $4563
	ld hl, rIE ; $4566
	res B_IE_STAT, [hl] ; $4569
	ld a, $03 ; $456b
	ld [wAnimatedTilePeriod], a ; $456d
	ret ; $4570
InitMatchWinLoseScreen:
	call ClearFrameTasks ; $4571
	xor a ; $4574
	ldh [hScrollX], a ; $4575
	ldh [hScrollY], a ; $4577
	call LoadWinLoseScreenAssets ; $4579
	wram_bank WRAM_SCREEN ; $457c
	ld de, wShadowAttrmap + 11 * TILEMAP_WIDTH ; $4582
	rect_size $14, $05 ; $4585
	ld h, $0a ; $4589
	farcall FillTilemapRect ; $458b
	ld a, $00 ; $458e
	ld d, $04 ; $4590
	farcall LoadIndexedPalette_18 ; $4592
	ld a, $00 ; $4595
	ld d, $05 ; $4597
	farcall LoadIndexedPalette_18 ; $4599
	ld a, $00 ; $459c
	ld d, $06 ; $459e
	farcall LoadIndexedPalette_18 ; $45a0
	ld a, $00 ; $45a3
	ld d, $07 ; $45a5
	farcall LoadIndexedPalette_18 ; $45a7
	call LoadMatchResultPalettes ; $45aa
	call AdjustResultTilemapForLoss ; $45ad
	call LoadResultScreenTileGraphics ; $45b0
	call SetWinLosePortraitPaletteAttrs ; $45b3
	ld c, $00 ; $45b6
	call LoadResultScreenPortraits ; $45b8
	push_wram_bank WRAM_STAGING ; $45bb
	ld hl, WinTextSpriteGfx ; $45c4
	ld de, wDecompBuffer ; $45c7
	call DecompressData ; $45ca
	ld hl, wDecompBuffer ; $45cd
	ld de, vTiles0 + VRAM_BANK1 ; $45d0
	ld c, WinTextSpriteGfx_SIZE / 16 ; $45d3
	call QueueVRAMCopy ; $45d5
	ld hl, LoseTextSpriteGfx ; $45d8
	ld de, wDecompBuffer ; $45db
	call DecompressData ; $45de
	ld hl, wDecompBuffer ; $45e1
	ld de, vTiles0 tile $20 + VRAM_BANK1 ; $45e4
	ld c, LoseTextSpriteGfx_SIZE / 16 ; $45e7
	call QueueVRAMCopy ; $45e9
	ld hl, MatchWinLoseScreenPalettes ; $45ec
	ld_obj_pals de, 0, 3 ; $45ef
	call LoadPaletteShadow ; $45f2
	ld b, TILEBLOCK_WinLoseArrowGfx ; $45f5
	ld c, WinLoseArrowGfx_SIZE / 16 ; $45f7
	ld de, vTiles0 tile $40 + VRAM_BANK1 ; $45f9
	farcall LoadCompressedTileBlock ; $45fc
	pop_wram_bank ; $45ff
	farcall QueueWram3MapToVRAM ; $4604
	ret ; $4607
WinTextSpriteGfx:
	INCBIN "data/engine/menus/results/lz_WinTextSpriteGfx.bin" ; $4608, 380 bytes
	INCLUDE "data/engine/menus/results/lz_WinTextSpriteGfx.inc" ; DEF WinTextSpriteGfx_SIZE EQU its decoded length, generated from the .bin by make
LoseTextSpriteGfx:
	INCBIN "data/engine/menus/results/lz_LoseTextSpriteGfx.bin" ; $4784, 368 bytes
	INCLUDE "data/engine/menus/results/lz_LoseTextSpriteGfx.inc" ; DEF LoseTextSpriteGfx_SIZE EQU its decoded length, generated from the .bin by make
MatchWinLoseScreenPalettes:
	INCLUDE "data/engine/menus/results/MatchWinLoseScreenPalettes.asm" ; $48f4, 24 bytes (palettes)
LoadWinLoseScreenAssets:
	ld a, [wResultScreenIsVersus] ; $490c
	or a ; $490f
	jr z, .nonVersus ; $4910
	ld c, SCREENASSET_MatchWinLoseVersus ; $4912
	farcall LoadScreenAssetRecord ; $4914
	jr .checkDoubles ; $4917
.nonVersus:
	ld c, SCREENASSET_MatchWinLose ; $4919
	farcall LoadScreenAssetRecord ; $491b
	jr .checkDoubles ; $491e
.checkDoubles:
	ld de, FLAG_DOUBLES ; $4920
	call TestGameFlagByNumber ; $4923
	jr nz, .done ; $4926
	wram_bank WRAM_SCREEN ; $4928
	ld hl, wShadowTilemap + 20 * TILEMAP_WIDTH ; $492e
	ld de, wShadowTilemap + 4 * TILEMAP_WIDTH + 11 ; $4931
	rect_size $09, $05 ; $4934
	farcall CopyTilemapRect ; $4938
	ld hl, wShadowAttrmap + 20 * TILEMAP_WIDTH ; $493b
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 11 ; $493e
	rect_size $09, $05 ; $4941
	farcall CopyTilemapRect ; $4945
	ld hl, wShadowTilemap + 20 * TILEMAP_WIDTH + 9 ; $4948
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH + 1 ; $494b
	rect_size $08, $05 ; $494e
	farcall CopyTilemapRect ; $4952
	ld hl, wShadowAttrmap + 20 * TILEMAP_WIDTH + 9 ; $4955
	ld de, wShadowAttrmap + 11 * TILEMAP_WIDTH + 1 ; $4958
	rect_size $08, $05 ; $495b
	farcall CopyTilemapRect ; $495f
.done:
	ret ; $4962
SetWinLosePortraitPaletteAttrs:
	ld a, [wResultScreenMode] ; $4963
	or a ; $4966
	jr nz, .versusMatch ; $4967
	ld de, FLAG_DOUBLES ; $4969
	call TestGameFlagByNumber ; $496c
	jr z, .singles ; $496f
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 11 ; $4971
	rect_size $04, $04 ; $4974
	ld h, $0c ; $4978
	farcall FillTilemapRect ; $497a
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 15 ; $497d
	rect_size $04, $04 ; $4980
	ld h, $0d ; $4984
	farcall FillTilemapRect ; $4986
	ld de, wShadowAttrmap + 12 * TILEMAP_WIDTH + 2 ; $4989
	rect_size $03, $03 ; $498c
	ld h, $0e ; $4990
	farcall FillTilemapRect ; $4992
	ld de, wShadowAttrmap + 12 * TILEMAP_WIDTH + 5 ; $4995
	rect_size $03, $03 ; $4998
	ld h, $0f ; $499c
	farcall FillTilemapRect ; $499e
	jr .doneResult ; $49a1
.singles:
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 13 ; $49a3
	rect_size $04, $04 ; $49a6
	ld h, $0c ; $49aa
	farcall FillTilemapRect ; $49ac
	ld de, wShadowAttrmap + 12 * TILEMAP_WIDTH + 3 ; $49af
	rect_size $03, $03 ; $49b2
	ld h, $0e ; $49b6
	farcall FillTilemapRect ; $49b8
.doneResult:
	ret ; $49bb
.versusMatch:
	ld de, FLAG_DOUBLES ; $49bc
	call TestGameFlagByNumber ; $49bf
	jr z, .fillTilemapRect ; $49c2
	ld de, wShadowAttrmap + 5 * TILEMAP_WIDTH + 12 ; $49c4
	rect_size $03, $03 ; $49c7
	ld h, $0c ; $49cb
	farcall FillTilemapRect ; $49cd
	ld de, wShadowAttrmap + 5 * TILEMAP_WIDTH + 15 ; $49d0
	rect_size $03, $03 ; $49d3
	ld h, $0d ; $49d7
	farcall FillTilemapRect ; $49d9
	ld de, wShadowAttrmap + 12 * TILEMAP_WIDTH + 2 ; $49dc
	rect_size $03, $03 ; $49df
	ld h, $0e ; $49e3
	farcall FillTilemapRect ; $49e5
	ld de, wShadowAttrmap + 12 * TILEMAP_WIDTH + 5 ; $49e8
	rect_size $03, $03 ; $49eb
	ld h, $0f ; $49ef
	farcall FillTilemapRect ; $49f1
	jr .doneVersus ; $49f4
.fillTilemapRect:
	ld de, wShadowAttrmap + 5 * TILEMAP_WIDTH + 13 ; $49f6
	rect_size $03, $03 ; $49f9
	ld h, $0c ; $49fd
	farcall FillTilemapRect ; $49ff
	ld de, wShadowAttrmap + 12 * TILEMAP_WIDTH + 3 ; $4a02
	rect_size $03, $03 ; $4a05
	ld h, $0e ; $4a09
	farcall FillTilemapRect ; $4a0b
.doneVersus:
	ret ; $4a0e
