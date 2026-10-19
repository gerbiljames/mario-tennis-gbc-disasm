FlushWram3MapRows:
	push af ; $4cab
	push bc ; $4cac
	push de ; $4cad
	push hl ; $4cae
	push_wram_bank WRAM_SCREEN ; $4caf
	ld a, b ; $4cb8
	or a ; $4cb9
	jr nz, .mode1 ; $4cba
	ld c, 2 * TILEMAP_WIDTH / 16 ; $4cbc
	ld hl, wShadowTilemap ; $4cbe
	ld de, vBGMap0 ; $4cc1
	call QueueVRAMCopy ; $4cc4
	ld c, 2 * TILEMAP_WIDTH / 16 ; $4cc7
	ld hl, wShadowAttrmap ; $4cc9
	ld de, vBGMap0 + VRAM_BANK1 ; $4ccc
	call QueueVRAMCopy ; $4ccf
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4cd2
	ld hl, wShadowTilemap + 3 * TILEMAP_WIDTH ; $4cd4
	ld de, vBGMap0 + 3 * TILEMAP_WIDTH ; $4cd7
	call QueueVRAMCopy ; $4cda
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4cdd
	ld hl, wShadowAttrmap + 3 * TILEMAP_WIDTH ; $4cdf
	ld de, vBGMap0 + 3 * TILEMAP_WIDTH + VRAM_BANK1 ; $4ce2
	call QueueVRAMCopy ; $4ce5
	call AdvanceFrame ; $4ce8
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4ceb
	ld hl, wShadowTilemap + 7 * TILEMAP_WIDTH ; $4ced
	ld de, vBGMap0 + 7 * TILEMAP_WIDTH ; $4cf0
	call QueueVRAMCopy ; $4cf3
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4cf6
	ld hl, wShadowAttrmap + 7 * TILEMAP_WIDTH ; $4cf8
	ld de, vBGMap0 + 7 * TILEMAP_WIDTH + VRAM_BANK1 ; $4cfb
	call QueueVRAMCopy ; $4cfe
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4d01
	ld hl, wShadowTilemap + 11 * TILEMAP_WIDTH ; $4d03
	ld de, vBGMap0 + 11 * TILEMAP_WIDTH ; $4d06
	call QueueVRAMCopy ; $4d09
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4d0c
	ld hl, wShadowAttrmap + 11 * TILEMAP_WIDTH ; $4d0e
	ld de, vBGMap0 + 11 * TILEMAP_WIDTH + VRAM_BANK1 ; $4d11
	call QueueVRAMCopy ; $4d14
	jp .done ; $4d17
.mode1:
	cp $01 ; $4d1a
	jr nz, .mode2 ; $4d1c
	ld c, 2 * TILEMAP_WIDTH / 16 ; $4d1e
	ld hl, wShadowTilemap ; $4d20
	ld de, vBGMap0 ; $4d23
	call QueueVRAMCopy ; $4d26
	ld c, 2 * TILEMAP_WIDTH / 16 ; $4d29
	ld hl, wShadowAttrmap ; $4d2b
	ld de, vBGMap0 + VRAM_BANK1 ; $4d2e
	call QueueVRAMCopy ; $4d31
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4d34
	ld hl, wShadowTilemap + 4 * TILEMAP_WIDTH ; $4d36
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH ; $4d39
	call QueueVRAMCopy ; $4d3c
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4d3f
	ld hl, wShadowAttrmap + 4 * TILEMAP_WIDTH ; $4d41
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH + VRAM_BANK1 ; $4d44
	call QueueVRAMCopy ; $4d47
	call AdvanceFrame ; $4d4a
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4d4d
	ld hl, wShadowTilemap + 10 * TILEMAP_WIDTH ; $4d4f
	ld de, vBGMap0 + 10 * TILEMAP_WIDTH ; $4d52
	call QueueVRAMCopy ; $4d55
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4d58
	ld hl, wShadowAttrmap + 10 * TILEMAP_WIDTH ; $4d5a
	ld de, vBGMap0 + 10 * TILEMAP_WIDTH + VRAM_BANK1 ; $4d5d
	call QueueVRAMCopy ; $4d60
	jr .done ; $4d63
.mode2:
	cp $02 ; $4d65
	jr nz, .mode3 ; $4d67
	ld c, 2 * TILEMAP_WIDTH / 16 ; $4d69
	ld hl, wShadowTilemap ; $4d6b
	ld de, vBGMap0 ; $4d6e
	call QueueVRAMCopy ; $4d71
	ld c, 2 * TILEMAP_WIDTH / 16 ; $4d74
	ld hl, wShadowAttrmap ; $4d76
	ld de, vBGMap0 + VRAM_BANK1 ; $4d79
	call QueueVRAMCopy ; $4d7c
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4d7f
	ld hl, wShadowTilemap + 4 * TILEMAP_WIDTH ; $4d81
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH ; $4d84
	call QueueVRAMCopy ; $4d87
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4d8a
	ld hl, wShadowAttrmap + 4 * TILEMAP_WIDTH ; $4d8c
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH + VRAM_BANK1 ; $4d8f
	call QueueVRAMCopy ; $4d92
	call AdvanceFrame ; $4d95
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4d98
	ld hl, wShadowTilemap + 9 * TILEMAP_WIDTH ; $4d9a
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH ; $4d9d
	call QueueVRAMCopy ; $4da0
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4da3
	ld hl, wShadowAttrmap + 9 * TILEMAP_WIDTH ; $4da5
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH + VRAM_BANK1 ; $4da8
	call QueueVRAMCopy ; $4dab
	jr .done ; $4dae
.mode3:
	ld c, 2 * TILEMAP_WIDTH / 16 ; $4db0
	ld hl, wShadowTilemap ; $4db2
	ld de, vBGMap0 ; $4db5
	call QueueVRAMCopy ; $4db8
	ld c, 2 * TILEMAP_WIDTH / 16 ; $4dbb
	ld hl, wShadowAttrmap ; $4dbd
	ld de, vBGMap0 + VRAM_BANK1 ; $4dc0
	call QueueVRAMCopy ; $4dc3
	call AdvanceFrame ; $4dc6
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4dc9
	ld hl, wShadowTilemap + 7 * TILEMAP_WIDTH ; $4dcb
	ld de, vBGMap0 + 7 * TILEMAP_WIDTH ; $4dce
	call QueueVRAMCopy ; $4dd1
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4dd4
	ld hl, wShadowAttrmap + 7 * TILEMAP_WIDTH ; $4dd6
	ld de, vBGMap0 + 7 * TILEMAP_WIDTH + VRAM_BANK1 ; $4dd9
	call QueueVRAMCopy ; $4ddc
	jr .done ; $4ddf
.done:
	pop_wram_bank ; $4de1
	pop hl ; $4de6
	pop de ; $4de7
	pop bc ; $4de8
	pop af ; $4de9
	ret ; $4dea
RestoreMenuBgAndDrawPanel:
	push af ; $4deb
	push bc ; $4dec
	push de ; $4ded
	push hl ; $4dee
	push af ; $4def
	push bc ; $4df0
	push de ; $4df1
	push hl ; $4df2
	ld hl, wStadiumTilemapCopy ; $4df3
	ld de, wShadowTilemap ; $4df6
	rect_size $14, $10 ; $4df9
	call CopyTilemapRect ; $4dfd
	ld hl, wStadiumAttrmapCopy ; $4e00
	ld de, wShadowAttrmap ; $4e03
	rect_size $14, $10 ; $4e06
	call CopyTilemapRect ; $4e0a
	pop hl ; $4e0d
	pop de ; $4e0e
	pop bc ; $4e0f
	pop af ; $4e10
	ld a, b ; $4e11
	add a ; $4e12
	ld hl, TilemapAssemblyDispatch_39 ; $4e13
	add l ; $4e16
	ld l, a ; $4e17
	jr nc, .readTable ; $4e18
	inc h ; $4e1a
.readTable:
	ld a, [hl+] ; $4e1b
	ld h, [hl] ; $4e1c
	ld l, a ; $4e1d
	ld a, c ; $4e1e
	add a ; $4e1f
	add l ; $4e20
	ld l, a ; $4e21
	jr nc, .readEntry ; $4e22
	inc h ; $4e24
.readEntry:
	ld a, [hl+] ; $4e25
	ld h, [hl] ; $4e26
	ld l, a ; $4e27
.rectLoop:
	push hl ; $4e28
	ld a, [hl+] ; $4e29
	ld b, [hl] ; $4e2a
	ld c, a ; $4e2b
	push bc ; $4e2c
	inc hl ; $4e2d
	ld a, [hl+] ; $4e2e
	ld d, [hl] ; $4e2f
	ld e, a ; $4e30
	inc hl ; $4e31
	ld a, [hl+] ; $4e32
	or a ; $4e33
	jr z, .done ; $4e34
	ld c, [hl] ; $4e36
	ld b, a ; $4e37
	pop hl ; $4e38
	push bc ; $4e39
	push hl ; $4e3a
	push de ; $4e3b
	call CopyTilemapRect ; $4e3c
	pop de ; $4e3f
	ld hl, $0400 ; $4e40
	add hl, de ; $4e43
	ld d, h ; $4e44
	ld e, l ; $4e45
	pop hl ; $4e46
	ld bc, $0400 ; $4e47
	add hl, bc ; $4e4a
	pop bc ; $4e4b
	call CopyTilemapRect ; $4e4c
	pop hl ; $4e4f
	ld a, $06 ; $4e50
	add l ; $4e52
	ld l, a ; $4e53
	jr nc, .nextRect ; $4e54
	inc h ; $4e56
.nextRect:
	jr .rectLoop ; $4e57
.done:
	pop hl ; $4e59
	pop hl ; $4e5a
	pop hl ; $4e5b
	pop de ; $4e5c
	pop bc ; $4e5d
	pop af ; $4e5e
	ret ; $4e5f
TilemapAssemblyDispatch_39:
	; $4e60, 8034 bytes (tilemap_dispatch)
	dw .mainMenuSlideIn ; 0
	dw .mainMenuSlideOut ; 1
	dw .matchFormatSlideIn ; 2
	dw .matchFormatSlideOut ; 3
	dw .minigameGrid9SlideIn ; 4
	dw .minigameGrid9SlideOut ; 5
	dw .unusedPanelSlideIn ; 6
	dw .unusedPanelSlideOut ; 7
	dw .savedDataPickerSlideIn ; 8
	dw .savedDataPickerSlideOut ; 9
	dw .n64RecordTypeSlideIn ; 10
	dw .n64RecordTypeSlideOut ; 11
	dw .choiceTabSlideIn ; 12
	dw .choiceTabSlideIn ; 13
	dw .choiceTabSlideIn ; 14
	dw .choiceTabSlideIn ; 15
	dw .choiceTabSlideIn ; 16
	dw .choiceTabSlideOut ; 17
	dw .courtSelect4SlideIn ; 18
	dw .courtSelect4SlideOut ; 19
	dw .courtSelect9SlideIn ; 20
	dw .courtSelect9SlideOut ; 21
	dw .minigameGrid6SlideIn ; 22
	dw .minigameGrid6SlideOut ; 23
.mainMenuSlideIn:
	dw .noRects
	dw .noRects
	dw .noRects
	dw .mainMenuInFrame3
	dw .mainMenuInFrame4
	dw .mainMenuInFrame5
	dw .mainMenuInFrame6
	dw .mainMenuInFrame7
	dw .mainMenuInFrame8
	dw .mainMenuInFrame9
	dw .mainMenuInFrame10
	dw .mainMenuInFrame11
	dw .mainMenuInFrame12
	dw .mainMenuInFrame13
	dw .mainMenuInFrame14
	dw .mainMenuShown
.mainMenuSlideOut:
	dw .mainMenuShown
	dw .mainMenuOutFrame1
	dw .mainMenuOutFrame2
	dw .mainMenuOutFrame3
	dw .mainMenuOutFrame4
	dw .mainMenuOutFrame5
	dw .mainMenuOutFrame6
	dw .mainMenuOutFrame7
	dw .mainMenuOutFrame8
	dw .mainMenuOutFrame9
.matchFormatSlideIn:
	dw .noRects
	dw .noRects
	dw .noRects
	dw .matchFormatInFrame3
	dw .matchFormatInFrame4
	dw .matchFormatInFrame5
	dw .matchFormatInFrame6
	dw .matchFormatInFrame7
	dw .matchFormatInFrame8
	dw .matchFormatInFrame9
	dw .matchFormatInFrame10
	dw .matchFormatInFrame11
	dw .matchFormatInFrame12
	dw .matchFormatInFrame13
	dw .matchFormatShown
	dw .matchFormatShown
.matchFormatSlideOut:
	dw .matchFormatShown
	dw .matchFormatOutFrame1
	dw .matchFormatOutFrame2
	dw .matchFormatOutFrame3
	dw .matchFormatOutFrame4
	dw .matchFormatOutFrame5
	dw .matchFormatOutFrame6
	dw .matchFormatOutFrame7
	dw .matchFormatOutFrame8
	dw .matchFormatOutFrame9
	dw .noRects
	dw .noRects
.minigameGrid9SlideIn:
	dw .noRects
	dw .noRects
	dw .noRects
	dw .minigameGrid9InFrame3
	dw .minigameGrid9InFrame4
	dw .minigameGrid9InFrame5
	dw .minigameGrid9InFrame6
	dw .minigameGrid9InFrame7
	dw .minigameGrid9InFrame8
	dw .minigameGrid9InFrame9
	dw .minigameGrid9InFrame10
	dw .minigameGrid9InFrame11
	dw .minigameGrid9InFrame12
	dw .minigameGrid9Shown
	dw .minigameGrid9ShownNudged
	dw .minigameGrid9ShownNudged
.minigameGrid9SlideOut:
	dw .minigameGrid9Shown
	dw .minigameGrid9ShownNudged
	dw .minigameGrid9OutFrame2
	dw .minigameGrid9OutFrame3
	dw .minigameGrid9OutFrame4
	dw .minigameGrid9OutFrame5
	dw .minigameGrid9OutFrame6
	dw .minigameGrid9OutFrame7
	dw .minigameGrid9OutFrame8
	dw .minigameGrid9OutFrame9
	dw .minigameGrid9OutFrame10
	dw .noRects
	dw .noRects
	dw .noRects
.unusedPanelSlideIn:
	dw .noRects
	dw .noRects
	dw .noRects
	dw .unusedPanelInFrame3
	dw .unusedPanelInFrame4
	dw .unusedPanelInFrame5
	dw .unusedPanelInFrame6
	dw .unusedPanelInFrame7
	dw .unusedPanelInFrame8
	dw .unusedPanelInFrame9
	dw .unusedPanelInFrame10
	dw .unusedPanelInFrame11
	dw .unusedPanelShown
	dw .unusedPanelShown
.unusedPanelSlideOut:
	dw .unusedPanelShown
	dw .unusedPanelOutFrame1
	dw .unusedPanelOutFrame2
	dw .unusedPanelOutFrame3
	dw .unusedPanelOutFrame4
	dw .unusedPanelOutFrame5
	dw .unusedPanelOutFrame6
	dw .unusedPanelOutFrame7
	dw .unusedPanelOutFrame8
	dw .noRects
	dw .noRects
.savedDataPickerSlideIn:
	dw .noRects
	dw .noRects
	dw .noRects
	dw .savedDataPickerInFrame3
	dw .savedDataPickerInFrame4
	dw .savedDataPickerInFrame5
	dw .savedDataPickerInFrame6
	dw .savedDataPickerInFrame7
	dw .savedDataPickerInFrame8
	dw .savedDataPickerInFrame9
	dw .savedDataPickerInFrame10
	dw .savedDataPickerInFrame11
	dw .savedDataPickerInFrame12
	dw .savedDataPickerInFrame13
	dw .savedDataPickerShown
	dw .savedDataPickerShownNudged
.savedDataPickerSlideOut:
	dw .savedDataPickerShown
	dw .savedDataPickerShownNudged
	dw .savedDataPickerOutFrame2
	dw .savedDataPickerOutFrame3
	dw .savedDataPickerOutFrame4
	dw .savedDataPickerOutFrame5
	dw .savedDataPickerOutFrame6
	dw .savedDataPickerOutFrame7
	dw .savedDataPickerOutFrame8
	dw .savedDataPickerOutFrame9
	dw .noRects
	dw .noRects
	dw .noRects
.n64RecordTypeSlideIn:
	dw .noRects
	dw .noRects
	dw .noRects
	dw .n64RecordTypeInFrame3
	dw .n64RecordTypeInFrame4
	dw .n64RecordTypeInFrame5
	dw .n64RecordTypeInFrame6
	dw .n64RecordTypeInFrame7
	dw .n64RecordTypeInFrame8
	dw .n64RecordTypeInFrame9
	dw .n64RecordTypeInFrame10
	dw .n64RecordTypeInFrame11
	dw .n64RecordTypeInFrame12
.n64RecordTypeSlideOut:
	dw .n64RecordTypeOutFrame0
	dw .n64RecordTypeOutFrame1
	dw .n64RecordTypeOutFrame2
	dw .n64RecordTypeOutFrame3
	dw .n64RecordTypeOutFrame4
	dw .n64RecordTypeOutFrame5
	dw .n64RecordTypeOutFrame6
	dw .n64RecordTypeOutFrame7
	dw .n64RecordTypeOutFrame8
	dw .n64RecordTypeOutFrame9
	dw .n64RecordTypeOutFrame10
.choiceTabSlideIn:
	dw .noRects
	dw .noRects
	dw .noRects
	dw .choiceTabInFrame3
	dw .choiceTabInFrame4
	dw .choiceTabInFrame5
	dw .choiceTabInFrame6
	dw .choiceTabInFrame7
	dw .choiceTabInFrame8
	dw .choiceTabInFrame9
	dw .choiceTabInFrame10
	dw .choiceTabInFrame11
	dw .choiceTabShown
	dw .choiceTabShown
	dw .choiceTabShown
	dw .choiceTabShown
	dw .choiceTabShown
.choiceTabSlideOut:
	dw .choiceTabShown
	dw .choiceTabOutFrame1
	dw .choiceTabOutFrame2
	dw .choiceTabOutFrame3
	dw .choiceTabOutFrame4
	dw .choiceTabOutFrame5
	dw .choiceTabOutFrame6
	dw .choiceTabOutFrame7
	dw .choiceTabOutFrame8
	dw .choiceTabOutFrame9
	dw .courtSelect4InFrame3
	dw .courtSelect4InFrame3
	dw .courtSelect4InFrame3
	dw .courtSelect4InFrame3
.courtSelect4SlideIn:
	dw .noRects
	dw .noRects
	dw .noRects
	dw .courtSelect4InFrame3
	dw .courtSelect4InFrame4
	dw .courtSelect4InFrame5
	dw .courtSelect4InFrame6
	dw .courtSelect4InFrame7
	dw .courtSelect4InFrame8
	dw .courtSelect4InFrame9
	dw .courtSelect4InFrame10
	dw .courtSelect4InFrame11
	dw .courtSelect4InFrame12
	dw .courtSelect4InFrame13
	dw .courtSelect4InFrame14
	dw .courtSelect4InFrame15
	dw .courtSelect4InFrame16
.courtSelect4SlideOut:
	dw .courtSelect4OutFrame0
	dw .courtSelect4OutFrame1
	dw .courtSelect4OutFrame2
	dw .courtSelect4OutFrame3
	dw .courtSelect4OutFrame4
	dw .courtSelect4OutFrame5
	dw .courtSelect4OutFrame6
	dw .courtSelect4OutFrame7
	dw .courtSelect4OutFrame8
	dw .courtSelect4OutFrame9
	dw .courtSelect4OutFrame10
	dw .courtSelect4OutFrame11
	dw .courtSelect4OutFrame12
	dw .courtSelect4OutFrame13
.courtSelect9SlideIn:
	dw .noRects
	dw .noRects
	dw .noRects
	dw .courtSelect9InFrame3
	dw .courtSelect9InFrame4
	dw .courtSelect9InFrame5
	dw .courtSelect9InFrame6
	dw .courtSelect9InFrame7
	dw .courtSelect9InFrame8
	dw .courtSelect9InFrame9
	dw .courtSelect9InFrame10
	dw .courtSelect9InFrame11
	dw .courtSelect9InFrame12
	dw .courtSelect9InFrame13
	dw .courtSelect9InFrame14
	dw .courtSelect9Shown
	dw .courtSelect9Shown
.courtSelect9SlideOut:
	dw .courtSelect9Shown
	dw .courtSelect9OutFrame1
	dw .courtSelect9OutFrame2
	dw .courtSelect9OutFrame3
	dw .courtSelect9OutFrame4
	dw .courtSelect9OutFrame5
	dw .courtSelect9OutFrame6
	dw .courtSelect9OutFrame7
	dw .courtSelect9OutFrame8
	dw .courtSelect9OutFrame9
	dw .courtSelect9OutFrame10
	dw .minigameGrid6InFrame3
	dw .minigameGrid6InFrame3
	dw .minigameGrid6InFrame3
.minigameGrid6SlideIn:
	dw .noRects
	dw .noRects
	dw .noRects
	dw .minigameGrid6InFrame3
	dw .minigameGrid6InFrame4
	dw .minigameGrid6InFrame5
	dw .minigameGrid6InFrame6
	dw .minigameGrid6InFrame7
	dw .minigameGrid6InFrame8
	dw .minigameGrid6InFrame9
	dw .minigameGrid6InFrame10
	dw .minigameGrid6InFrame11
	dw .minigameGrid6InFrame12
	dw .minigameGrid6Shown
	dw .minigameGrid6ShownNudged
	dw .minigameGrid6ShownNudged
	dw .minigameGrid6ShownNudged
.minigameGrid6SlideOut:
	dw .minigameGrid6Shown
	dw .minigameGrid6ShownNudged
	dw .minigameGrid6OutFrame2
	dw .minigameGrid6OutFrame3
	dw .minigameGrid6OutFrame4
	dw .minigameGrid6OutFrame5
	dw .minigameGrid6OutFrame6
	dw .minigameGrid6OutFrame7
	dw .minigameGrid6OutFrame8
	dw .noRects
	dw .noRects
	dw .noRects
	dw .noRects
	dw .noRects
	dw .noRects
	dw .noRects
	dw .pastEnd
	dw .pastEnd
	dw .pastEnd
	dw .pastEnd
	dw .pastEnd
	dw .pastEnd
.noRects:
	tilemap_rect_end
.mainMenuInFrame3:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 16, 3, 5, 3
	tilemap_rect_end
.mainMenuInFrame4:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 13, 3, 5, 3
	panel_rect 0, 18, 20, 7, 3, 3
	tilemap_rect_end
.mainMenuInFrame5:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 10, 3, 5, 3
	panel_rect 5, 21, 16, 3, 5, 3
	panel_rect 0, 21, 16, 3, 3, 3
	tilemap_rect_end
.mainMenuInFrame6:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 7, 3, 5, 3
	panel_rect 5, 21, 13, 3, 5, 3
	panel_rect 0, 18, 14, 7, 3, 3
	panel_rect 3, 18, 20, 7, 3, 3
	panel_rect 15, 21, 19, 11, 5, 3
	tilemap_rect_end
.mainMenuInFrame7:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 4, 3, 5, 3
	panel_rect 5, 21, 10, 3, 5, 3
	panel_rect 10, 21, 16, 3, 5, 3
	panel_rect 0, 18, 11, 7, 3, 3
	panel_rect 3, 18, 17, 7, 3, 3
	panel_rect 15, 21, 16, 11, 5, 3
	tilemap_rect_end
.mainMenuInFrame8:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 2, 3, 5, 3
	panel_rect 5, 21, 8, 3, 5, 3
	panel_rect 10, 21, 14, 3, 5, 3
	panel_rect 0, 18, 8, 7, 3, 3
	panel_rect 3, 18, 14, 7, 3, 3
	panel_rect 6, 18, 20, 7, 3, 3
	panel_rect 15, 21, 13, 11, 5, 3
	panel_rect 20, 21, 19, 11, 5, 3
	tilemap_rect_end
.mainMenuInFrame9:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 0, 18, 5, 7, 3, 3
	panel_rect 3, 18, 11, 7, 3, 3
	panel_rect 6, 18, 17, 7, 3, 3
	panel_rect 15, 21, 10, 11, 5, 3
	panel_rect 20, 21, 16, 11, 5, 3
	panel_rect 25, 21, 22, 11, 5, 3
	tilemap_rect_end
.mainMenuInFrame10:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 0, 18, 3, 7, 3, 3
	panel_rect 3, 18, 9, 7, 3, 3
	panel_rect 6, 18, 15, 7, 3, 3
	panel_rect 15, 21, 7, 11, 5, 3
	panel_rect 20, 21, 13, 11, 5, 3
	panel_rect 25, 21, 19, 11, 5, 3
	tilemap_rect_end
.mainMenuInFrame11:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 0, 18, 2, 7, 3, 3
	panel_rect 3, 18, 8, 7, 3, 3
	panel_rect 6, 18, 14, 7, 3, 3
	panel_rect 15, 21, 4, 11, 5, 3
	panel_rect 20, 21, 10, 11, 5, 3
	panel_rect 25, 21, 16, 11, 5, 3
	tilemap_rect_end
.mainMenuInFrame12:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 0, 18, 2, 7, 3, 3
	panel_rect 3, 18, 8, 7, 3, 3
	panel_rect 6, 18, 14, 7, 3, 3
	panel_rect 15, 21, 2, 11, 5, 3
	panel_rect 20, 21, 8, 11, 5, 3
	panel_rect 25, 21, 14, 11, 5, 3
	tilemap_rect_end
.mainMenuInFrame13:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 0, 18, 2, 7, 3, 3
	panel_rect 3, 18, 8, 7, 3, 3
	panel_rect 6, 18, 14, 7, 3, 3
	panel_rect 15, 21, 1, 11, 5, 3
	panel_rect 20, 21, 7, 11, 5, 3
	panel_rect 25, 21, 13, 11, 5, 3
	tilemap_rect_end
.mainMenuInFrame14:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 0, 18, 2, 7, 3, 3
	panel_rect 3, 18, 8, 7, 3, 3
	panel_rect 6, 18, 14, 7, 3, 3
	panel_rect 15, 21, 1, 11, 5, 3
	panel_rect 20, 21, 7, 11, 5, 3
	panel_rect 25, 21, 13, 11, 5, 3
	tilemap_rect_end
.mainMenuShown:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 0, 18, 2, 7, 3, 3
	panel_rect 3, 18, 8, 7, 3, 3
	panel_rect 6, 18, 14, 7, 3, 3
	panel_rect 15, 21, 1, 11, 5, 3
	panel_rect 20, 21, 7, 11, 5, 3
	panel_rect 25, 21, 13, 11, 5, 3
	tilemap_rect_end
.mainMenuOutFrame1:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 0, 3, 5, 3
	panel_rect 5, 21, 6, 3, 5, 3
	panel_rect 10, 21, 12, 3, 5, 3
	panel_rect 0, 18, 2, 7, 3, 3
	panel_rect 3, 18, 8, 7, 3, 3
	panel_rect 6, 18, 14, 7, 3, 3
	panel_rect 15, 21, 1, 11, 5, 3
	panel_rect 20, 21, 7, 11, 5, 3
	panel_rect 25, 21, 13, 11, 5, 3
	tilemap_rect_end
.mainMenuOutFrame2:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 30, 2, 5, 3
	panel_rect 5, 21, 4, 3, 5, 3
	panel_rect 10, 21, 10, 3, 5, 3
	panel_rect 0, 18, 1, 7, 3, 3
	panel_rect 3, 18, 7, 7, 3, 3
	panel_rect 6, 18, 13, 7, 3, 3
	panel_rect 15, 21, 1, 11, 5, 3
	panel_rect 20, 21, 7, 11, 5, 3
	panel_rect 25, 21, 13, 11, 5, 3
	tilemap_rect_end
.mainMenuOutFrame3:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 27, 2, 5, 3
	panel_rect 5, 21, 1, 3, 5, 3
	panel_rect 10, 21, 7, 3, 5, 3
	panel_rect 0, 18, 31, 6, 3, 3
	panel_rect 3, 18, 5, 7, 3, 3
	panel_rect 6, 18, 11, 7, 3, 3
	panel_rect 15, 21, 1, 11, 5, 3
	panel_rect 20, 21, 7, 11, 5, 3
	panel_rect 25, 21, 13, 11, 5, 3
	tilemap_rect_end
.mainMenuOutFrame4:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 5, 21, 30, 2, 5, 3
	panel_rect 10, 21, 4, 3, 5, 3
	panel_rect 0, 18, 28, 6, 3, 3
	panel_rect 3, 18, 2, 7, 3, 3
	panel_rect 6, 18, 8, 7, 3, 3
	panel_rect 15, 21, 0, 11, 5, 3
	panel_rect 20, 21, 6, 11, 5, 3
	panel_rect 25, 21, 12, 11, 5, 3
	tilemap_rect_end
.mainMenuOutFrame5:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 5, 21, 27, 2, 5, 3
	panel_rect 10, 21, 1, 3, 5, 3
	panel_rect 0, 18, 25, 6, 3, 3
	panel_rect 3, 18, 31, 6, 3, 3
	panel_rect 6, 18, 5, 7, 3, 3
	panel_rect 15, 21, 30, 10, 5, 3
	panel_rect 20, 21, 4, 11, 5, 3
	panel_rect 25, 21, 10, 11, 5, 3
	tilemap_rect_end
.mainMenuOutFrame6:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 10, 21, 30, 2, 5, 3
	panel_rect 3, 18, 28, 6, 3, 3
	panel_rect 6, 18, 2, 7, 3, 3
	panel_rect 15, 21, 27, 10, 5, 3
	panel_rect 20, 21, 1, 11, 5, 3
	panel_rect 25, 21, 7, 11, 5, 3
	tilemap_rect_end
.mainMenuOutFrame7:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 10, 21, 27, 2, 5, 3
	panel_rect 6, 18, 31, 6, 3, 3
	panel_rect 20, 21, 30, 10, 5, 3
	panel_rect 25, 21, 4, 11, 5, 3
	tilemap_rect_end
.mainMenuOutFrame8:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 6, 18, 28, 6, 3, 3
	panel_rect 20, 21, 27, 10, 5, 3
	panel_rect 25, 21, 1, 11, 5, 3
	tilemap_rect_end
.mainMenuOutFrame9:
	panel_rect 25, 21, 30, 10, 5, 3
	tilemap_rect_end
.matchFormatInFrame3:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 18, 3, 5, 3
	tilemap_rect_end
.matchFormatInFrame4:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 15, 3, 5, 3
	panel_rect 5, 21, 24, 3, 5, 3
	panel_rect 10, 21, 21, 7, 5, 3
	tilemap_rect_end
.matchFormatInFrame5:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 12, 3, 5, 3
	panel_rect 5, 21, 21, 3, 5, 3
	panel_rect 10, 21, 18, 7, 5, 3
	tilemap_rect_end
.matchFormatInFrame6:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 9, 3, 5, 3
	panel_rect 5, 21, 18, 3, 5, 3
	panel_rect 10, 21, 15, 7, 5, 3
	panel_rect 15, 21, 24, 7, 5, 3
	panel_rect 20, 21, 19, 11, 5, 3
	tilemap_rect_end
.matchFormatInFrame7:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 6, 3, 5, 3
	panel_rect 5, 21, 15, 3, 5, 3
	panel_rect 10, 21, 12, 7, 5, 3
	panel_rect 15, 21, 21, 7, 5, 3
	panel_rect 20, 21, 16, 11, 5, 3
	tilemap_rect_end
.matchFormatInFrame8:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 4, 3, 5, 3
	panel_rect 5, 21, 13, 3, 5, 3
	panel_rect 10, 21, 9, 7, 5, 3
	panel_rect 15, 21, 18, 7, 5, 3
	panel_rect 20, 21, 13, 11, 5, 3
	panel_rect 25, 21, 19, 11, 5, 3
	tilemap_rect_end
.matchFormatInFrame9:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 3, 3, 5, 3
	panel_rect 5, 21, 12, 3, 5, 3
	panel_rect 10, 21, 6, 7, 5, 3
	panel_rect 15, 21, 15, 7, 5, 3
	panel_rect 20, 21, 10, 11, 5, 3
	panel_rect 25, 21, 16, 11, 5, 3
	panel_rect 20, 26, 22, 11, 5, 3
	tilemap_rect_end
.matchFormatInFrame10:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 3, 3, 5, 3
	panel_rect 5, 21, 12, 3, 5, 3
	panel_rect 10, 21, 4, 7, 5, 3
	panel_rect 15, 21, 13, 7, 5, 3
	panel_rect 20, 21, 7, 11, 5, 3
	panel_rect 25, 21, 13, 11, 5, 3
	panel_rect 20, 26, 19, 11, 5, 3
	tilemap_rect_end
.matchFormatInFrame11:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 3, 3, 5, 3
	panel_rect 5, 21, 12, 3, 5, 3
	panel_rect 10, 21, 3, 7, 5, 3
	panel_rect 15, 21, 12, 7, 5, 3
	panel_rect 20, 21, 4, 11, 5, 3
	panel_rect 25, 21, 10, 11, 5, 3
	panel_rect 20, 26, 16, 11, 5, 3
	tilemap_rect_end
.matchFormatInFrame12:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 3, 3, 5, 3
	panel_rect 5, 21, 12, 3, 5, 3
	panel_rect 10, 21, 3, 7, 5, 3
	panel_rect 15, 21, 12, 7, 5, 3
	panel_rect 20, 21, 2, 11, 5, 3
	panel_rect 25, 21, 8, 11, 5, 3
	panel_rect 20, 26, 14, 11, 5, 3
	tilemap_rect_end
.matchFormatInFrame13:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 3, 3, 5, 3
	panel_rect 5, 21, 12, 3, 5, 3
	panel_rect 10, 21, 3, 7, 5, 3
	panel_rect 15, 21, 12, 7, 5, 3
	panel_rect 20, 21, 1, 11, 5, 3
	panel_rect 25, 21, 7, 11, 5, 3
	panel_rect 20, 26, 13, 11, 5, 3
	tilemap_rect_end
.matchFormatShown:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 3, 3, 5, 3
	panel_rect 5, 21, 12, 3, 5, 3
	panel_rect 10, 21, 3, 7, 5, 3
	panel_rect 15, 21, 12, 7, 5, 3
	panel_rect 20, 21, 1, 11, 5, 3
	panel_rect 25, 21, 7, 11, 5, 3
	panel_rect 20, 26, 13, 11, 5, 3
	tilemap_rect_end
.matchFormatOutFrame1:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 2, 3, 5, 3
	panel_rect 5, 21, 11, 3, 5, 3
	panel_rect 10, 21, 3, 7, 5, 3
	panel_rect 15, 21, 12, 7, 5, 3
	panel_rect 20, 21, 1, 11, 5, 3
	panel_rect 25, 21, 7, 11, 5, 3
	panel_rect 20, 26, 13, 11, 5, 3
	tilemap_rect_end
.matchFormatOutFrame2:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 0, 3, 5, 3
	panel_rect 5, 21, 9, 3, 5, 3
	panel_rect 10, 21, 2, 7, 5, 3
	panel_rect 15, 21, 11, 7, 5, 3
	panel_rect 20, 21, 1, 11, 5, 3
	panel_rect 25, 21, 7, 11, 5, 3
	panel_rect 20, 26, 13, 11, 5, 3
	tilemap_rect_end
.matchFormatOutFrame3:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 29, 2, 5, 3
	panel_rect 5, 21, 6, 3, 5, 3
	panel_rect 10, 21, 0, 7, 5, 3
	panel_rect 15, 21, 9, 7, 5, 3
	panel_rect 20, 21, 0, 11, 5, 3
	panel_rect 25, 21, 6, 11, 5, 3
	panel_rect 20, 26, 12, 11, 5, 3
	tilemap_rect_end
.matchFormatOutFrame4:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 29, 2, 5, 3
	panel_rect 5, 21, 6, 3, 5, 3
	panel_rect 10, 21, 0, 7, 5, 3
	panel_rect 15, 21, 9, 7, 5, 3
	panel_rect 20, 21, 0, 11, 5, 3
	panel_rect 25, 21, 6, 11, 5, 3
	panel_rect 20, 26, 12, 11, 5, 3
	tilemap_rect_end
.matchFormatOutFrame5:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 26, 2, 5, 3
	panel_rect 5, 21, 3, 3, 5, 3
	panel_rect 10, 21, 29, 6, 5, 3
	panel_rect 15, 21, 6, 7, 5, 3
	panel_rect 20, 21, 30, 10, 5, 3
	panel_rect 25, 21, 4, 11, 5, 3
	panel_rect 20, 26, 10, 11, 5, 3
	tilemap_rect_end
.matchFormatOutFrame6:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 5, 21, 0, 3, 5, 3
	panel_rect 10, 21, 26, 6, 5, 3
	panel_rect 15, 21, 3, 7, 5, 3
	panel_rect 20, 21, 27, 10, 5, 3
	panel_rect 25, 21, 1, 11, 5, 3
	panel_rect 20, 26, 7, 11, 5, 3
	tilemap_rect_end
.matchFormatOutFrame7:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 5, 21, 29, 2, 5, 3
	panel_rect 15, 21, 0, 7, 5, 3
	panel_rect 25, 21, 30, 10, 5, 3
	panel_rect 20, 26, 4, 11, 5, 3
	tilemap_rect_end
.matchFormatOutFrame8:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 15, 21, 29, 6, 5, 3
	panel_rect 25, 21, 27, 10, 5, 3
	panel_rect 20, 26, 1, 11, 5, 3
	tilemap_rect_end
.matchFormatOutFrame9:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 20, 26, 30, 10, 5, 3
	tilemap_rect_end
.minigameGrid9InFrame3:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 17, 3, 3, 3
	tilemap_rect_end
.minigameGrid9InFrame4:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 14, 3, 3, 3
	panel_rect 3, 18, 20, 3, 3, 3
	tilemap_rect_end
.minigameGrid9InFrame5:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 11, 3, 3, 3
	panel_rect 3, 18, 17, 3, 3, 3
	panel_rect 6, 18, 23, 3, 3, 3
	panel_rect 9, 18, 17, 7, 3, 3
	tilemap_rect_end
.minigameGrid9InFrame6:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 8, 3, 3, 3
	panel_rect 3, 18, 14, 3, 3, 3
	panel_rect 6, 18, 20, 3, 3, 3
	panel_rect 9, 18, 14, 7, 3, 3
	panel_rect 12, 18, 20, 7, 3, 3
	panel_rect 18, 18, 20, 11, 3, 3
	tilemap_rect_end
.minigameGrid9InFrame7:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 5, 3, 3, 3
	panel_rect 3, 18, 11, 3, 3, 3
	panel_rect 6, 18, 17, 3, 3, 3
	panel_rect 9, 18, 11, 7, 3, 3
	panel_rect 12, 18, 17, 7, 3, 3
	panel_rect 18, 18, 17, 11, 3, 3
	panel_rect 21, 18, 23, 11, 3, 3
	tilemap_rect_end
.minigameGrid9InFrame8:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 3, 3, 3, 3
	panel_rect 3, 18, 9, 3, 3, 3
	panel_rect 6, 18, 15, 3, 3, 3
	panel_rect 9, 18, 8, 7, 3, 3
	panel_rect 12, 18, 14, 7, 3, 3
	panel_rect 15, 18, 20, 7, 3, 3
	panel_rect 18, 18, 14, 11, 3, 3
	panel_rect 21, 18, 20, 11, 3, 3
	panel_rect 24, 18, 26, 11, 3, 3
	tilemap_rect_end
.minigameGrid9InFrame9:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 3, 3, 3
	panel_rect 3, 18, 8, 3, 3, 3
	panel_rect 6, 18, 14, 3, 3, 3
	panel_rect 9, 18, 5, 7, 3, 3
	panel_rect 12, 18, 11, 7, 3, 3
	panel_rect 15, 18, 17, 7, 3, 3
	panel_rect 18, 18, 11, 11, 3, 3
	panel_rect 21, 18, 17, 11, 3, 3
	panel_rect 24, 18, 23, 11, 3, 3
	tilemap_rect_end
.minigameGrid9InFrame10:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 3, 3, 3
	panel_rect 3, 18, 8, 3, 3, 3
	panel_rect 6, 18, 14, 3, 3, 3
	panel_rect 9, 18, 3, 7, 3, 3
	panel_rect 12, 18, 9, 7, 3, 3
	panel_rect 15, 18, 15, 7, 3, 3
	panel_rect 18, 18, 8, 11, 3, 3
	panel_rect 21, 18, 14, 11, 3, 3
	panel_rect 24, 18, 20, 11, 3, 3
	tilemap_rect_end
.minigameGrid9InFrame11:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 3, 3, 3
	panel_rect 3, 18, 8, 3, 3, 3
	panel_rect 6, 18, 14, 3, 3, 3
	panel_rect 9, 18, 2, 7, 3, 3
	panel_rect 12, 18, 8, 7, 3, 3
	panel_rect 15, 18, 14, 7, 3, 3
	panel_rect 18, 18, 5, 11, 3, 3
	panel_rect 21, 18, 11, 11, 3, 3
	panel_rect 24, 18, 17, 11, 3, 3
	tilemap_rect_end
.minigameGrid9InFrame12:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 3, 3, 3
	panel_rect 3, 18, 8, 3, 3, 3
	panel_rect 6, 18, 14, 3, 3, 3
	panel_rect 9, 18, 2, 7, 3, 3
	panel_rect 12, 18, 8, 7, 3, 3
	panel_rect 15, 18, 14, 7, 3, 3
	panel_rect 18, 18, 3, 11, 3, 3
	panel_rect 21, 18, 9, 11, 3, 3
	panel_rect 24, 18, 15, 11, 3, 3
	tilemap_rect_end
.minigameGrid9Shown:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 3, 3, 3
	panel_rect 3, 18, 8, 3, 3, 3
	panel_rect 6, 18, 14, 3, 3, 3
	panel_rect 9, 18, 2, 7, 3, 3
	panel_rect 12, 18, 8, 7, 3, 3
	panel_rect 15, 18, 14, 7, 3, 3
	panel_rect 18, 18, 2, 11, 3, 3
	panel_rect 21, 18, 8, 11, 3, 3
	panel_rect 24, 18, 14, 11, 3, 3
	tilemap_rect_end
.minigameGrid9ShownNudged:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 1, 3, 3, 3
	panel_rect 3, 18, 7, 3, 3, 3
	panel_rect 6, 18, 13, 3, 3, 3
	panel_rect 9, 18, 2, 7, 3, 3
	panel_rect 12, 18, 8, 7, 3, 3
	panel_rect 15, 18, 14, 7, 3, 3
	panel_rect 18, 18, 2, 11, 3, 3
	panel_rect 21, 18, 8, 11, 3, 3
	panel_rect 24, 18, 14, 11, 3, 3
	tilemap_rect_end
.minigameGrid9OutFrame2:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 31, 2, 3, 3
	panel_rect 3, 18, 5, 3, 3, 3
	panel_rect 6, 18, 11, 3, 3, 3
	panel_rect 9, 18, 2, 7, 3, 3
	panel_rect 12, 18, 8, 7, 3, 3
	panel_rect 15, 18, 14, 7, 3, 3
	panel_rect 18, 18, 2, 11, 3, 3
	panel_rect 21, 18, 8, 11, 3, 3
	panel_rect 24, 18, 14, 11, 3, 3
	tilemap_rect_end
.minigameGrid9OutFrame3:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 28, 2, 3, 3
	panel_rect 3, 18, 2, 3, 3, 3
	panel_rect 6, 18, 8, 3, 3, 3
	panel_rect 9, 18, 1, 7, 3, 3
	panel_rect 12, 18, 7, 7, 3, 3
	panel_rect 15, 18, 13, 7, 3, 3
	panel_rect 18, 18, 2, 11, 3, 3
	panel_rect 21, 18, 8, 11, 3, 3
	panel_rect 24, 18, 14, 11, 3, 3
	tilemap_rect_end
.minigameGrid9OutFrame4:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 3, 18, 31, 2, 3, 3
	panel_rect 6, 18, 5, 3, 3, 3
	panel_rect 9, 18, 31, 6, 3, 3
	panel_rect 12, 18, 5, 7, 3, 3
	panel_rect 15, 18, 11, 7, 3, 3
	panel_rect 18, 18, 1, 11, 3, 3
	panel_rect 21, 18, 7, 11, 3, 3
	panel_rect 24, 18, 13, 11, 3, 3
	tilemap_rect_end
.minigameGrid9OutFrame5:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 3, 18, 28, 2, 3, 3
	panel_rect 6, 18, 2, 3, 3, 3
	panel_rect 9, 18, 28, 6, 3, 3
	panel_rect 12, 18, 2, 7, 3, 3
	panel_rect 15, 18, 8, 7, 3, 3
	panel_rect 18, 18, 31, 10, 3, 3
	panel_rect 21, 18, 5, 11, 3, 3
	panel_rect 24, 18, 11, 11, 3, 3
	tilemap_rect_end
.minigameGrid9OutFrame6:
	panel_rect 6, 18, 31, 2, 3, 3
	panel_rect 12, 18, 31, 6, 3, 3
	panel_rect 15, 18, 5, 7, 3, 3
	panel_rect 18, 18, 28, 10, 3, 3
	panel_rect 21, 18, 2, 11, 3, 3
	panel_rect 24, 18, 8, 11, 3, 3
	tilemap_rect_end
.minigameGrid9OutFrame7:
	panel_rect 12, 18, 28, 6, 3, 3
	panel_rect 15, 18, 2, 7, 3, 3
	panel_rect 21, 18, 31, 10, 3, 3
	panel_rect 24, 18, 5, 11, 3, 3
	tilemap_rect_end
.minigameGrid9OutFrame8:
	panel_rect 15, 18, 31, 6, 3, 3
	panel_rect 21, 18, 28, 10, 3, 3
	panel_rect 24, 18, 2, 11, 3, 3
	tilemap_rect_end
.minigameGrid9OutFrame9:
	panel_rect 24, 18, 31, 10, 3, 3
	tilemap_rect_end
.minigameGrid9OutFrame10:
	tilemap_rect_end
.unusedPanelInFrame3:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 17, 4, 3, 3
	tilemap_rect_end
.unusedPanelInFrame4:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 14, 4, 3, 3
	panel_rect 3, 18, 20, 4, 3, 3
	tilemap_rect_end
.unusedPanelInFrame5:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 11, 4, 3, 3
	panel_rect 3, 18, 17, 4, 3, 3
	tilemap_rect_end
.unusedPanelInFrame6:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 8, 4, 3, 3
	panel_rect 3, 18, 14, 4, 3, 3
	panel_rect 0, 21, 19, 9, 3, 3
	tilemap_rect_end
.unusedPanelInFrame7:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 5, 4, 3, 3
	panel_rect 3, 18, 11, 4, 3, 3
	panel_rect 6, 18, 17, 4, 3, 3
	panel_rect 0, 21, 16, 9, 3, 3
	tilemap_rect_end
.unusedPanelInFrame8:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 3, 4, 3, 3
	panel_rect 3, 18, 9, 4, 3, 3
	panel_rect 6, 18, 15, 4, 3, 3
	panel_rect 0, 21, 13, 9, 3, 3
	tilemap_rect_end
.unusedPanelInFrame9:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 0, 21, 10, 9, 5, 3
	tilemap_rect_end
.unusedPanelInFrame10:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 0, 21, 8, 9, 5, 3
	tilemap_rect_end
.unusedPanelInFrame11:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 0, 21, 7, 9, 5, 3
	tilemap_rect_end
.unusedPanelShown:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 0, 21, 7, 9, 5, 3
	tilemap_rect_end
.unusedPanelOutFrame1:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 1, 4, 3, 3
	panel_rect 3, 18, 7, 4, 3, 3
	panel_rect 6, 18, 13, 4, 3, 3
	panel_rect 0, 21, 7, 9, 5, 3
	tilemap_rect_end
.unusedPanelOutFrame2:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 31, 3, 3, 3
	panel_rect 3, 18, 5, 4, 3, 3
	panel_rect 6, 18, 11, 4, 3, 3
	panel_rect 0, 21, 7, 9, 5, 3
	tilemap_rect_end
.unusedPanelOutFrame3:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 28, 3, 3, 3
	panel_rect 3, 18, 2, 4, 3, 3
	panel_rect 6, 18, 8, 4, 3, 3
	panel_rect 0, 21, 6, 9, 5, 3
	tilemap_rect_end
.unusedPanelOutFrame4:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 3, 18, 31, 3, 3, 3
	panel_rect 6, 18, 5, 4, 3, 3
	panel_rect 0, 21, 4, 9, 5, 3
	tilemap_rect_end
.unusedPanelOutFrame5:
	panel_rect 3, 18, 28, 3, 3, 3
	panel_rect 6, 18, 2, 4, 3, 3
	panel_rect 0, 21, 1, 9, 5, 3
	tilemap_rect_end
.unusedPanelOutFrame6:
	panel_rect 6, 18, 31, 3, 3, 3
	panel_rect 0, 21, 30, 8, 5, 3
	tilemap_rect_end
.unusedPanelOutFrame7:
	panel_rect 6, 18, 28, 3, 3, 3
	panel_rect 0, 21, 27, 8, 5, 3
	tilemap_rect_end
.unusedPanelOutFrame8:
	panel_rect 0, 21, 24, 8, 5, 3
	tilemap_rect_end
.savedDataPickerInFrame3:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 20, 4, 3, 3
	tilemap_rect_end
.savedDataPickerInFrame4:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 17, 4, 3, 3
	tilemap_rect_end
.savedDataPickerInFrame5:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 14, 4, 3, 3
	panel_rect 3, 18, 20, 4, 3, 3
	tilemap_rect_end
.savedDataPickerInFrame6:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 11, 4, 3, 3
	panel_rect 3, 18, 17, 4, 3, 3
	tilemap_rect_end
.savedDataPickerInFrame7:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 8, 4, 3, 3
	panel_rect 3, 18, 14, 4, 3, 3
	tilemap_rect_end
.savedDataPickerInFrame8:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 5, 4, 3, 3
	panel_rect 3, 18, 11, 4, 3, 3
	panel_rect 6, 18, 17, 4, 3, 3
	panel_rect 0, 21, 18, 9, 5, 3
	tilemap_rect_end
.savedDataPickerInFrame9:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 3, 4, 3, 3
	panel_rect 3, 18, 9, 4, 3, 3
	panel_rect 6, 18, 15, 4, 3, 3
	panel_rect 0, 21, 15, 9, 5, 3
	tilemap_rect_end
.savedDataPickerInFrame10:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 0, 21, 12, 9, 5, 3
	panel_rect 5, 21, 20, 9, 5, 3
	tilemap_rect_end
.savedDataPickerInFrame11:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 0, 21, 9, 9, 5, 3
	panel_rect 5, 21, 17, 9, 5, 3
	tilemap_rect_end
.savedDataPickerInFrame12:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 0, 21, 6, 9, 5, 3
	panel_rect 5, 21, 14, 9, 5, 3
	tilemap_rect_end
.savedDataPickerInFrame13:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 0, 21, 4, 9, 5, 3
	panel_rect 5, 21, 12, 9, 5, 3
	tilemap_rect_end
.savedDataPickerShown:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 0, 21, 3, 9, 5, 3
	panel_rect 5, 21, 11, 9, 5, 3
	tilemap_rect_end
.savedDataPickerShownNudged:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 1, 4, 3, 3
	panel_rect 3, 18, 7, 4, 3, 3
	panel_rect 6, 18, 13, 4, 3, 3
	panel_rect 0, 21, 3, 9, 5, 3
	panel_rect 5, 21, 11, 9, 5, 3
	tilemap_rect_end
.savedDataPickerOutFrame2:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 31, 3, 3, 3
	panel_rect 3, 18, 5, 4, 3, 3
	panel_rect 6, 18, 11, 4, 3, 3
	panel_rect 0, 21, 3, 9, 5, 3
	panel_rect 5, 21, 11, 9, 5, 3
	tilemap_rect_end
.savedDataPickerOutFrame3:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 3, 18, 2, 4, 3, 3
	panel_rect 6, 18, 8, 4, 3, 3
	panel_rect 0, 21, 2, 9, 5, 3
	panel_rect 5, 21, 10, 9, 5, 3
	tilemap_rect_end
.savedDataPickerOutFrame4:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 3, 18, 31, 3, 3, 3
	panel_rect 6, 18, 5, 4, 3, 3
	panel_rect 0, 21, 0, 9, 5, 3
	panel_rect 5, 21, 8, 9, 5, 3
	tilemap_rect_end
.savedDataPickerOutFrame5:
	panel_rect 6, 18, 2, 4, 3, 3
	panel_rect 0, 21, 29, 8, 5, 3
	panel_rect 5, 21, 5, 9, 5, 3
	tilemap_rect_end
.savedDataPickerOutFrame6:
	panel_rect 6, 18, 31, 3, 3, 3
	panel_rect 0, 21, 26, 8, 5, 3
	panel_rect 5, 21, 2, 9, 5, 3
	tilemap_rect_end
.savedDataPickerOutFrame7:
	panel_rect 0, 21, 23, 8, 5, 3
	panel_rect 5, 21, 31, 8, 5, 3
	tilemap_rect_end
.savedDataPickerOutFrame8:
	panel_rect 5, 21, 28, 8, 5, 3
	tilemap_rect_end
.savedDataPickerOutFrame9:
	panel_rect 5, 21, 25, 8, 5, 3
	tilemap_rect_end
.n64RecordTypeInFrame3:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 19, 7, 5, 3
	tilemap_rect_end
.n64RecordTypeInFrame4:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 16, 7, 5, 3
	tilemap_rect_end
.n64RecordTypeInFrame5:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 13, 7, 5, 3
	panel_rect 5, 21, 22, 7, 5, 3
	tilemap_rect_end
.n64RecordTypeInFrame6:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 10, 7, 5, 3
	panel_rect 5, 21, 19, 7, 5, 3
	tilemap_rect_end
.n64RecordTypeInFrame7:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 7, 7, 5, 3
	panel_rect 5, 21, 16, 7, 5, 3
	tilemap_rect_end
.n64RecordTypeInFrame8:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 4, 7, 5, 3
	panel_rect 5, 21, 13, 7, 5, 3
	panel_rect 10, 21, 22, 7, 5, 3
	tilemap_rect_end
.n64RecordTypeInFrame9:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 2, 7, 5, 3
	panel_rect 5, 21, 10, 7, 5, 3
	panel_rect 10, 21, 19, 7, 5, 3
	tilemap_rect_end
.n64RecordTypeInFrame10:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 7, 5, 3
	panel_rect 5, 21, 8, 7, 5, 3
	panel_rect 10, 21, 16, 7, 5, 3
	tilemap_rect_end
.n64RecordTypeInFrame11:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 7, 5, 3
	panel_rect 5, 21, 7, 7, 5, 3
	panel_rect 10, 21, 14, 7, 5, 3
	tilemap_rect_end
.n64RecordTypeInFrame12:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 7, 5, 3
	panel_rect 5, 21, 7, 7, 5, 3
	panel_rect 10, 21, 13, 7, 5, 3
	tilemap_rect_end
.n64RecordTypeOutFrame0:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 7, 5, 3
	panel_rect 5, 21, 7, 7, 5, 3
	panel_rect 10, 21, 13, 7, 5, 3
	tilemap_rect_end
.n64RecordTypeOutFrame1:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 0, 7, 5, 3
	panel_rect 5, 21, 7, 7, 5, 3
	panel_rect 10, 21, 13, 7, 5, 3
	tilemap_rect_end
.n64RecordTypeOutFrame2:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 30, 6, 5, 3
	panel_rect 5, 21, 6, 7, 5, 3
	panel_rect 10, 21, 13, 7, 5, 3
	tilemap_rect_end
.n64RecordTypeOutFrame3:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 27, 6, 5, 3
	panel_rect 5, 21, 4, 7, 5, 3
	panel_rect 10, 21, 12, 7, 5, 3
	tilemap_rect_end
.n64RecordTypeOutFrame4:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 24, 6, 5, 3
	panel_rect 5, 21, 1, 7, 5, 3
	panel_rect 10, 21, 10, 7, 5, 3
	tilemap_rect_end
.n64RecordTypeOutFrame5:
	panel_rect 5, 21, 30, 6, 5, 3
	panel_rect 10, 21, 7, 7, 5, 3
	tilemap_rect_end
.n64RecordTypeOutFrame6:
	panel_rect 5, 21, 27, 6, 5, 3
	panel_rect 10, 21, 4, 7, 5, 3
	tilemap_rect_end
.n64RecordTypeOutFrame7:
	panel_rect 10, 21, 1, 7, 5, 3
	tilemap_rect_end
.n64RecordTypeOutFrame8:
	panel_rect 10, 21, 30, 6, 5, 3
	tilemap_rect_end
.n64RecordTypeOutFrame9:
	panel_rect 10, 21, 27, 6, 5, 3
	tilemap_rect_end
.n64RecordTypeOutFrame10:
	panel_rect 10, 21, 24, 6, 5, 3
	tilemap_rect_end
.choiceTabInFrame3:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 21, 7, 5, 3
	tilemap_rect_end
.choiceTabInFrame4:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 18, 7, 5, 3
	tilemap_rect_end
.choiceTabInFrame5:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 15, 7, 5, 3
	tilemap_rect_end
.choiceTabInFrame6:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 12, 7, 5, 3
	panel_rect 5, 21, 24, 7, 5, 3
	tilemap_rect_end
.choiceTabInFrame7:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 9, 7, 5, 3
	panel_rect 5, 21, 21, 7, 5, 3
	tilemap_rect_end
.choiceTabInFrame8:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 6, 7, 5, 3
	panel_rect 5, 21, 18, 7, 5, 3
	tilemap_rect_end
.choiceTabInFrame9:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 4, 7, 5, 3
	panel_rect 5, 21, 15, 7, 5, 3
	tilemap_rect_end
.choiceTabInFrame10:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 3, 7, 5, 3
	panel_rect 5, 21, 13, 7, 5, 3
	tilemap_rect_end
.choiceTabInFrame11:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 3, 7, 5, 3
	panel_rect 5, 21, 12, 7, 5, 3
	tilemap_rect_end
.choiceTabShown:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 3, 7, 5, 3
	panel_rect 5, 21, 12, 7, 5, 3
	tilemap_rect_end
.choiceTabOutFrame1:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 2, 7, 5, 3
	panel_rect 5, 21, 12, 7, 5, 3
	tilemap_rect_end
.choiceTabOutFrame2:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 0, 7, 5, 3
	panel_rect 5, 21, 11, 7, 5, 3
	tilemap_rect_end
.choiceTabOutFrame3:
	panel_rect 0, 21, 29, 6, 5, 3
	panel_rect 5, 21, 9, 7, 5, 3
	tilemap_rect_end
.choiceTabOutFrame4:
	panel_rect 0, 21, 26, 6, 5, 3
	panel_rect 5, 21, 6, 7, 5, 3
	tilemap_rect_end
.choiceTabOutFrame5:
	panel_rect 0, 21, 23, 6, 5, 3
	panel_rect 5, 21, 3, 7, 5, 3
	tilemap_rect_end
.choiceTabOutFrame6:
	panel_rect 5, 21, 0, 7, 5, 3
	tilemap_rect_end
.choiceTabOutFrame7:
	panel_rect 5, 21, 29, 6, 5, 3
	tilemap_rect_end
.choiceTabOutFrame8:
	panel_rect 5, 21, 26, 6, 5, 3
	tilemap_rect_end
.choiceTabOutFrame9:
	tilemap_rect_end
.courtSelect4InFrame3:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 22, 4, 5, 3
	tilemap_rect_end
.courtSelect4InFrame4:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 19, 4, 5, 3
	tilemap_rect_end
.courtSelect4InFrame5:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 16, 4, 5, 3
	panel_rect 5, 21, 23, 4, 5, 3
	panel_rect 10, 21, 22, 9, 5, 3
	tilemap_rect_end
.courtSelect4InFrame6:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 13, 4, 5, 3
	panel_rect 5, 21, 20, 4, 5, 3
	panel_rect 10, 21, 19, 9, 5, 3
	tilemap_rect_end
.courtSelect4InFrame7:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 10, 4, 5, 3
	panel_rect 5, 21, 17, 4, 5, 3
	panel_rect 10, 21, 16, 9, 5, 3
	panel_rect 15, 21, 23, 9, 5, 3
	tilemap_rect_end
.courtSelect4InFrame8:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 7, 4, 5, 3
	panel_rect 5, 21, 14, 4, 5, 3
	panel_rect 10, 21, 13, 9, 5, 3
	panel_rect 15, 21, 20, 9, 5, 3
	tilemap_rect_end
.courtSelect4InFrame9:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 5, 4, 5, 3
	panel_rect 5, 21, 12, 4, 5, 3
	panel_rect 10, 21, 10, 9, 5, 3
	panel_rect 15, 21, 17, 9, 5, 3
	tilemap_rect_end
.courtSelect4InFrame10:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 4, 4, 5, 3
	panel_rect 5, 21, 11, 4, 5, 3
	panel_rect 10, 21, 7, 9, 5, 3
	panel_rect 15, 21, 14, 9, 5, 3
	tilemap_rect_end
.courtSelect4InFrame11:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 4, 4, 5, 3
	panel_rect 5, 21, 11, 4, 5, 3
	panel_rect 10, 21, 5, 9, 5, 3
	panel_rect 15, 21, 12, 9, 5, 3
	tilemap_rect_end
.courtSelect4InFrame12:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 4, 4, 5, 3
	panel_rect 5, 21, 11, 4, 5, 3
	panel_rect 10, 21, 4, 9, 5, 3
	panel_rect 15, 21, 11, 9, 5, 3
	tilemap_rect_end
.courtSelect4InFrame13:
	tilemap_rect_end
.courtSelect4InFrame14:
	tilemap_rect_end
.courtSelect4InFrame15:
	tilemap_rect_end
.courtSelect4InFrame16:
	tilemap_rect_end
.courtSelect4OutFrame0:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 4, 4, 5, 3
	panel_rect 5, 21, 11, 4, 5, 3
	panel_rect 10, 21, 4, 9, 5, 3
	panel_rect 15, 21, 11, 9, 5, 3
	tilemap_rect_end
.courtSelect4OutFrame1:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 3, 4, 5, 3
	panel_rect 5, 21, 10, 4, 5, 3
	panel_rect 10, 21, 4, 9, 5, 3
	panel_rect 15, 21, 11, 9, 5, 3
	tilemap_rect_end
.courtSelect4OutFrame2:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 1, 4, 5, 3
	panel_rect 5, 21, 8, 4, 5, 3
	panel_rect 10, 21, 4, 9, 5, 3
	panel_rect 15, 21, 11, 9, 5, 3
	tilemap_rect_end
.courtSelect4OutFrame3:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 30, 3, 5, 3
	panel_rect 5, 21, 5, 4, 5, 3
	panel_rect 10, 21, 3, 9, 5, 3
	panel_rect 15, 21, 10, 9, 5, 3
	tilemap_rect_end
.courtSelect4OutFrame4:
	panel_rect 0, 21, 27, 3, 5, 3
	panel_rect 5, 21, 2, 4, 5, 3
	panel_rect 10, 21, 1, 9, 5, 3
	panel_rect 15, 21, 8, 9, 5, 3
	tilemap_rect_end
.courtSelect4OutFrame5:
	panel_rect 0, 21, 24, 3, 5, 3
	panel_rect 5, 21, 31, 3, 5, 3
	panel_rect 10, 21, 30, 8, 5, 3
	panel_rect 15, 21, 5, 9, 5, 3
	tilemap_rect_end
.courtSelect4OutFrame6:
	panel_rect 5, 21, 28, 3, 5, 3
	panel_rect 10, 21, 27, 8, 5, 3
	panel_rect 15, 21, 2, 9, 5, 3
	tilemap_rect_end
.courtSelect4OutFrame7:
	panel_rect 15, 21, 31, 8, 5, 3
	tilemap_rect_end
.courtSelect4OutFrame8:
	panel_rect 15, 21, 28, 8, 5, 3
	tilemap_rect_end
.courtSelect4OutFrame9:
	tilemap_rect_end
.courtSelect4OutFrame10:
	tilemap_rect_end
.courtSelect4OutFrame11:
	tilemap_rect_end
.courtSelect4OutFrame12:
	tilemap_rect_end
.courtSelect4OutFrame13:
	tilemap_rect_end
.courtSelect9InFrame3:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 19, 3, 5, 3
	tilemap_rect_end
.courtSelect9InFrame4:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 16, 3, 5, 3
	panel_rect 5, 21, 22, 3, 5, 3
	tilemap_rect_end
.courtSelect9InFrame5:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 13, 3, 5, 3
	panel_rect 5, 21, 19, 3, 5, 3
	panel_rect 15, 21, 19, 7, 5, 3
	panel_rect 20, 21, 25, 7, 5, 3
	tilemap_rect_end
.courtSelect9InFrame6:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 10, 3, 5, 3
	panel_rect 5, 21, 16, 3, 5, 3
	panel_rect 10, 21, 22, 3, 5, 3
	panel_rect 15, 21, 16, 7, 5, 3
	panel_rect 20, 21, 22, 7, 5, 3
	tilemap_rect_end
.courtSelect9InFrame7:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 7, 3, 5, 3
	panel_rect 5, 21, 13, 3, 5, 3
	panel_rect 10, 21, 19, 3, 5, 3
	panel_rect 15, 21, 13, 7, 5, 3
	panel_rect 20, 21, 19, 7, 5, 3
	panel_rect 25, 21, 25, 7, 5, 3
	panel_rect 20, 26, 19, 11, 5, 3
	tilemap_rect_end
.courtSelect9InFrame8:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 4, 3, 5, 3
	panel_rect 5, 21, 10, 3, 5, 3
	panel_rect 10, 21, 16, 3, 5, 3
	panel_rect 15, 21, 10, 7, 5, 3
	panel_rect 20, 21, 16, 7, 5, 3
	panel_rect 25, 21, 22, 7, 5, 3
	panel_rect 20, 26, 16, 11, 5, 3
	panel_rect 25, 26, 22, 11, 5, 3
	tilemap_rect_end
.courtSelect9InFrame9:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 2, 3, 5, 3
	panel_rect 5, 21, 8, 3, 5, 3
	panel_rect 10, 21, 14, 3, 5, 3
	panel_rect 15, 21, 7, 7, 5, 3
	panel_rect 20, 21, 13, 7, 5, 3
	panel_rect 25, 21, 19, 7, 5, 3
	panel_rect 20, 26, 13, 11, 5, 3
	panel_rect 25, 26, 19, 11, 5, 3
	panel_rect 27, 18, 25, 11, 5, 3
	tilemap_rect_end
.courtSelect9InFrame10:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 15, 21, 4, 7, 5, 3
	panel_rect 20, 21, 10, 7, 5, 3
	panel_rect 25, 21, 16, 7, 5, 3
	panel_rect 20, 26, 10, 11, 5, 3
	panel_rect 25, 26, 16, 11, 5, 3
	panel_rect 27, 18, 22, 11, 5, 3
	tilemap_rect_end
.courtSelect9InFrame11:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 15, 21, 2, 7, 5, 3
	panel_rect 20, 21, 8, 7, 5, 3
	panel_rect 25, 21, 14, 7, 5, 3
	panel_rect 20, 26, 7, 11, 5, 3
	panel_rect 25, 26, 13, 11, 5, 3
	panel_rect 27, 18, 19, 11, 5, 3
	tilemap_rect_end
.courtSelect9InFrame12:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 15, 21, 1, 7, 5, 3
	panel_rect 20, 21, 7, 7, 5, 3
	panel_rect 25, 21, 13, 7, 5, 3
	panel_rect 20, 26, 4, 11, 5, 3
	panel_rect 25, 26, 10, 11, 5, 3
	panel_rect 27, 18, 16, 11, 5, 3
	tilemap_rect_end
.courtSelect9InFrame13:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 15, 21, 1, 7, 5, 3
	panel_rect 20, 21, 7, 7, 5, 3
	panel_rect 25, 21, 13, 7, 5, 3
	panel_rect 20, 26, 2, 11, 5, 3
	panel_rect 25, 26, 8, 11, 5, 3
	panel_rect 27, 18, 14, 11, 5, 3
	tilemap_rect_end
.courtSelect9InFrame14:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 15, 21, 1, 7, 5, 3
	panel_rect 20, 21, 7, 7, 5, 3
	panel_rect 25, 21, 13, 7, 5, 3
	panel_rect 20, 26, 1, 11, 5, 3
	panel_rect 25, 26, 7, 11, 5, 3
	panel_rect 27, 18, 13, 11, 5, 3
	tilemap_rect_end
.courtSelect9Shown:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 0, 3, 5, 3
	panel_rect 5, 21, 6, 3, 5, 3
	panel_rect 10, 21, 12, 3, 5, 3
	panel_rect 15, 21, 1, 7, 5, 3
	panel_rect 20, 21, 7, 7, 5, 3
	panel_rect 25, 21, 13, 7, 5, 3
	panel_rect 20, 26, 1, 11, 5, 3
	panel_rect 25, 26, 7, 11, 5, 3
	panel_rect 27, 18, 13, 11, 5, 3
	tilemap_rect_end
.courtSelect9OutFrame1:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 30, 2, 5, 3
	panel_rect 5, 21, 4, 3, 5, 3
	panel_rect 10, 21, 10, 3, 5, 3
	panel_rect 15, 21, 0, 7, 5, 3
	panel_rect 20, 21, 6, 7, 5, 3
	panel_rect 25, 21, 12, 7, 5, 3
	panel_rect 20, 26, 1, 11, 5, 3
	panel_rect 25, 26, 7, 11, 5, 3
	panel_rect 27, 18, 13, 11, 5, 3
	tilemap_rect_end
.courtSelect9OutFrame2:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 27, 2, 5, 3
	panel_rect 5, 21, 1, 3, 5, 3
	panel_rect 10, 21, 7, 3, 5, 3
	panel_rect 15, 21, 30, 6, 5, 3
	panel_rect 20, 21, 4, 7, 5, 3
	panel_rect 25, 21, 10, 7, 5, 3
	panel_rect 20, 26, 0, 11, 5, 3
	panel_rect 25, 26, 6, 11, 5, 3
	panel_rect 27, 18, 12, 11, 5, 3
	tilemap_rect_end
.courtSelect9OutFrame3:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 24, 2, 5, 3
	panel_rect 5, 21, 30, 2, 5, 3
	panel_rect 10, 21, 4, 3, 5, 3
	panel_rect 15, 21, 27, 6, 5, 3
	panel_rect 20, 21, 1, 7, 5, 3
	panel_rect 25, 21, 7, 7, 5, 3
	panel_rect 20, 26, 30, 10, 5, 3
	panel_rect 25, 26, 4, 11, 5, 3
	panel_rect 27, 18, 10, 11, 5, 3
	tilemap_rect_end
.courtSelect9OutFrame4:
	panel_rect 5, 21, 27, 2, 5, 3
	panel_rect 10, 21, 1, 3, 5, 3
	panel_rect 15, 21, 24, 6, 5, 3
	panel_rect 20, 21, 30, 6, 5, 3
	panel_rect 25, 21, 4, 7, 5, 3
	panel_rect 20, 26, 27, 10, 5, 3
	panel_rect 25, 26, 1, 11, 5, 3
	panel_rect 27, 18, 7, 11, 5, 3
	tilemap_rect_end
.courtSelect9OutFrame5:
	panel_rect 10, 21, 30, 2, 5, 3
	panel_rect 20, 21, 27, 6, 5, 3
	panel_rect 25, 21, 1, 7, 5, 3
	panel_rect 20, 26, 24, 10, 5, 3
	panel_rect 25, 26, 30, 10, 5, 3
	panel_rect 27, 18, 4, 11, 5, 3
	tilemap_rect_end
.courtSelect9OutFrame6:
	panel_rect 25, 21, 30, 6, 5, 3
	panel_rect 25, 26, 27, 10, 5, 3
	panel_rect 27, 18, 1, 11, 5, 3
	tilemap_rect_end
.courtSelect9OutFrame7:
	panel_rect 27, 18, 30, 10, 5, 3
	tilemap_rect_end
.courtSelect9OutFrame8:
	panel_rect 27, 18, 27, 10, 5, 3
	tilemap_rect_end
.courtSelect9OutFrame9:
	panel_rect 27, 18, 24, 10, 5, 3
	tilemap_rect_end
.courtSelect9OutFrame10:
	tilemap_rect_end
.minigameGrid6InFrame3:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 17, 4, 3, 3
	tilemap_rect_end
.minigameGrid6InFrame4:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 14, 4, 3, 3
	tilemap_rect_end
.minigameGrid6InFrame5:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 11, 4, 3, 3
	panel_rect 3, 18, 17, 4, 3, 3
	tilemap_rect_end
.minigameGrid6InFrame6:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 8, 4, 3, 3
	panel_rect 3, 18, 14, 4, 3, 3
	panel_rect 6, 18, 20, 4, 3, 3
	tilemap_rect_end
.minigameGrid6InFrame7:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 5, 4, 3, 3
	panel_rect 3, 18, 11, 4, 3, 3
	panel_rect 6, 18, 17, 4, 3, 3
	panel_rect 9, 18, 20, 9, 3, 3
	tilemap_rect_end
.minigameGrid6InFrame8:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 3, 4, 3, 3
	panel_rect 3, 18, 9, 4, 3, 3
	panel_rect 6, 18, 15, 4, 3, 3
	panel_rect 9, 18, 17, 9, 3, 3
	panel_rect 15, 18, 23, 9, 3, 3
	tilemap_rect_end
.minigameGrid6InFrame9:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 9, 18, 14, 9, 3, 3
	panel_rect 15, 18, 20, 9, 3, 3
	tilemap_rect_end
.minigameGrid6InFrame10:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 9, 18, 11, 9, 3, 3
	panel_rect 15, 18, 17, 9, 3, 3
	tilemap_rect_end
.minigameGrid6InFrame11:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 9, 18, 8, 9, 3, 3
	panel_rect 15, 18, 14, 9, 3, 3
	tilemap_rect_end
.minigameGrid6InFrame12:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 9, 18, 6, 9, 3, 3
	panel_rect 15, 18, 12, 9, 3, 3
	tilemap_rect_end
.minigameGrid6Shown:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 9, 18, 5, 9, 3, 3
	panel_rect 15, 18, 11, 9, 3, 3
	tilemap_rect_end
.minigameGrid6ShownNudged:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 1, 4, 3, 3
	panel_rect 3, 18, 7, 4, 3, 3
	panel_rect 6, 18, 13, 4, 3, 3
	panel_rect 9, 18, 5, 9, 3, 3
	panel_rect 15, 18, 11, 9, 3, 3
	tilemap_rect_end
.minigameGrid6OutFrame2:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 31, 3, 3, 3
	panel_rect 3, 18, 5, 4, 3, 3
	panel_rect 6, 18, 11, 4, 3, 3
	panel_rect 9, 18, 5, 9, 3, 3
	panel_rect 15, 18, 11, 9, 3, 3
	tilemap_rect_end
.minigameGrid6OutFrame3:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 28, 3, 3, 3
	panel_rect 3, 18, 2, 4, 3, 3
	panel_rect 6, 18, 8, 4, 3, 3
	panel_rect 9, 18, 4, 9, 3, 3
	panel_rect 15, 18, 10, 9, 3, 3
	tilemap_rect_end
.minigameGrid6OutFrame4:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 25, 3, 3, 3
	panel_rect 3, 18, 31, 3, 3, 3
	panel_rect 6, 18, 5, 4, 3, 3
	panel_rect 9, 18, 2, 9, 3, 3
	panel_rect 15, 18, 8, 9, 3, 3
	tilemap_rect_end
.minigameGrid6OutFrame5:
	panel_rect 3, 18, 28, 3, 3, 3
	panel_rect 6, 18, 2, 4, 3, 3
	panel_rect 9, 18, 31, 8, 3, 3
	panel_rect 15, 18, 5, 9, 3, 3
	tilemap_rect_end
.minigameGrid6OutFrame6:
	panel_rect 6, 18, 31, 3, 3, 3
	panel_rect 9, 18, 28, 8, 3, 3
	panel_rect 15, 18, 2, 9, 3, 3
	tilemap_rect_end
.minigameGrid6OutFrame7:
	panel_rect 9, 18, 25, 8, 3, 3
	panel_rect 15, 18, 31, 8, 3, 3
	tilemap_rect_end
.minigameGrid6OutFrame8:
	panel_rect 15, 18, 28, 8, 3, 3
	tilemap_rect_end
.pastEnd:
