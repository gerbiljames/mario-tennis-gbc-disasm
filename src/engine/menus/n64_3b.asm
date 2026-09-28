; Instruction-identical to GetCellIndexFromCursorPtr_16 and GetCellIndexFromCursorPtr_3e (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin get_cell_index_from_cursor_ptr, 3b ; $43cb GetCellIndexFromCursorPtr_3b
; Instruction-identical to SetMenuCursorFromIndex_16, SetMenuCursorFromIndex_38 and SetMenuCursorFromIndex_3e (one copy per bank); a change here belongs in every copy.
	twin set_menu_cursor_from_index, 3b ; $43db SetMenuCursorFromIndex_3b
Unused_3b_StoreCellIndexToCursorPtr:
	ld d, $00 ; $43ed
	ld a, c ; $43ef
.loop:
	cp b ; $43f0
	jr c, .store ; $43f1
	inc d ; $43f3
	sub b ; $43f4
	jr .loop ; $43f5
.store:
	ld [hl+], a ; $43f7
	ld a, d ; $43f8
	ld [hl], a ; $43f9
	ret ; $43fa
ClearWram3Row64:
	push_wram_bank WRAM_SCREEN ; $43fb
	xor a ; $4404
	ld c, $40 ; $4405
.loop:
	ld [hl+], a ; $4407
	dec c ; $4408
	jr nz, .loop ; $4409
	pop_wram_bank ; $440b
	ret ; $4410
ClearWram3Row64Alt:
	push_wram_bank WRAM_SCREEN ; $4411
	ld a, $00 ; $441a
	ld c, $40 ; $441c
.loopB:
	ld [hl+], a ; $441e
	dec c ; $441f
	jr nz, .loopB ; $4420
	pop_wram_bank ; $4422
	ret ; $4427
UpdateAnimatedTilesTask_3b:
	farcall UpdateAnimatedTiles ; $4428
	ret ; $442b
; Instruction-identical to DrawNameWithDiacritics_38 (one copy per bank); a change here belongs in every copy.
	twin draw_name_with_diacritics_38, 3b ; $442c DrawNameWithDiacritics_3b
; Instruction-identical to DrawDecimalNumber_17, DrawDecimalNumber_1b and DrawDecimalNumber_3e (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin draw_decimal_number, 3b ; $4465 DrawDecimalNumber_3b
DrawAsciiDigitString_3b:
	ld a, [hl+] ; $4486
	and a ; $4487
	jr z, .done ; $4488
	call DrawAsciiDigitChar_3b ; $448a
	jr DrawAsciiDigitString_3b ; $448d
.done:
	ret ; $448f
; Instruction-identical to DrawAsciiDigitChar_16, DrawAsciiDigitChar_17, DrawAsciiDigitChar_1b and DrawAsciiDigitChar_3e (one copy per bank); a change here belongs in every copy.
	twin draw_ascii_digit_char, 3b ; $4490 DrawAsciiDigitChar_3b
StubNop_3b:
	ret ; $44a9
RunN64ExhibData:
	sound BGM_STATUS_SCREEN ; $44aa
	call DisableLCDSafely ; $44ac
	call BuildN64ExhibDataScreen ; $44af
	xor a ; $44b2
	ld [wAnimatedTileSet], a ; $44b3
	ld a, $01 ; $44b6
	ld hl, UpdateAnimatedTilesTask_3b ; $44b8
	call RegisterFrameTask ; $44bb
	ld a, $01 ; $44be
	ld hl, N64ExhibScrollArrowsTask ; $44c0
	call RegisterFrameTask ; $44c3
	call EnableLCD ; $44c6
	script_fade_in $10 ; $44c9
	call WaitFadeEnd ; $44ce
	wram_bank WRAM_SCREEN ; $44d1
.loop:
	ldh a, [hInputPressed] ; $44d7
	ld [wMenuInputPressed], a ; $44d9
	call ScrollN64ExhibDataCursor ; $44dc
	call AdvanceFrame ; $44df
	ld a, [wMenuInputPressed] ; $44e2
	bit PADB_A, a ; $44e5
	jr nz, .playSfx ; $44e7
	bit 1, a ; $44e9
	jr nz, .playSfx2 ; $44eb
	jr .loop ; $44ed
.playSfx:
	sound SFX_MENU_SELECT ; $44ef
	ld c, $10 ; $44f1
	call BeginFadeOut ; $44f3
	call WaitFadeEnd ; $44f6
	call ClearFrameTasks ; $44f9
	ret ; $44fc
.playSfx2:
	sound SFX_MENU_CANCEL ; $44fd
	ld c, $10 ; $44ff
	call BeginFadeOut ; $4501
	call WaitFadeEnd ; $4504
	call ClearFrameTasks ; $4507
	ld a, $ff ; $450a
	ret ; $450c
ScrollN64ExhibDataCursor:
	ld a, [wMenuInputPressed] ; $450d
	bit PADB_LEFT, a ; $4510
	jr z, .step ; $4512
	ld a, [wN64ExhibPage] ; $4514
	or a ; $4517
	jr z, .done ; $4518
	dec a ; $451a
	ld [wN64ExhibPage], a ; $451b
	sound SFX_MENU_MOVE ; $451e
	call RedrawN64ExhibDataWindow ; $4520
	jr .done ; $4523
.step:
	bit 4, a ; $4525
	jr z, .bit4Clear ; $4527
	ld a, [wN64ExhibPage] ; $4529
	cp $09 ; $452c
	jr z, .done ; $452e
	inc a ; $4530
	ld [wN64ExhibPage], a ; $4531
	sound SFX_MENU_MOVE ; $4534
	call RedrawN64ExhibDataWindow ; $4536
	jr .done ; $4539
.bit4Clear:
	bit 6, a ; $453b
	jr z, .bit6Clear ; $453d
	ld a, [wN64ExhibCursorRow] ; $453f
	or a ; $4542
	jr z, .done ; $4543
	dec a ; $4545
	ld [wN64ExhibCursorRow], a ; $4546
	sound SFX_MENU_MOVE ; $4549
	call RedrawN64ExhibDataWindow ; $454b
	jr .done ; $454e
.bit6Clear:
	bit 7, a ; $4550
	jr z, .done ; $4552
	ld a, [wN64ExhibCursorRow] ; $4554
	cp $0c ; $4557
	jr z, .done ; $4559
	inc a ; $455b
	ld [wN64ExhibCursorRow], a ; $455c
	sound SFX_MENU_MOVE ; $455f
	call RedrawN64ExhibDataWindow ; $4561
	jr .done ; $4564
.done:
	ret ; $4566
N64ExhibScrollArrowsTask:
	push_wram_bank WRAM_SCREEN ; $4567
	ld a, [wN64ExhibPage] ; $4570
	cp $09 ; $4573
	jr z, .eq09 ; $4575
	ld de, $932f ; $4577
	ld c, $01 ; $457a
	call ApplyCursorBounceX ; $457c
	ld b, $08 ; $457f
	ld c, $00 ; $4581
	ld h, $00 ; $4583
	farcall QueueStackedSpritePair ; $4585
.eq09:
	ld a, [wN64ExhibPage] ; $4588
	or a ; $458b
	jr z, .zero ; $458c
	ld de, $082f ; $458e
	ld c, $00 ; $4591
	call ApplyCursorBounceX ; $4593
	ld b, $08 ; $4596
	ld c, $00 ; $4598
	ld h, $01 ; $459a
	farcall QueueStackedSpritePair ; $459c
.zero:
	ld a, [wN64ExhibCursorRow] ; $459f
	or a ; $45a2
	jr z, .zero2 ; $45a3
	ld de, $0a20 ; $45a5
	ld c, $01 ; $45a8
	call ApplyCursorBounceY ; $45aa
	ld b, $08 ; $45ad
	ld c, $00 ; $45af
	ld h, $02 ; $45b1
	farcall QueueStackedSpritePair ; $45b3
.zero2:
	ld a, [wN64ExhibCursorRow] ; $45b6
	cp $0c ; $45b9
	jr z, .restore ; $45bb
	ld de, $0a78 ; $45bd
	ld c, $00 ; $45c0
	call ApplyCursorBounceY ; $45c2
	ld b, $08 ; $45c5
	ld c, $00 ; $45c7
	ld h, $03 ; $45c9
	farcall QueueStackedSpritePair ; $45cb
.restore:
	pop_wram_bank ; $45ce
	ret ; $45d3
BuildN64ExhibDataScreen:
	wram_bank WRAM_SCREEN ; $45d4
	xor a ; $45da
	ld [wN64ExhibCursorRow], a ; $45db
	ld [wN64ExhibPage], a ; $45de
	ld c, SCREENASSET_ExhibitionMenu ; $45e1
	farcall LoadScreenAssetRecord ; $45e3
	ld de, $8ac0 + VRAM_BANK1 ; $45e6
	call LoadChartWindowTiles ; $45e9
	ld de, vTiles0 + VRAM_BANK1 ; $45ec
	farcall LoadMenuArrowSpriteTiles ; $45ef
	ld b, $08 ; $45f2
	ld c, $0f ; $45f4
	farcall LoadIndexedPalette ; $45f6
	wram_bank WRAM_SCREEN ; $45f9
	call ReadN64RecordsSaveBlock ; $45ff
.buildN64ExhibColumnList:
	jr nz, .buildN64ExhibColumnList ; $4602
	call BuildN64ExhibColumnList ; $4604
	call InitChartRowFlags ; $4607
	ld hl, wChartColumnList ; $460a
	ld bc, wShadowTilemap + 7 * TILEMAP_WIDTH + 2 ; $460d
	call DrawChartIconColumn ; $4610
	ld hl, wChartColumnList ; $4613
	ld bc, wShadowTilemap + 5 * TILEMAP_WIDTH + 4 ; $4616
	ld a, $07 ; $4619
	call DrawChartIconRow ; $461b
	ld hl, wChartRows ; $461e
	ld de, wShadowTilemap + 7 * TILEMAP_WIDTH + 4 ; $4621
	ld a, $07 ; $4624
	call DrawChartCellRows ; $4626
	farcall QueueWram3MapToVRAM ; $4629
	ret ; $462c
RedrawN64ExhibDataWindow:
	wram_bank WRAM_SCREEN ; $462d
	ld a, [wN64ExhibPage] ; $4633
	ld hl, wChartColumnList ; $4636
	add l ; $4639
	ld l, a ; $463a
	jr nc, .drawRow ; $463b
	inc h ; $463d
.drawRow:
	ld bc, wShadowTilemap + 5 * TILEMAP_WIDTH + 4 ; $463e
	ld a, $07 ; $4641
	call DrawChartIconRow ; $4643
	ld a, [wN64ExhibCursorRow] ; $4646
	ld hl, wChartColumnList ; $4649
	add l ; $464c
	ld l, a ; $464d
	jr nc, .drawColumn ; $464e
	inc h ; $4650
.drawColumn:
	ld bc, wShadowTilemap + 7 * TILEMAP_WIDTH + 2 ; $4651
	call DrawChartIconColumn ; $4654
	ld a, [wN64ExhibCursorRow] ; $4657
	ld hl, wChartRows ; $465a
	ld de, $0010 ; $465d
.rowSeekLoop:
	or a ; $4660
	jr z, .rowFound ; $4661
	add hl, de ; $4663
	dec a ; $4664
	jr .rowSeekLoop ; $4665
.rowFound:
	ld a, [wN64ExhibPage] ; $4667
	add l ; $466a
	ld l, a ; $466b
	jr nc, .drawCells ; $466c
	inc h ; $466e
.drawCells:
	ld de, wShadowTilemap + 7 * TILEMAP_WIDTH + 4 ; $466f
	ld a, $07 ; $4672
	call DrawChartCellRows ; $4674
	ld hl, wShadowTilemap + 5 * TILEMAP_WIDTH ; $4677
	ld de, vBGMap0 + 5 * TILEMAP_WIDTH ; $467a
	ld c, $08 ; $467d
	call QueueVRAMCopy ; $467f
	ld hl, wShadowAttrmap + 5 * TILEMAP_WIDTH ; $4682
	ld de, vBGMap0 + 5 * TILEMAP_WIDTH + VRAM_BANK1 ; $4685
	ld c, $08 ; $4688
	call QueueVRAMCopy ; $468a
	call AdvanceFrame ; $468d
	ld hl, wShadowTilemap + 9 * TILEMAP_WIDTH ; $4690
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH ; $4693
	ld c, $08 ; $4696
	call QueueVRAMCopy ; $4698
	ld hl, wShadowAttrmap + 9 * TILEMAP_WIDTH ; $469b
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH + VRAM_BANK1 ; $469e
	ld c, $08 ; $46a1
	call QueueVRAMCopy ; $46a3
	call AdvanceFrame ; $46a6
	ld hl, wShadowTilemap + 13 * TILEMAP_WIDTH ; $46a9
	ld de, vBGMap0 + 13 * TILEMAP_WIDTH ; $46ac
	ld c, $04 ; $46af
	call QueueVRAMCopy ; $46b1
	ld hl, wShadowAttrmap + 13 * TILEMAP_WIDTH ; $46b4
	ld de, vBGMap0 + 13 * TILEMAP_WIDTH + VRAM_BANK1 ; $46b7
	ld c, $04 ; $46ba
	call QueueVRAMCopy ; $46bc
	ret ; $46bf
DrawChartIconColumn:
	ld d, h ; $46c0
	ld e, l ; $46c1
	ld h, b ; $46c2
	ld l, c ; $46c3
	ld c, $00 ; $46c4
.iconLoop:
	ld a, [de] ; $46c6
	inc de ; $46c7
	ld b, a ; $46c8
	call DrawChartCharIcon ; $46c9
	push de ; $46cc
	ld de, $0040 ; $46cd
	add hl, de ; $46d0
	pop de ; $46d1
	ld a, c ; $46d2
	inc a ; $46d3
	ld c, a ; $46d4
	cp $04 ; $46d5
	jr nz, .iconLoop ; $46d7
	ret ; $46d9
DrawChartIconRow:
	ld d, h ; $46da
	ld e, l ; $46db
	ld h, b ; $46dc
	ld l, c ; $46dd
	ld c, a ; $46de
.iconLoop:
	ld a, [de] ; $46df
	inc de ; $46e0
	ld b, a ; $46e1
	call DrawChartCharIcon ; $46e2
	inc hl ; $46e5
	inc hl ; $46e6
	ld a, c ; $46e7
	dec a ; $46e8
	ld c, a ; $46e9
	jr nz, .iconLoop ; $46ea
	ret ; $46ec
DrawChartCellRows:
	push af ; $46ed
	ld c, $00 ; $46ee
.rowLoop:
	pop af ; $46f0
	push af ; $46f1
	push bc ; $46f2
	push hl ; $46f3
	push de ; $46f4
	ld c, a ; $46f5
.cellLoop:
	ld a, [hl+] ; $46f6
	ld b, a ; $46f7
	call DrawChartCellMark ; $46f8
	inc de ; $46fb
	inc de ; $46fc
	ld a, c ; $46fd
	dec a ; $46fe
	ld c, a ; $46ff
	jr nz, .cellLoop ; $4700
	pop de ; $4702
	ld hl, $0040 ; $4703
	add hl, de ; $4706
	ld d, h ; $4707
	ld e, l ; $4708
	pop hl ; $4709
	ld bc, $0010 ; $470a
	add hl, bc ; $470d
	pop bc ; $470e
	ld a, c ; $470f
	inc a ; $4710
	ld c, a ; $4711
	cp $04 ; $4712
	jr nz, .rowLoop ; $4714
	pop af ; $4716
	ret ; $4717
DrawChartCellMark:
	push af ; $4718
	push bc ; $4719
	push de ; $471a
	push hl ; $471b
	ld hl, ChartCellMarkTable ; $471c
	ld a, b ; $471f
	add l ; $4720
	ld l, a ; $4721
	jr nc, .read ; $4722
	inc h ; $4724
.read:
	ld a, [hl] ; $4725
	ld h, d ; $4726
	ld l, e ; $4727
	ld [hl+], a ; $4728
	inc a ; $4729
	ld [hl], a ; $472a
	inc a ; $472b
	ld de, $001f ; $472c
	add hl, de ; $472f
	ld [hl+], a ; $4730
	inc a ; $4731
	ld [hl], a ; $4732
	pop hl ; $4733
	pop de ; $4734
	pop bc ; $4735
	pop af ; $4736
	ret ; $4737
ChartCellMarkTable:
	; $4738, 11 bytes (bytes:8)
	db $a4, $9c, $94, $98, $78, $7c, $88, $8c ; 0x00
	db $68, $6c, $a8 ; 0x08
