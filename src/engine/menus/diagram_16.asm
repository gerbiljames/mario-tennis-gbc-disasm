; Instruction-identical to GetCellIndexFromCursorPtr_3b and GetCellIndexFromCursorPtr_3e (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin get_cell_index_from_cursor_ptr, 16 ; $4399 GetCellIndexFromCursorPtr_16
; Instruction-identical to SetMenuCursorFromIndex_38, SetMenuCursorFromIndex_3b and SetMenuCursorFromIndex_3e (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin set_menu_cursor_from_index, 16 ; $43a9 SetMenuCursorFromIndex_16
; Instruction-identical to SetMenuCursorFromIndexToPtr_38 and SetMenuCursorFromIndexToPtr_3e (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin set_menu_cursor_from_index_to_ptr, 16 ; $43bb SetMenuCursorFromIndexToPtr_16
ClearWram3Row64_16:
	push_wram_bank WRAM_SCREEN ; $43c9
	xor a ; $43d2
	ld c, $40 ; $43d3
.loop:
	ld [hl+], a ; $43d5
	dec c ; $43d6
	jr nz, .loop ; $43d7
	pop_wram_bank ; $43d9
	ret ; $43de
ClearWram3Row64Alt_16:
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
UnusedDrawCourtDiagramMarkers:
	push af ; $43fa
	push bc ; $43fb
.loop:
	ld a, [hl] ; $43fc
	cp $00 ; $43fd
	jr z, CourtDiagramBaseTask.restore ; $43ff
	ld [de], a ; $4401
	inc hl ; $4402
	ld a, [hl] ; $4403
	cp $de ; $4404
CourtDiagramBaseTask:
	jr z, .eqde ; $4406
	cp $df ; $4408
	jr nz, .nedf ; $440a
.eqde:
	push hl ; $440c
	push bc ; $440d
	ld h, d ; $440e
	ld l, e ; $440f
	ld bc, $ffe0 ; $4410
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
.nedf:
	inc de ; $4421
	ld a, e ; $4422
	and $1f ; $4423
	jr nz, UnusedDrawCourtDiagramMarkers.loop ; $4425
	push hl ; $4427
	ld h, d ; $4428
	ld l, e ; $4429
	add hl, de ; $442a
	ld d, h ; $442b
	ld e, l ; $442c
	pop hl ; $442d
	jr UnusedDrawCourtDiagramMarkers.loop ; $442e
.restore:
	pop bc ; $4430
	pop af ; $4431
	ret ; $4432
UnusedPrintDecimalNumber_16:
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
PrintDecimalNumber:
	ld b, d ; $4443
	call FormatDecimalNumber ; $4444
	ld l, c ; $4447
	ld h, b ; $4448
	pop de ; $4449
	pop bc ; $444a
	call PrintNumberString_16 ; $444b
	add sp, 10 ; $444e
	pop hl ; $4450
	pop bc ; $4451
	pop af ; $4452
	ret ; $4453
PrintNumberString_16:
	ld a, [hl+] ; $4454
	and a ; $4455
	jr z, .done ; $4456
	call DrawAsciiDigitChar_16 ; $4458
	jr PrintNumberString_16 ; $445b
.done:
	ret ; $445d
; Instruction-identical to DrawAsciiDigitChar_17, DrawAsciiDigitChar_1b, DrawAsciiDigitChar_3b and DrawAsciiDigitChar_3e (one copy per bank); a change here belongs in every copy.
	twin draw_ascii_digit_char, 16 ; $445e DrawAsciiDigitChar_16
RunMatchWinLoseScreen:
	ld a, [wMatchAbortFlag] ; $4477
	bit MATCHABORTB_MATCH, a ; $447a
	ret nz ; $447c
	call DisableLCDSafely ; $447d
	call ClearFrameTasks ; $4480
	wram_bank WRAM_SCREEN ; $4483
	ld a, [wGameMode] ; $4489
	cp GAMEMODE_EXHIBITION ; $448c
	jr z, .step ; $448e
	cp GAMEMODE_LINK_MATCH ; $4490
	jr z, .step ; $4492
	jr .checkMatchWinLoseFlag ; $4494
.step:
	ld a, $01 ; $4496
	jr .store ; $4498
.checkMatchWinLoseFlag:
	xor a ; $449a
.store:
	ld [wResultScreenWon], a ; $449b
	ld [wResultScreenMode], a ; $449e
	ld a, [wMatchWinLoseFlag] ; $44a1
	ld [wMatchWinLoseState], a ; $44a4
	call ApplyLinkRoleToWinLoseFlag ; $44a7
	ld a, $ff ; $44aa
	ld a, [wMatchWinLoseFlag] ; $44ac
	cp WINLOSE_LOSE ; $44af
	jr z, .playSfx ; $44b1
	sound BGM_WIN ; $44b3
	jr .initMatchWinLoseScreen ; $44b5
.playSfx:
	sound BGM_LOSE ; $44b7
.initMatchWinLoseScreen:
	call InitMatchWinLoseScreen ; $44b9
	farcall UpdateAnimatedTiles ; $44bc
	ld a, $01 ; $44bf
	ld hl, UpdateResultScreenAnimatedTilesTask ; $44c1
	call RegisterFrameTask ; $44c4
	ld a, $01 ; $44c7
	ld hl, QueueResultScreenSprites ; $44c9
	call RegisterFrameTask ; $44cc
	call EnableLCD ; $44cf
	script_fade_in $10 ; $44d2
	call WaitFadeEnd ; $44d7
	ld a, $08 ; $44da
	ldh [rSTAT], a ; $44dc
	ld hl, rIE ; $44de
	set 1, [hl] ; $44e1
	ld a, $48 ; $44e3
	ld [wRasterScrollStartLY], a ; $44e5
	ld a, $57 ; $44e8
	ld [wRasterScrollEndLY], a ; $44ea
	xor a ; $44ed
	ld [wRasterScrollX], a ; $44ee
	ld a, $01 ; $44f1
	ld hl, AdvanceResultScreenTimer ; $44f3
	call RegisterFrameTask ; $44f6
.loop:
	call AdvanceFrame ; $44f9
	ld a, [wCurrentMinigameStoryMatch + 1] ; $44fc
	push de ; $44ff
	push af ; $4500
	ld a, a ; $4501
	ld de, $0303 ; $4502
	call PrintDecimalByte ; $4505
	pop af ; $4508
	pop de ; $4509
	ldh a, [hInputPressed] ; $450a
	ld [wMenuInputPressed], a ; $450c
	bit PADB_A, a ; $450f
	jr nz, .playSfx2 ; $4511
	bit 1, a ; $4513
	jr nz, .playSfx2 ; $4515
	bit 4, a ; $4517
	jr nz, .bit4Set ; $4519
	jr .loop ; $451b
.playSfx2:
	sound SFX_MENU_SELECT ; $451d
	call ClearFrameTasks ; $451f
	ld c, $40 ; $4522
	call BeginFadeOut ; $4524
	call WaitFadeEnd ; $4527
	ld hl, rIE ; $452a
	res 1, [hl] ; $452d
	ld a, $03 ; $452f
	ld [wAnimatedTilePeriod], a ; $4531
	ld a, [wMatchWinLoseState] ; $4534
	ld [wMatchWinLoseFlag], a ; $4537
	ret ; $453a
.bit4Set:
	ld c, $40 ; $453b
	call BeginFadeOut ; $453d
	call WaitFadeEnd ; $4540
	ld hl, rIE ; $4543
	res 1, [hl] ; $4546
	call ClearFrameTasks ; $4548
	call RunMatchStatsScreen ; $454b
	push af ; $454e
	ld a, [wMatchWinLoseState] ; $454f
	ld [wMatchWinLoseFlag], a ; $4552
	pop af ; $4555
	cp $ff ; $4556
	jp nz, RunMatchWinLoseScreen ; $4558
	call ClearFrameTasks ; $455b
	ld c, $08 ; $455e
	call BeginFadeOut ; $4560
	call WaitFadeEnd ; $4563
	ld hl, rIE ; $4566
	res 1, [hl] ; $4569
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
	ld b, $14 ; $4585
	ld c, $05 ; $4587
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
	ld hl, MatchWinLoseScreenGfx ; $45c4
	ld de, wDecompBuffer ; $45c7
	call DecompressData ; $45ca
	ld hl, wDecompBuffer ; $45cd
	ld de, vTiles0 + VRAM_BANK1 ; $45d0
	ld c, $20 ; $45d3
	call QueueVRAMCopy ; $45d5
	ld hl, MatchWinLoseScreenGfx1 ; $45d8
	ld de, wDecompBuffer ; $45db
	call DecompressData ; $45de
	ld hl, wDecompBuffer ; $45e1
	ld de, vTiles0 + $20 * TILE_SIZE + VRAM_BANK1 ; $45e4
	ld c, $20 ; $45e7
	call QueueVRAMCopy ; $45e9
	ld hl, MatchWinLoseScreenPalettes ; $45ec
	lb de, $08, $03 ; $45ef palette index, count
	call LoadPaletteShadow ; $45f2
	ld b, TILEBLOCK_MatchWinLoseGfx ; $45f5
	ld c, MatchWinLoseGfx_SIZE / 16 ; $45f7
	ld de, vTiles0 + $40 * TILE_SIZE + VRAM_BANK1 ; $45f9
	farcall LoadCompressedTileBlock ; $45fc
	pop_wram_bank ; $45ff
	farcall QueueWram3MapToVRAM ; $4604
	ret ; $4607
MatchWinLoseScreenGfx:
	INCBIN "data/bank_016/MatchWinLoseScreenGfx.bin" ; $4608, 110 bytes
DiagramHighlightPaletteTask:
	INCBIN "data/bank_016/DiagramHighlightPaletteTask.bin" ; $4676, 108 bytes
DiagramNearFigureSpriteTask:
	INCBIN "data/bank_016/DiagramNearFigureSpriteTask.bin" ; $46e2, 42 bytes
DiagramFarFigureSpriteTask:
	INCBIN "data/bank_016/DiagramFarFigureSpriteTask.bin" ; $470c, 42 bytes
DiagramMarkerSpriteTask:
	INCBIN "data/bank_016/DiagramMarkerSpriteTask.bin" ; $4736, 30 bytes
DiagramBallSpriteTask:
	INCBIN "data/bank_016/DiagramBallSpriteTask.bin" ; $4754, 48 bytes
MatchWinLoseScreenGfx1:
	INCBIN "data/bank_016/MatchWinLoseScreenGfx1.bin" ; $4784, 10 bytes
DiagramSwingFigureSpriteTask:
	INCBIN "data/bank_016/DiagramSwingFigureSpriteTask.bin" ; $478e, 97 bytes
DiagramPolePairSpriteTask:
	INCBIN "data/bank_016/DiagramPolePairSpriteTask.bin" ; $47ef, 135 bytes
DiagramSpotMarkerSpriteTask:
	INCBIN "data/bank_016/DiagramSpotMarkerSpriteTask.bin" ; $4876, 75 bytes
DiagramTargetBracketsSpriteTask:
	INCBIN "data/bank_016/DiagramTargetBracketsSpriteTask.bin" ; $48c1, 51 bytes
MatchWinLoseScreenPalettes:
	INCBIN "data/bank_016/MatchWinLoseScreenPalettes.bin" ; $48f4, 24 bytes
LoadWinLoseScreenAssets:
	ld a, [wResultScreenWon] ; $490c
	or a ; $490f
	jr z, .zero ; $4910
	ld c, SCREENASSET_MatchStats2 ; $4912
	farcall LoadScreenAssetRecord ; $4914
	jr .testGameFlagByNumber ; $4917
.zero:
	ld c, SCREENASSET_MatchStats ; $4919
	farcall LoadScreenAssetRecord ; $491b
	jr .testGameFlagByNumber ; $491e
.testGameFlagByNumber:
	ld de, FLAG_DOUBLES ; $4920
	call TestGameFlagByNumber ; $4923
	jr nz, .done ; $4926
	wram_bank WRAM_SCREEN ; $4928
	ld hl, wShadowTilemap + 20 * TILEMAP_WIDTH ; $492e
	ld de, wShadowTilemap + 4 * TILEMAP_WIDTH + 11 ; $4931
	ld b, $09 ; $4934
	ld c, $05 ; $4936
	farcall CopyTilemapRect ; $4938
	ld hl, wShadowAttrmap + 20 * TILEMAP_WIDTH ; $493b
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 11 ; $493e
	ld b, $09 ; $4941
	ld c, $05 ; $4943
	farcall CopyTilemapRect ; $4945
	ld hl, wShadowTilemap + 20 * TILEMAP_WIDTH + 9 ; $4948
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH + 1 ; $494b
	ld b, $08 ; $494e
	ld c, $05 ; $4950
	farcall CopyTilemapRect ; $4952
	ld hl, wShadowAttrmap + 20 * TILEMAP_WIDTH + 9 ; $4955
	ld de, wShadowAttrmap + 11 * TILEMAP_WIDTH + 1 ; $4958
	ld b, $08 ; $495b
	ld c, $05 ; $495d
	farcall CopyTilemapRect ; $495f
.done:
	ret ; $4962
SetWinLosePortraitPaletteAttrs:
	ld a, [wResultScreenMode] ; $4963
	or a ; $4966
	jr nz, .nonZero ; $4967
	ld de, FLAG_DOUBLES ; $4969
	call TestGameFlagByNumber ; $496c
	jr z, .zero ; $496f
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 11 ; $4971
	ld b, $04 ; $4974
	ld c, $04 ; $4976
	ld h, $0c ; $4978
	farcall FillTilemapRect ; $497a
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 15 ; $497d
	ld b, $04 ; $4980
	ld c, $04 ; $4982
	ld h, $0d ; $4984
	farcall FillTilemapRect ; $4986
	ld de, wShadowAttrmap + 12 * TILEMAP_WIDTH + 2 ; $4989
	ld b, $03 ; $498c
	ld c, $03 ; $498e
	ld h, $0e ; $4990
	farcall FillTilemapRect ; $4992
	ld de, wShadowAttrmap + 12 * TILEMAP_WIDTH + 5 ; $4995
	ld b, $03 ; $4998
	ld c, $03 ; $499a
	ld h, $0f ; $499c
	farcall FillTilemapRect ; $499e
	jr .done ; $49a1
.zero:
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 13 ; $49a3
	ld b, $04 ; $49a6
	ld c, $04 ; $49a8
	ld h, $0c ; $49aa
	farcall FillTilemapRect ; $49ac
	ld de, wShadowAttrmap + 12 * TILEMAP_WIDTH + 3 ; $49af
	ld b, $03 ; $49b2
	ld c, $03 ; $49b4
	ld h, $0e ; $49b6
	farcall FillTilemapRect ; $49b8
.done:
	ret ; $49bb
.nonZero:
	ld de, FLAG_DOUBLES ; $49bc
	call TestGameFlagByNumber ; $49bf
	jr z, .fillTilemapRect ; $49c2
	ld de, wShadowAttrmap + 5 * TILEMAP_WIDTH + 12 ; $49c4
	ld b, $03 ; $49c7
	ld c, $03 ; $49c9
	ld h, $0c ; $49cb
	farcall FillTilemapRect ; $49cd
	ld de, wShadowAttrmap + 5 * TILEMAP_WIDTH + 15 ; $49d0
	ld b, $03 ; $49d3
	ld c, $03 ; $49d5
	ld h, $0d ; $49d7
	farcall FillTilemapRect ; $49d9
	ld de, wShadowAttrmap + 12 * TILEMAP_WIDTH + 2 ; $49dc
	ld b, $03 ; $49df
	ld c, $03 ; $49e1
	ld h, $0e ; $49e3
	farcall FillTilemapRect ; $49e5
	ld de, wShadowAttrmap + 12 * TILEMAP_WIDTH + 5 ; $49e8
	ld b, $03 ; $49eb
	ld c, $03 ; $49ed
	ld h, $0f ; $49ef
	farcall FillTilemapRect ; $49f1
	jr .doneB ; $49f4
.fillTilemapRect:
	ld de, wShadowAttrmap + 5 * TILEMAP_WIDTH + 13 ; $49f6
	ld b, $03 ; $49f9
	ld c, $03 ; $49fb
	ld h, $0c ; $49fd
	farcall FillTilemapRect ; $49ff
	ld de, wShadowAttrmap + 12 * TILEMAP_WIDTH + 3 ; $4a02
	ld b, $03 ; $4a05
	ld c, $03 ; $4a07
	ld h, $0e ; $4a09
	farcall FillTilemapRect ; $4a0b
.doneB:
	ret ; $4a0e
