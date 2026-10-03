UnassignExpPointFromChar:
	wram_bank WRAM_SCENE ; $72dd
	ld a, [wStoryCharacterSlot] ; $72e3
	or a ; $72e6
	jr nz, .nonZero ; $72e7
	ld hl, wExpScreenCharStats + 6 ; $72e9
	ld a, [hl+] ; $72ec
	ld d, [hl] ; $72ed
	ld e, a ; $72ee
	ld a, d ; $72ef
	or e ; $72f0
	jr z, .returnZero ; $72f1
	dec de ; $72f3
	dec hl ; $72f4
	ld a, e ; $72f5
	ld [hl+], a ; $72f6
	ld [hl], d ; $72f7
	ld hl, wExpScreenCharStats + 4 ; $72f8
	ld a, [hl+] ; $72fb
	ld d, [hl] ; $72fc
	ld e, a ; $72fd
	dec de ; $72fe
	dec hl ; $72ff
	ld a, e ; $7300
	ld [hl+], a ; $7301
	ld [hl], d ; $7302
	ld hl, wExpScreenCharStats + 8 ; $7303
	ld a, [hl+] ; $7306
	ld d, [hl] ; $7307
	ld e, a ; $7308
	inc de ; $7309
	dec hl ; $730a
	ld a, e ; $730b
	ld [hl+], a ; $730c
	ld [hl], d ; $730d
	call CheckExpLevelDown ; $730e
	jr .step2 ; $7311
.nonZero:
	ld hl, wExpScreenCharStats + 21 ; $7313
	ld a, [hl+] ; $7316
	ld d, [hl] ; $7317
	ld e, a ; $7318
	ld a, d ; $7319
	or e ; $731a
	jr z, .returnZero ; $731b
	dec de ; $731d
	dec hl ; $731e
	ld a, e ; $731f
	ld [hl+], a ; $7320
	ld [hl], d ; $7321
	ld hl, wExpScreenCharStats + 19 ; $7322
	ld a, [hl+] ; $7325
	ld d, [hl] ; $7326
	ld e, a ; $7327
	dec de ; $7328
	dec hl ; $7329
	ld a, e ; $732a
	ld [hl+], a ; $732b
	ld [hl], d ; $732c
	ld hl, wExpScreenCharStats + 23 ; $732d
	ld a, [hl+] ; $7330
	ld d, [hl] ; $7331
	ld e, a ; $7332
	inc de ; $7333
	dec hl ; $7334
	ld a, e ; $7335
	ld [hl+], a ; $7336
	ld [hl], d ; $7337
	call CheckExpLevelDown ; $7338
.step2:
	ld hl, wExpPoolRemaining ; $733b
	ld a, [hl+] ; $733e
	ld d, [hl] ; $733f
	ld e, a ; $7340
	inc de ; $7341
	dec hl ; $7342
	ld a, e ; $7343
	ld [hl+], a ; $7344
	ld [hl], d ; $7345
	ld a, $01 ; $7346
	ret ; $7348
.returnZero:
	xor a ; $7349
	ret ; $734a
UploadExpScreenTilemapRows:
	wram_bank WRAM_SCREEN ; $734b
	ld hl, wShadowTilemap + 1 * TILEMAP_WIDTH ; $7351
	ld de, vBGMap0 + 1 * TILEMAP_WIDTH ; $7354
	ld c, 11 * TILEMAP_WIDTH / 16 ; $7357
	call QueueVRAMCopy ; $7359
	ld hl, wShadowTilemap + 13 * TILEMAP_WIDTH ; $735c
	ld de, vBGMap0 + 13 * TILEMAP_WIDTH ; $735f
	ld c, 2 * TILEMAP_WIDTH / 16 ; $7362
	call QueueVRAMCopy ; $7364
	ld hl, wShadowTilemap + 16 * TILEMAP_WIDTH ; $7367
	ld de, vBGMap0 + 16 * TILEMAP_WIDTH ; $736a
	ld c, $01 ; $736d
	call QueueVRAMCopy ; $736f
	ret ; $7372
RefreshExpScreenReadouts:
	call DrawExpPoolReadout ; $7373
	call DrawExpScreenLevelNumber ; $7376
	call DrawExpScreenLevelBar ; $7379
	ret ; $737c
CheckExpLevelUp:
	wram_bank WRAM_SCENE ; $737d
	ld a, [wStoryCharacterSlot] ; $7383
	or a ; $7386
	jr nz, .nonZero ; $7387
	ld hl, wExpScreenCharStats + 8 ; $7389
	ld a, [hl+] ; $738c
	ld d, [hl] ; $738d
	ld e, a ; $738e
	ld a, d ; $738f
	or e ; $7390
	ret nz ; $7391
	ld a, $ff ; $7392
	ld [wExpLevelUpFanfare], a ; $7394
	ld a, [wExpScreenCharStats] ; $7397
	inc a ; $739a
	ld [wExpScreenCharStats], a ; $739b
	dec a ; $739e
	farcall GetExpRequiredForLevel ; $739f
	ld a, l ; $73a2
	ld [wExpScreenCharStats + 1], a ; $73a3
	ld [wExpScreenCharStats + 8], a ; $73a6
	ld a, h ; $73a9
	ld [wExpScreenCharStats + 2], a ; $73aa
	ld [wExpScreenCharStats + 9], a ; $73ad
	xor a ; $73b0
	ld [wExpScreenCharStats + 4], a ; $73b1
	ld [wExpScreenCharStats + 5], a ; $73b4
	ret ; $73b7
.nonZero:
	ld hl, wExpScreenCharStats + 23 ; $73b8
	ld a, [hl+] ; $73bb
	ld d, [hl] ; $73bc
	ld e, a ; $73bd
	ld a, d ; $73be
	or e ; $73bf
	ret nz ; $73c0
	ld a, $ff ; $73c1
	ld [wExpLevelUpFanfare], a ; $73c3
	ld a, [wExpScreenCharStats + 15] ; $73c6
	inc a ; $73c9
	ld [wExpScreenCharStats + 15], a ; $73ca
	dec a ; $73cd
	farcall GetExpRequiredForLevel ; $73ce
	ld a, l ; $73d1
	ld [wExpScreenCharStats + 16], a ; $73d2
	ld [wExpScreenCharStats + 23], a ; $73d5
	ld a, h ; $73d8
	ld [wExpScreenCharStats + 17], a ; $73d9
	ld [wExpScreenCharStats + 24], a ; $73dc
	xor a ; $73df
	ld [wExpScreenCharStats + 19], a ; $73e0
	ld [wExpScreenCharStats + 20], a ; $73e3
	ret ; $73e6
CheckExpLevelDown:
	wram_bank WRAM_SCENE ; $73e7
	ld a, [wStoryCharacterSlot] ; $73ed
	or a ; $73f0
	jr nz, .nonZero ; $73f1
	ld hl, wExpScreenCharStats + 4 ; $73f3
	ld a, [hl+] ; $73f6
	ld d, [hl] ; $73f7
	ld e, a ; $73f8
	inc de ; $73f9
	ld a, d ; $73fa
	or e ; $73fb
	ret nz ; $73fc
	ld a, [wExpScreenCharStats] ; $73fd
	dec a ; $7400
	ld [wExpScreenCharStats], a ; $7401
	dec a ; $7404
	farcall GetExpRequiredForLevel ; $7405
	ld a, l ; $7408
	ld [wExpScreenCharStats + 1], a ; $7409
	ld a, h ; $740c
	ld [wExpScreenCharStats + 2], a ; $740d
	dec hl ; $7410
	ld a, l ; $7411
	ld [wExpScreenCharStats + 4], a ; $7412
	ld a, h ; $7415
	ld [wExpScreenCharStats + 5], a ; $7416
	ld a, $01 ; $7419
	ld [wExpScreenCharStats + 8], a ; $741b
	dec a ; $741e
	ld [wExpScreenCharStats + 9], a ; $741f
	ret ; $7422
.nonZero:
	ld hl, wExpScreenCharStats + 19 ; $7423
	ld a, [hl+] ; $7426
	ld d, [hl] ; $7427
	ld e, a ; $7428
	inc de ; $7429
	ld a, d ; $742a
	or e ; $742b
	ret nz ; $742c
	ld a, [wExpScreenCharStats + 15] ; $742d
	dec a ; $7430
	ld [wExpScreenCharStats + 15], a ; $7431
	dec a ; $7434
	farcall GetExpRequiredForLevel ; $7435
	ld a, l ; $7438
	ld [wExpScreenCharStats + 16], a ; $7439
	ld a, h ; $743c
	ld [wExpScreenCharStats + 17], a ; $743d
	dec hl ; $7440
	ld a, l ; $7441
	ld [wExpScreenCharStats + 19], a ; $7442
	ld a, h ; $7445
	ld [wExpScreenCharStats + 20], a ; $7446
	ld a, $01 ; $7449
	ld [wExpScreenCharStats + 23], a ; $744b
	dec a ; $744e
	ld [wExpScreenCharStats + 24], a ; $744f
	ret ; $7452
.step2:
	wram_bank WRAM_SCENE ; $7453
	ld hl, wExpCursorChar ; $7459
	set 2, [hl] ; $745c
	wram_bank WRAM_SCENE ; $745e
	ld a, [wExpScreenCharStats + 10] ; $7464
	ld [wBGPalettes + 58], a ; $7467
	ld a, [wExpScreenCharStats + 11] ; $746a
	ld [wBGPalettes + 59], a ; $746d
	ld a, [wExpScreenCharStats + 25] ; $7470
	ld [wBGPalettes + 34], a ; $7473
	ld a, [wExpScreenCharStats + 26] ; $7476
	ld [wBGPalettes + 35], a ; $7479
	ld a, [wStoryModeMainCharacterOverworldSpriteColor] ; $747c
	ld_bg_pals de, 1, 1 ; $747f
	farcall LoadIndexedPaletteThunk ; $7482
	ld a, [wStoryModePartnerCharacterOverworldSpriteColor] ; $7485
	ld_bg_pals de, 2, 1 ; $7488
	farcall LoadIndexedPaletteThunk ; $748b
	ld hl, hPaletteDirtyFlags ; $748e
	set 0, [hl] ; $7491
	sound SFX_MENU_SELECT ; $7493
	farcall BackupCharDataScreenRow ; $7495
	ld hl, ExpLevelDownTilemapPatch4 ; $7498
	ld bc, wCharDataScreenCell + 18 * TILEMAP_WIDTH ; $749b
	call ApplyTilemapPatchListExpScreen ; $749e
	call UploadExpPromptWindowRows ; $74a1
	wait_frames 2 ; $74a4
	ld hl, ExpLevelDownTilemapPatch3 ; $74a8
	ld bc, wCharDataScreenCell + 18 * TILEMAP_WIDTH ; $74ab
	call ApplyTilemapPatchListExpScreen ; $74ae
	call UploadExpPromptWindowRows ; $74b1
	wait_frames 2 ; $74b4
	ld hl, ExpLevelDownTilemapPatch2 ; $74b8
	ld bc, wCharDataScreenCell + 18 * TILEMAP_WIDTH ; $74bb
	call ApplyTilemapPatchListExpScreen ; $74be
	call UploadExpPromptWindowRows ; $74c1
	wait_frames 2 ; $74c4
	ld hl, ExpLevelDownTilemapPatch1 ; $74c8
	ld bc, wCharDataScreenCell + 18 * TILEMAP_WIDTH ; $74cb
	call ApplyTilemapPatchListExpScreen ; $74ce
	call UploadExpPromptWindowRows ; $74d1
	wait_frames 2 ; $74d4
	ld hl, ExpLevelDownTilemapPatch0 ; $74d8
	ld bc, wCharDataScreenCell + 18 * TILEMAP_WIDTH ; $74db
	call ApplyTilemapPatchListExpScreen ; $74de
	call UploadExpPromptWindowRows ; $74e1
	wait_frames 2 ; $74e4
	ld hl, ExpPromptWindowFrame_1d ; $74e8
	ld bc, wCharDataScreenCell + 18 * TILEMAP_WIDTH ; $74eb
	call ApplyTilemapPatchListExpScreen ; $74ee
	call UploadExpPromptWindowRows ; $74f1
	wait_frames 12 ; $74f4
	wram_bank WRAM_SCENE ; $74f8
	ld a, $01 ; $74fe
	ld [wExpPromptCursorRow], a ; $7500
	jr UploadExpPromptWindowRows.loop ; $7503
UploadExpPromptWindowRows:
	wram_bank WRAM_SCREEN ; $7505
	ld hl, wCharDataScreenCell + 12 * TILEMAP_WIDTH ; $750b
	ld de, vBGMap0 + 12 * TILEMAP_WIDTH ; $750e
	ld c, $0c ; $7511
	call QueueVRAMCopy ; $7513
	wram_bank WRAM_COURT_PLANES ; $7516
	ld hl, wCharDataScreenCell + 12 * TILEMAP_WIDTH ; $751c
	ld de, vBGMap0 + 12 * TILEMAP_WIDTH + VRAM_BANK1 ; $751f
	ld c, $0c ; $7522
	call QueueVRAMCopy ; $7524
	ret ; $7527
.loop:
	call DrawExpPromptCursor ; $7528
	call TickLevelUpJingle ; $752b
	call AdvanceFrame ; $752e
	ldh a, [hInputRisingEdge] ; $7531
	bit PADB_UP, a ; $7533
	jr nz, DrawExpPromptCursor.playSfx ; $7535
	bit 7, a ; $7537
	jr nz, DrawExpPromptCursor.playSfx ; $7539
	bit 0, a ; $753b
	jr nz, DrawExpPromptCursor.bit0Set ; $753d
	bit 1, a ; $753f
	jr nz, DrawExpPromptCursor.playSfx2 ; $7541
	jr .loop ; $7543
UploadExpPromptWindowRowsClosing:
	wram_bank WRAM_SCREEN ; $7545
	ld hl, wCharDataScreenCell + 12 * TILEMAP_WIDTH ; $754b
	ld de, vBGMap0 + 12 * TILEMAP_WIDTH ; $754e
	ld c, $0c ; $7551
	call QueueVRAMCopy ; $7553
	wram_bank WRAM_COURT_PLANES ; $7556
	ld hl, wCharDataScreenCell + 12 * TILEMAP_WIDTH ; $755c
	ld de, vBGMap0 + 12 * TILEMAP_WIDTH + VRAM_BANK1 ; $755f
	ld c, $0c ; $7562
	call QueueVRAMCopy ; $7564
	ret ; $7567
DrawExpPromptCursor:
	ldh a, [hVBlankCounter] ; $7568
	and $08 ; $756a
	ret z ; $756c
	ld_oam bc, OAM_BANK1, $16 ; $756d
	ld de, $0c7f ; $7570
	ld a, [wExpPromptCursorRow] ; $7573
	or a ; $7576
	jr z, .queueSprite ; $7577
	ld e, $87 ; $7579
.queueSprite:
	call QueueSprite ; $757b
	ret ; $757e
.playSfx:
	sound SFX_MENU_MOVE ; $757f
	ld a, [wExpPromptCursorRow] ; $7581
	xor $01 ; $7584
	ld [wExpPromptCursorRow], a ; $7586
	jr UploadExpPromptWindowRows.loop ; $7589
.bit0Set:
	ld a, [wExpPromptCursorRow] ; $758b
	or a ; $758e
	jr nz, .playSfx2 ; $758f
	sound SFX_MENU_SELECT ; $7591
	ret ; $7593
.playSfx2:
	sound SFX_MENU_CANCEL ; $7594
	farcall RestoreCharDataScreenRow ; $7596
	ld hl, ExpLevelDownTilemapPatch0 ; $7599
	ld bc, wCharDataScreenCell + 18 * TILEMAP_WIDTH ; $759c
	call ApplyTilemapPatchListExpScreen ; $759f
	call UploadExpPromptWindowRowsClosing ; $75a2
	wait_frames 2 ; $75a5
	farcall RestoreCharDataScreenRow ; $75a9
	ld hl, ExpLevelDownTilemapPatch1 ; $75ac
	ld bc, wCharDataScreenCell + 18 * TILEMAP_WIDTH ; $75af
	call ApplyTilemapPatchListExpScreen ; $75b2
	call UploadExpPromptWindowRowsClosing ; $75b5
	wait_frames 2 ; $75b8
	farcall RestoreCharDataScreenRow ; $75bc
	ld hl, ExpLevelDownTilemapPatch2 ; $75bf
	ld bc, wCharDataScreenCell + 18 * TILEMAP_WIDTH ; $75c2
	call ApplyTilemapPatchListExpScreen ; $75c5
	call UploadExpPromptWindowRowsClosing ; $75c8
	wait_frames 2 ; $75cb
	farcall RestoreCharDataScreenRow ; $75cf
	ld hl, ExpLevelDownTilemapPatch3 ; $75d2
	ld bc, wCharDataScreenCell + 18 * TILEMAP_WIDTH ; $75d5
	call ApplyTilemapPatchListExpScreen ; $75d8
	call UploadExpPromptWindowRowsClosing ; $75db
	wait_frames 2 ; $75de
	farcall RestoreCharDataScreenRow ; $75e2
	ld hl, ExpLevelDownTilemapPatch4 ; $75e5
	ld bc, wCharDataScreenCell + 18 * TILEMAP_WIDTH ; $75e8
	call ApplyTilemapPatchListExpScreen ; $75eb
	call UploadExpPromptWindowRowsClosing ; $75ee
	wait_frames 2 ; $75f1
	farcall RestoreCharDataScreenRow ; $75f5
	call UploadExpPromptWindowRowsClosing ; $75f8
	wait_frames 2 ; $75fb
	wram_bank WRAM_SCENE ; $75ff
	ld hl, wExpCursorChar ; $7605
	res 2, [hl] ; $7608
	call UpdateExpScreenSelectionPalettes ; $760a
	jp RunExpDistributionLoop ; $760d
ApplyTilemapPatchListExpScreen:
	ld a, [hl] ; $7610
	cp $ff ; $7611
	ret z ; $7613
	push hl ; $7614
	ld d, [hl] ; $7615
	inc hl ; $7616
	ld e, [hl] ; $7617
	push hl ; $7618
	ld hl, wScreenAttrmap ; $7619
	add hl, de ; $761c
	ld d, h ; $761d
	ld e, l ; $761e
	pop hl ; $761f
	inc hl ; $7620
	push hl ; $7621
	ld a, [hl] ; $7622
	ld h, b ; $7623
	ld l, c ; $7624
	add l ; $7625
	ld l, a ; $7626
	jr nc, .gotSrc ; $7627
	inc h ; $7629
.gotSrc:
	wram_bank WRAM_SCENE ; $762a
	ld a, l ; $7630
	ld [wCharDataNumberBuffer], a ; $7631
	ld a, h ; $7634
	ld [wCharDataNumberBuffer + 1], a ; $7635
	pop hl ; $7638
	push bc ; $7639
	inc hl ; $763a
	ld c, [hl] ; $763b
	ld hl, wCharDataNumberBuffer ; $763c
	ld a, [hl+] ; $763f
	ld h, [hl] ; $7640
	ld l, a ; $7641
.copyLoop:
	wram_bank WRAM_SCREEN ; $7642
	ld a, [hl] ; $7648
	ld [de], a ; $7649
	wram_bank WRAM_COURT_PLANES ; $764a
	ld a, [hl+] ; $7650
	ld [de], a ; $7651
	inc de ; $7652
	dec c ; $7653
	jr nz, .copyLoop ; $7654
	pop bc ; $7656
	pop hl ; $7657
	inc hl ; $7658
	inc hl ; $7659
	inc hl ; $765a
	inc hl ; $765b
	jr ApplyTilemapPatchListExpScreen ; $765c
DrawExpToNextLevelTask:
	wram_bank WRAM_SCENE ; $765e
	ld a, [wExpCursorChar] ; $7664
	bit 0, a ; $7667
	ret nz ; $7669
	bit 2, a ; $766a
	ret nz ; $766c
	ld a, [wCharDataViewOnly] ; $766d
	or a ; $7670
	ret nz ; $7671
	ld a, [wStoryCharacterSlot] ; $7672
	or a ; $7675
	jr nz, .nonZero ; $7676
	wram_bank WRAM_SCENE ; $7678
	ld a, [wExpScreenCharStats] ; $767e
	cp $64 ; $7681
	ret nc ; $7683
	ld hl, wExpScreenCharStats + 8 ; $7684
	ld a, [hl+] ; $7687
	ld h, [hl] ; $7688
	ld l, a ; $7689
	ld a, $03 ; $768a
	ld de, wCharDataNumberBuffer ; $768c
	call FormatDecimalNumberUnsigned ; $768f
	ld a, [wCharDataNumberBuffer] ; $7692
	cp $20 ; $7695
	jr z, .eq20 ; $7697
	call GetExpScreenDigitSprite ; $7699
	ld_xy de, $18, $2f ; $769c
	call QueueSprite ; $769f
.eq20:
	ld a, [wCharDataNumberBuffer + 1] ; $76a2
	cp $20 ; $76a5
	jr z, .eq202 ; $76a7
	call GetExpScreenDigitSprite ; $76a9
	ld_xy de, $1f, $2f ; $76ac
	call QueueSprite ; $76af
.eq202:
	ld a, [wCharDataNumberBuffer + 2] ; $76b2
	call GetExpScreenDigitSprite ; $76b5
	ld_xy de, $26, $2f ; $76b8
	call QueueSprite ; $76bb
	ld hl, DrawExpToNextLevelTask_SpriteTemplate0 ; $76be
	ld_oam bc, OAM_BANK1 | 6, $2c ; $76c1
	ld_xy de, $14, $2e ; $76c4
	call QueueSpriteTemplate ; $76c7
	ret ; $76ca
.nonZero:
	wram_bank WRAM_SCENE ; $76cb
	ld a, [wExpScreenCharStats + 15] ; $76d1
	cp $64 ; $76d4
	ret nc ; $76d6
	ld hl, wExpScreenCharStats + 23 ; $76d7
	ld a, [hl+] ; $76da
	ld h, [hl] ; $76db
	ld l, a ; $76dc
	ld a, $03 ; $76dd
	ld de, wCharDataNumberBuffer ; $76df
	call FormatDecimalNumberUnsigned ; $76e2
	ld a, [wCharDataNumberBuffer] ; $76e5
	cp $20 ; $76e8
	jr z, .eq203 ; $76ea
	call GetExpScreenDigitSprite ; $76ec
	ld_xy de, $18, $62 ; $76ef
	call QueueSprite ; $76f2
.eq203:
	ld a, [wCharDataNumberBuffer + 1] ; $76f5
	cp $20 ; $76f8
	jr z, .eq204 ; $76fa
	call GetExpScreenDigitSprite ; $76fc
	ld_xy de, $1f, $62 ; $76ff
	call QueueSprite ; $7702
.eq204:
	ld a, [wCharDataNumberBuffer + 2] ; $7705
	call GetExpScreenDigitSprite ; $7708
	ld_xy de, $26, $62 ; $770b
	call QueueSprite ; $770e
	ld hl, DrawExpToNextLevelTask_SpriteTemplate1 ; $7711
	ld_oam bc, OAM_BANK1 | 6, $44 ; $7714
	ld_xy de, $14, $61 ; $7717
	call QueueSpriteTemplate ; $771a
	ret ; $771d
GetExpScreenDigitSprite:
	sub $30 ; $771e
	rlca ; $7720
	add $18 ; $7721
	ld c, a ; $7723
	ld b, $0e ; $7724
	ret ; $7726
DrawExpCharCursorTask:
	wram_bank WRAM_SCENE ; $7727
	ld a, [wExpCursorSlide] ; $772d
	ld_hl_indexed DrawExpCharCursorTaskTable ; $7730
	ld a, [hl] ; $7737
	inc a ; $7738
	ld e, a ; $7739
	ld d, $19 ; $773a
	ld hl, DrawExpCharCursorTask_SpriteTemplate ; $773c
	ld_oam bc, OAM_BANK1 | 6, $00 ; $773f
	call QueueSpriteTemplate ; $7742
	ret ; $7745
DrawExpCharCursorTaskTable:
	; $7746, 26 bytes (bytes:16)
	db $00, $01, $02, $03, $04, $06, $08, $0a, $0d, $11, $16, $1d, $24, $2b, $32, $37 ; 0x00
	db $3b, $3e, $40, $42, $44, $45, $46, $47, $48, $00 ; 0x10
DrawExpBarFillMarkersTask:
	wram_bank WRAM_SCENE ; $7760
	ld de, $3801 ; $7766
	ld a, [wExpScreenCharStats + 3] ; $7769
	add d ; $776c
	ld d, a ; $776d
	ld hl, DrawExpBarFillMarkersTask_SpriteTemplate ; $776e
	ld_oam bc, OAM_BANK1 | 7, $0c ; $7771
	call QueueSpriteTemplate ; $7774
	ld de, $3849 ; $7777
	ld a, [wExpScreenCharStats + 18] ; $777a
	add d ; $777d
	ld d, a ; $777e
	ld hl, DrawExpBarFillMarkersTask_SpriteTemplate ; $777f
	ld_oam bc, OAM_BANK1 | 7, $0c ; $7782
	call QueueSpriteTemplate ; $7785
	ret ; $7788
DrawExpBarSweepSpriteTask:
	ld e, $01 ; $7789
	ld a, [wStoryCharacterSlot] ; $778b
	or a ; $778e
	jr z, .zero ; $778f
	ld e, $49 ; $7791
.zero:
	wram_bank WRAM_SCENE ; $7793
	ld a, [wExpBarMarkerX] ; $7799
	ld d, a ; $779c
	ld hl, DrawExpBarSweepSpriteTask_SpriteTemplate ; $779d
	ld_oam bc, OAM_BANK1 | 7, $10 ; $77a0
	call QueueSpriteTemplate ; $77a3
	ret ; $77a6
