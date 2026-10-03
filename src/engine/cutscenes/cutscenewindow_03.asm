FillMemoryDE:
	ld a, b ; $6fef
	ld [hl+], a ; $6ff0
	dec de ; $6ff1
	ld a, d ; $6ff2
	or e ; $6ff3
	jr nz, FillMemoryDE ; $6ff4
	ret ; $6ff6
PlayScrollingStoryCutscene:
	push af ; $6ff7
	push bc ; $6ff8
	push de ; $6ff9
	push hl ; $6ffa
	ld b, a ; $6ffb
	ldh a, [hWramBank] ; $6ffc
	push af ; $6ffe
	ld a, b ; $6fff
	push af ; $7000
	ld hl, WindowSolidTile_03 ; $7001
	ld de, vTiles1 + $7f * TILE_SIZE ; $7004
	ld c, 1 ; $7007
	call QueueVRAMCopy ; $7009
	ld hl, WindowAttrMap_03 ; $700c
	ld de, vBGMap1 + VRAM_BANK1 ; $700f
	ld c, 8 * TILEMAP_WIDTH / 16 ; $7012
	call QueueVRAMCopy ; $7014
	ld hl, WindowTileMap_03 ; $7017
	ld de, vBGMap1 ; $701a
	ld c, 8 * TILEMAP_WIDTH / 16 ; $701d
	call QueueVRAMCopy ; $701f
	call AdvanceFrame ; $7022
	farcall StopSceneScrollTask ; $7025
	ld a, $90 ; $7028
	ldh [rWY], a ; $702a
	wram_bank WRAM_SCENE ; $702c
	xor a ; $7032
	ld [wCutsceneSlideDone], a ; $7033
	ld [wCutsceneSlideTimer], a ; $7036
	pop af ; $7039
	push af ; $703a
	ld [wCutsceneWindowSliding], a ; $703b
	ld a, $01 ; $703e
	ld hl, AnimateWindowSlideUpTask ; $7040
	call RegisterFrameTask ; $7043
.loop:
	call AdvanceFrame ; $7046
	ld a, [wCutsceneSlideDone] ; $7049
	or a ; $704c
	jr z, .loop ; $704d
	ld a, $20 ; $704f
.loopB:
	call AdvanceFrame ; $7051
	dec a ; $7054
	or a ; $7055
	jr nz, .loopB ; $7056
	wram_bank WRAM_STAGING ; $7058
	ld hl, wDecompBuffer ; $705e
	ld b, $20 ; $7061
	ld de, $0300 ; $7063
	call FillMemoryDE ; $7066
	wram_bank WRAM_TEXT ; $7069
	ld hl, wWindowShadowTilemap ; $706f
	ld b, $20 ; $7072
	ld de, $0100 ; $7074
	call FillMemoryDE ; $7077
	call AdvanceFrame ; $707a
	pop af ; $707d
	call DrawCutsceneTextPage ; $707e
	call ScrollCutsceneTextWindow ; $7081
	pop_wram_bank ; $7084
	pop hl ; $7089
	pop de ; $708a
	pop bc ; $708b
	pop af ; $708c
	ret ; $708d
	; $708e, 2 bytes (fill)
	ds 2, $00
	ds ALIGN[4]
WindowSolidTile_03:
	ds 16, $ff ; $7090, fill
	ds ALIGN[4]
WindowAttrMap_03:
	; $70a0, 256 bytes (pattern)
	ds 256, $80
	ds ALIGN[4]
WindowTileMap_03:
	; $71a0, 256 bytes (pattern)
	ds 256, $20
AnimateWindowSlideUpTask:
	push_wram_bank WRAM_SCENE ; $72a0
	ld a, [wCutsceneWindowSliding] ; $72a9
	ld b, a ; $72ac
	ld hl, WindowSlideStepTable_03 ; $72ad
	ld a, b ; $72b0
	add a ; $72b1
	add l ; $72b2
	ld l, a ; $72b3
	jr nc, .read ; $72b4
	inc h ; $72b6
.read:
	ld a, [hl+] ; $72b7
	ld c, a ; $72b8
	ld e, [hl] ; $72b9
	ld d, $00 ; $72ba
	pop_wram_bank ; $72bc
	ldh a, [hVBlankCounter] ; $72c1
	and $01 ; $72c3
	jr nz, .maskSet ; $72c5
	ldh a, [hScrollY] ; $72c7
	add c ; $72c9
	ldh [hScrollY], a ; $72ca
	ld hl, wRasterScrollStartLY ; $72cc
	ld a, [hl+] ; $72cf
	ld h, [hl] ; $72d0
	ld l, a ; $72d1
	add hl, de ; $72d2
	ld d, h ; $72d3
	ld e, l ; $72d4
	ld hl, wRasterScrollStartLY ; $72d5
	ld a, e ; $72d8
	ld [hl+], a ; $72d9
	ld [hl], d ; $72da
.maskSet:
	ld a, [wCutsceneSlideTimer] ; $72db
	inc a ; $72de
	ld [wCutsceneSlideTimer], a ; $72df
	and $3f ; $72e2
	ld b, a ; $72e4
	ld a, $90 ; $72e5
	sub b ; $72e7
	ldh [rWY], a ; $72e8
	ld a, b ; $72ea
	cp $3f ; $72eb
	jr nz, .done ; $72ed
	ld hl, AnimateWindowSlideUpTask ; $72ef
	call UnregisterFrameTask ; $72f2
	wram_bank WRAM_SCENE ; $72f5
	ld a, $01 ; $72fb
	ld [wCutsceneSlideDone], a ; $72fd
.done:
	ret ; $7300
WindowSlideStepTable_03:
	; $7301, 50 bytes (bytes:2)
	db $01, $20 ; 0x00
	db $01, $20 ; 0x02
	db $01, $20 ; 0x04
	db $02, $40 ; 0x06
	db $01, $20 ; 0x08
	db $01, $20 ; 0x0a
	db $01, $20 ; 0x0c
	db $01, $20 ; 0x0e
	db $01, $20 ; 0x10
	db $01, $20 ; 0x12
	db $01, $20 ; 0x14
	db $00, $00 ; 0x16
	db $00, $00 ; 0x18
	db $01, $20 ; 0x1a
	db $01, $20 ; 0x1c
	db $00, $00 ; 0x1e
	db $01, $20 ; 0x20
	db $01, $20 ; 0x22
	db $01, $20 ; 0x24
	db $01, $20 ; 0x26
	db $01, $20 ; 0x28
	db $01, $20 ; 0x2a
	db $01, $20 ; 0x2c
	db $01, $20 ; 0x2e
	db $02, $20 ; 0x30
DrawCutsceneTextPage:
	push af ; $7333
	push bc ; $7334
	push de ; $7335
	push hl ; $7336
	ld b, a ; $7337
	ldh a, [hWramBank] ; $7338
	push af ; $733a
	and $0f ; $733b
	ld a, b ; $733d
	ld c, a ; $733e
	add a ; $733f
	add c ; $7340
	add a ; $7341
	add c ; $7342
	ld hl, TextPageDescriptors_03 ; $7343
	add l ; $7346
	ld l, a ; $7347
	jr nc, .gotPtr ; $7348
	inc h ; $734a
.gotPtr:
	wram_bank WRAM_SCENE ; $734b
	ld a, [hl] ; $7351
	ld [wCutsceneTextScrollRows], a ; $7352
	ld b, a ; $7355
	inc hl ; $7356
	ld c, $00 ; $7357
.loop:
	call DrawCutsceneTextLines ; $7359
	call AdvanceFrame ; $735c
	inc hl ; $735f
	inc hl ; $7360
	inc c ; $7361
	ld a, c ; $7362
	cp b ; $7363
	jr nz, .loop ; $7364
	pop_wram_bank ; $7366
	pop hl ; $736b
	pop de ; $736c
	pop bc ; $736d
	pop af ; $736e
	ret ; $736f
TextPageDescriptors_03:
	; $7370, 147 bytes (records:7)
; 21 records x 7 bytes
	db $02, $00, $04, $04, $06, $00, $00 ; record 0
	db $01, $0a, $04, $00, $00, $00, $00 ; record 1
	db $01, $0e, $04, $00, $00, $00, $00 ; record 2
	db $01, $12, $04, $00, $00, $00, $00 ; record 3
	db $01, $16, $04, $00, $00, $00, $00 ; record 4
	db $01, $1a, $04, $00, $00, $00, $00 ; record 5
	db $01, $1e, $06, $00, $00, $00, $00 ; record 6
	db $02, $24, $06, $2a, $06, $00, $00 ; record 7
	db $01, $30, $06, $00, $00, $00, $00 ; record 8
	db $02, $36, $06, $3c, $06, $00, $00 ; record 9
	db $01, $42, $06, $00, $00, $00, $00 ; record 10
	db $01, $48, $05, $00, $00, $00, $00 ; record 11
	db $01, $4d, $05, $00, $00, $00, $00 ; record 12
	db $01, $52, $07, $00, $00, $00, $00 ; record 13
	db $02, $59, $05, $5e, $07, $00, $00 ; record 14
	db $01, $65, $05, $00, $00, $00, $00 ; record 15
	db $03, $6a, $06, $70, $06, $76, $05 ; record 16
	db $02, $7b, $07, $82, $07, $00, $00 ; record 17
	db $02, $7b, $07, $82, $07, $00, $00 ; record 18
	db $01, $89, $06, $00, $00, $00, $00 ; record 19
	db $01, $8f, $04, $00, $00, $00, $00 ; record 20
DrawCutsceneTextLines:
	push af ; $7403
	push bc ; $7404
	push de ; $7405
	push hl ; $7406
	ldh a, [hWramBank] ; $7407
	push af ; $7409
	push hl ; $740a
	ld hl, $0014 ; $740b
	ld a, c ; $740e
	or a ; $740f
	jr nz, .mulHLByA ; $7410
	ld h, $00 ; $7412
	ld l, $00 ; $7414
	jr .step ; $7416
.mulHLByA:
	call MulHLByA ; $7418
.step:
	ld de, wCutsceneTextScrollBuffer + 99 ; $741b
	add hl, de ; $741e
	ld d, h ; $741f
	ld e, l ; $7420
	pop hl ; $7421
	ld a, [hl+] ; $7422
	push af ; $7423
	ld a, [hl] ; $7424
	ld b, a ; $7425
	ld hl, $30ab ; $7426
	pop af ; $7429
	add l ; $742a
	ld l, a ; $742b
	jr nc, .gotPtr ; $742c
	inc h ; $742e
.gotPtr:
	wram_bank WRAM_STAGING ; $742f
.loop:
	ld c, $50 ; $7435
	call DrawDialogueLineToBuffer ; $7437
	call AdvanceFrame ; $743a
	ld a, $50 ; $743d
	add e ; $743f
	ld e, a ; $7440
	jr nc, .gotPtr2 ; $7441
	inc d ; $7443
.gotPtr2:
	inc hl ; $7444
	dec b ; $7445
	jr nz, .loop ; $7446
	pop_wram_bank ; $7448
	pop hl ; $744d
	pop de ; $744e
	pop bc ; $744f
	pop af ; $7450
	ret ; $7451
ScrollCutsceneTextWindow:
	push af ; $7452
	push bc ; $7453
	push de ; $7454
	push hl ; $7455
	push_wram_bank WRAM_SCENE ; $7456
	ld a, [wCutsceneTextScrollRows] ; $745f
	and $03 ; $7462
	jr nz, .maskSet ; $7464
	ld a, $01 ; $7466
.maskSet:
	ld b, a ; $7468
	ld d, $00 ; $7469
	ld c, $00 ; $746b
.loop:
	call AdvanceFrame ; $746d
	ld e, $14 ; $7470
.loopB:
	call BlitCutsceneTextWindow ; $7472
	inc c ; $7475
	dec e ; $7476
	jr nz, .loopB ; $7477
	ld e, $ff ; $7479
.loop2:
	call AdvanceFrame ; $747b
	dec e ; $747e
	jr nz, .loop2 ; $747f
	inc d ; $7481
	ld a, d ; $7482
	cp b ; $7483
	jr nz, .loop ; $7484
	pop_wram_bank ; $7486
	pop hl ; $748b
	pop de ; $748c
	pop bc ; $748d
	pop af ; $748e
	ret ; $748f
BlitCutsceneTextWindow:
	push af ; $7490
	push bc ; $7491
	push de ; $7492
	push hl ; $7493
	ldh a, [hWramBank] ; $7494
	push af ; $7496
	ld hl, wCutsceneTextScrollBuffer ; $7497
	ld a, c ; $749a
	add l ; $749b
	ld l, a ; $749c
	jr nc, .gotPtr ; $749d
	inc h ; $749f
.gotPtr:
	ld b, $08 ; $74a0
	ld de, wWindowShadowTilemap ; $74a2
.loop:
	ld c, $14 ; $74a5
	push hl ; $74a7
	push de ; $74a8
.loopB:
	wram_bank WRAM_STAGING ; $74a9
	ld a, [hl+] ; $74af
	push hl ; $74b0
	ld h, d ; $74b1
	ld l, e ; $74b2
	push af ; $74b3
	wram_bank WRAM_TEXT ; $74b4
	pop af ; $74ba
	ld [hl], a ; $74bb
	inc de ; $74bc
	pop hl ; $74bd
	dec c ; $74be
	jr nz, .loopB ; $74bf
	pop de ; $74c1
	pop hl ; $74c2
	ld a, $50 ; $74c3
	add l ; $74c5
	ld l, a ; $74c6
	jr nc, .gotPtr2 ; $74c7
	inc h ; $74c9
.gotPtr2:
	ld a, $20 ; $74ca
	add e ; $74cc
	ld e, a ; $74cd
	jr nc, .gotPtr3 ; $74ce
	inc d ; $74d0
.gotPtr3:
	dec b ; $74d1
	jr nz, .loop ; $74d2
	wram_bank WRAM_TEXT ; $74d4
	ld hl, wWindowShadowTilemap ; $74da
	ld de, vBGMap1 ; $74dd
	ld c, 8 * TILEMAP_WIDTH / 16 ; $74e0
	call QueueVRAMCopy ; $74e2
	call AdvanceFrame ; $74e5
	pop_wram_bank ; $74e8
	pop hl ; $74ed
	pop de ; $74ee
	pop bc ; $74ef
	pop af ; $74f0
	ret ; $74f1
DrawDialogueLineToBuffer:
	push af ; $74f2
	push bc ; $74f3
	push de ; $74f4
	push hl ; $74f5
	ldh a, [hWramBank] ; $74f6
	push af ; $74f8
	farcall FetchDialogueText ; $74f9
	ld hl, wTextBuffer ; $74fc
	wram_bank WRAM_STAGING ; $74ff
	ld c, $14 ; $7505
.loop:
	ld a, [hl+] ; $7507
	or a ; $7508
	jr z, .restore ; $7509
	push hl ; $750b
	ld h, d ; $750c
	ld l, e ; $750d
	ld [hl], a ; $750e
	pop hl ; $750f
	inc de ; $7510
	dec c ; $7511
	jr nz, .loop ; $7512
.restore:
	pop_wram_bank ; $7514
	pop hl ; $7519
	pop de ; $751a
	pop bc ; $751b
	pop af ; $751c
	ret ; $751d
ShowStoryResultScreen:
	push af ; $751e
	push bc ; $751f
	push de ; $7520
	push hl ; $7521
	push_wram_bank WRAM_COURT_PLANES ; $7522
	ld hl, wScreenAttrmap ; $752b
	ld de, $0240 ; $752e
	ld b, $00 ; $7531
	call FillMemoryDE ; $7533
	wram_bank WRAM_SCREEN ; $7536
	ld hl, wShadowTilemap ; $753c
	ld de, $0240 ; $753f
	ld b, $20 ; $7542
	call FillMemoryDE ; $7544
	ld hl, Text_5e_320 ; $7547
	ld de, wShadowTilemap + 6 * TILEMAP_WIDTH ; $754a
	ld bc, $0020 ; $754d
	farcall FetchAndDrawDialogueText ; $7550
	ld hl, Text_5e_322 ; $7553
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH ; $7556
	ld bc, $0020 ; $7559
	farcall FetchAndDrawDialogueText ; $755c
	wram_bank WRAM_COURT_PLANES ; $755f
	ld hl, wScreenAttrmap ; $7565
	ld de, $b800 ; $7568
	ld c, SCREEN_HEIGHT * TILEMAP_WIDTH / 16 ; $756b
	call QueueVRAMCopy ; $756d
	wram_bank WRAM_SCREEN ; $7570
	ld hl, wShadowTilemap ; $7576
	ld de, vBGMap0 ; $7579
	ld c, SCREEN_HEIGHT * TILEMAP_WIDTH / 16 ; $757c
	call QueueVRAMCopy ; $757e
	xor a ; $7581
	ldh [hScrollX], a ; $7582
	ldh [hScrollY], a ; $7584
	ld [wCameraX], a ; $7586
	ld [wCameraX + 1], a ; $7589
	ld [wCameraY], a ; $758c
	ld [wCameraY + 1], a ; $758f
	call AdvanceFrame ; $7592
	script_fade_in 4 ; $7595
	call WaitFadeEnd ; $759a
	wait_frames 120 ; $759d
	pop_wram_bank ; $75a1
	pop hl ; $75a6
	pop de ; $75a7
	pop bc ; $75a8
	pop af ; $75a9
	ret ; $75aa
