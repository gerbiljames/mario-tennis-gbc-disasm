; Instruction-identical to GetCellIndexFromCursorPtr_16 and GetCellIndexFromCursorPtr_3b (one copy per bank); a change here belongs in every copy.
	twin get_cell_index_from_cursor_ptr, 3e ; $43db GetCellIndexFromCursorPtr_3e
; Instruction-identical to SetMenuCursorFromIndex_16, SetMenuCursorFromIndex_38 and SetMenuCursorFromIndex_3b (one copy per bank); a change here belongs in every copy.
	twin set_menu_cursor_from_index, 3e ; $43eb SetMenuCursorFromIndex_3e
; Instruction-identical to SetMenuCursorFromIndexToPtr_16 and SetMenuCursorFromIndexToPtr_38 (one copy per bank); a change here belongs in every copy.
	twin set_menu_cursor_from_index_to_ptr, 3e ; $43fd SetMenuCursorFromIndexToPtr_3e
ClearWram3Row64_3e:
	push_wram_bank WRAM_SCREEN ; $440b
	xor a ; $4414
	ld c, $40 ; $4415
.loop:
	ld [hl+], a ; $4417
	dec c ; $4418
	jr nz, .loop ; $4419
	pop_wram_bank ; $441b
	ret ; $4420
ClearWram3Row64Alt_3e:
	push_wram_bank WRAM_SCREEN ; $4421
	ld a, $00 ; $442a
	ld c, $40 ; $442c
.loop:
	ld [hl+], a ; $442e
	dec c ; $442f
	jr nz, .loop ; $4430
	pop_wram_bank ; $4432
	ret ; $4437
UpdateAnimatedTiles_3e:
	farcall UpdateAnimatedTiles ; $4438
	ret ; $443b
; Instruction-identical to DrawNameWithDiacritics_17 and DrawNameWithDiacritics_1b (one copy per bank); a change here belongs in every copy.
	twin draw_name_with_diacritics, 3e ; $443c DrawNameWithDiacritics_3e
; Instruction-identical to DrawDecimalNumber_17, DrawDecimalNumber_1b and DrawDecimalNumber_3b (one copy per bank); a change here belongs in every copy.
	twin draw_decimal_number, 3e ; $4475 DrawDecimalNumber_3e
DrawAsciiDigitString_3e:
	ld a, [hl+] ; $4496
	and a ; $4497
	jr z, .done ; $4498
	call DrawAsciiDigitChar_3e ; $449a
	jr DrawAsciiDigitString_3e ; $449d
.done:
	ret ; $449f
; Instruction-identical to DrawAsciiDigitChar_16, DrawAsciiDigitChar_17, DrawAsciiDigitChar_1b and DrawAsciiDigitChar_3b (one copy per bank); a change here belongs in every copy.
	twin draw_ascii_digit_char, 3e ; $44a0 DrawAsciiDigitChar_3e
RestoreMenuScreenAndFadeIn:
	call DisableLCDSafely ; $44b9
	farcall LoadMenuFontGfx ; $44bc
	farcall ResetScreenAndTextWindows ; $44bf
	call EnableLCD ; $44c2
	script_fade_in $10 ; $44c5
	ret ; $44ca
RunLinkMatchRulesMenu:
	call EnableTimerInterrupt ; $44cb
	sound BGM_MENU ; $44ce
	xor a ; $44d0
	ld [wMatchFormatDoubles], a ; $44d1
	ld [wMatchFormatGames], a ; $44d4
	ld [wMatchFormatSets], a ; $44d7
	xor a ; $44da
	ldh [hLinkExchangeActive], a ; $44db
	call ResetSerialState ; $44dd
	call LoadMatchRulesMenuGraphics ; $44e0
	wram_bank WRAM_SCREEN ; $44e3
	ld a, [wMenuSlideDirection] ; $44e9
	ld b, a ; $44ec
	call OpenMatchRulesPanel ; $44ed
	farcall InitMenuBgScroll ; $44f0
	ld b, $01 ; $44f3
	ld c, $01 ; $44f5
	farcall LoadMenuSpritePalettePair ; $44f7
	call DrawMatchRulesInitialState ; $44fa
	ld a, $01 ; $44fd
	ld hl, MatchRulesCursorSpriteTask ; $44ff
	call RegisterFrameTask ; $4502
	call DrawMatchRulesCaption ; $4505
	farcall ResyncLinkSessionWithTimer ; $4508
	push af ; $450b
	farcall RunLinkInputFrame ; $450c
	pop af ; $450f
	push af ; $4510
	farcall RunLinkInputFrame ; $4511
	pop af ; $4514
	push af ; $4515
	farcall RunLinkInputFrame ; $4516
	pop af ; $4519
	ld hl, rIE ; $451a
	res 2, [hl] ; $451d
	wram_bank WRAM_SCREEN ; $451f
.loop:
	farcall TickMenuBgScroll ; $4525
	ldh a, [hLinkInput] ; $4528
	ld [wMenuInputPressed], a ; $452a
	call HandleMatchRulesToggleInput ; $452d
	ld b, $01 ; $4530
	ld c, $03 ; $4532
	call MoveMenuCursorGrid_3e ; $4534
	or a ; $4537
	jr z, .zero ; $4538
	sound SFX_MENU_MOVE ; $453a
	call DrawMatchRulesCaption ; $453c
.zero:
	push af ; $453f
	farcall RunLinkInputFrame ; $4540
	pop af ; $4543
	ld a, [wMenuInputPressed] ; $4544
	bit PADB_A, a ; $4547
	jr nz, .playSfx ; $4549
	bit 1, a ; $454b
	jr nz, .playSfx2 ; $454d
	jr .loop ; $454f
.playSfx:
	sound SFX_MENU_SELECT ; $4551
	push af ; $4553
	farcall SyncLinkFrame ; $4554
	pop af ; $4557
	xor a ; $4558
	ldh [hLinkExchangeActive], a ; $4559
	call ResetSerialState ; $455b
	call EnableTimerInterrupt ; $455e
	call ClearFrameTasks ; $4561
	ld b, $01 ; $4564
	call CloseMatchRulesPanel ; $4566
	ld a, MENUSLIDE_FORWARD ; $4569
	ld [wMenuSlideDirection], a ; $456b
	ld c, $03 ; $456e
	call GetMenuCursorIndex_3e ; $4570
	ld hl, rIE ; $4573
	set 2, [hl] ; $4576
	ret ; $4578
.playSfx2:
	sound SFX_MENU_CANCEL ; $4579
	push af ; $457b
	farcall SyncLinkFrame ; $457c
	pop af ; $457f
	xor a ; $4580
	ldh [hLinkExchangeActive], a ; $4581
	call ResetSerialState ; $4583
	call ClearFrameTasks ; $4586
	ld b, $00 ; $4589
	call CloseMatchRulesPanel ; $458b
	ld a, MENUSLIDE_BACK ; $458e
	ld [wMenuSlideDirection], a ; $4590
	ld hl, rIE ; $4593
	set 2, [hl] ; $4596
	ld a, $ff ; $4598
	ret ; $459a
DrawMatchRulesInitialState:
	ld b, $01 ; $459b
	ld c, $00 ; $459d
	call SetMenuCursorFromIndex_3e ; $459f
	ld a, [wMatchFormatDoubles] ; $45a2
	ld b, a ; $45a5
	ld c, $01 ; $45a6
	call SetMatchRuleOptionAttrRect ; $45a8
	ld b, $00 ; $45ab
	call FlushMatchRuleRowAttrs ; $45ad
	ld a, [wMatchFormatGames] ; $45b0
	add $02 ; $45b3
	ld b, a ; $45b5
	ld c, $01 ; $45b6
	call SetMatchRuleOptionAttrRect ; $45b8
	ld b, $01 ; $45bb
	call FlushMatchRuleRowAttrs ; $45bd
	ld a, [wMatchFormatSets] ; $45c0
	add $04 ; $45c3
	ld b, a ; $45c5
	ld c, $01 ; $45c6
	call SetMatchRuleOptionAttrRect ; $45c8
	ld b, $02 ; $45cb
	call FlushMatchRuleRowAttrs ; $45cd
	ld hl, MatchRulesInitialStatePalettes0 ; $45d0
	ld d, $04 ; $45d3
	ld e, $01 ; $45d5
	call LoadPaletteShadow ; $45d7
	ld hl, MatchRulesInitialStatePalettes1 ; $45da
	ld d, $06 ; $45dd
	ld e, $01 ; $45df
	call LoadPaletteShadow ; $45e1
	ld hl, MatchRulesInitialStatePalettes2 ; $45e4
	ld d, $07 ; $45e7
	ld e, $01 ; $45e9
	call LoadPaletteShadow ; $45eb
	ret ; $45ee
MatchRulesInitialStatePalettes0:
	; $45ef, 8 bytes (bytes:8)
	db $df, $02, $ff, $7f, $a0, $01, $00, $00 ; 0x00
MatchRulesInitialStatePalettes1:
	; $45f7, 8 bytes (bytes:8)
	db $df, $02, $ff, $7f, $1f, $01, $00, $00 ; 0x00
MatchRulesInitialStatePalettes2:
	; $45ff, 8 bytes (bytes:8)
	db $1f, $03, $ff, $7f, $40, $51, $00, $00 ; 0x00
LoadMatchRulesMenuGraphics:
	push_wram_bank WRAM_STAGING ; $4607
	ld c, $00 ; $4610
.loop:
	ld a, c ; $4612
	add a ; $4613
	ld hl, MatchRulesMenuGraphicsTable ; $4614
	add l ; $4617
	ld l, a ; $4618
	jr nc, .read ; $4619
	inc h ; $461b
.read:
	ld a, [hl+] ; $461c
	ld h, [hl] ; $461d
	ld l, a ; $461e
	push af ; $461f
	push bc ; $4620
	push de ; $4621
	push hl ; $4622
	ld de, wDecompBuffer ; $4623
	call DecompressDataFromBank ; $4626
	pop hl ; $4629
	pop de ; $462a
	pop bc ; $462b
	pop af ; $462c
	ld hl, MatchRulesMenuTable ; $462d
	ld a, c ; $4630
	add a ; $4631
	add l ; $4632
	ld l, a ; $4633
	jr nc, .readB ; $4634
	inc h ; $4636
.readB:
	ld a, [hl+] ; $4637
	ld d, [hl] ; $4638
	ld e, a ; $4639
	ld hl, wDecompBuffer ; $463a
	push af ; $463d
	push bc ; $463e
	push de ; $463f
	push hl ; $4640
	ld bc, $0010 ; $4641
	call QueueVRAMCopy ; $4644
	pop hl ; $4647
	pop de ; $4648
	pop bc ; $4649
	pop af ; $464a
	ld a, c ; $464b
	inc a ; $464c
	ld c, a ; $464d
	call AdvanceFrame ; $464e
	ld a, c ; $4651
	cp $07 ; $4652
	jr nz, .loop ; $4654
	ld b, TILEBLOCK_SharedMenuGfx35 ; $4656
	ld c, SharedMenuGfx35_SIZE / 16 ; $4658
	ld de, vTiles0 + VRAM_BANK1 ; $465a
	farcall LoadCompressedTileBlock ; $465d
	call AdvanceFrame ; $4660
	ld b, TILEBLOCK_SharedMenuGfx36 ; $4663
	ld c, SharedMenuGfx36_SIZE / 16 ; $4665
	ld de, vTiles0 + $10 * TILE_SIZE + VRAM_BANK1 ; $4667
	farcall LoadCompressedTileBlock ; $466a
	call AdvanceFrame ; $466d
	ld b, TILEBLOCK_SharedMenuGfx37 ; $4670
	ld c, SharedMenuGfx37_SIZE / 16 ; $4672
	ld de, vTiles0 + $20 * TILE_SIZE + VRAM_BANK1 ; $4674
	farcall LoadCompressedTileBlock ; $4677
	call AdvanceFrame ; $467a
	ld b, TILEBLOCK_SharedMenuGfx38 ; $467d
	ld c, SharedMenuGfx38_SIZE / 16 ; $467f
	ld de, vTiles0 + $30 * TILE_SIZE + VRAM_BANK1 ; $4681
	farcall LoadCompressedTileBlock ; $4684
	call AdvanceFrame ; $4687
	ld b, TILEBLOCK_SharedMenuGfx39 ; $468a
	ld c, SharedMenuGfx39_SIZE / 16 ; $468c
	ld de, vTiles0 + $40 * TILE_SIZE + VRAM_BANK1 ; $468e
	farcall LoadCompressedTileBlock ; $4691
	call AdvanceFrame ; $4694
	ld b, TILEBLOCK_SharedMenuGfx40 ; $4697
	ld c, SharedMenuGfx40_SIZE / 16 ; $4699
	ld de, vTiles0 + $50 * TILE_SIZE + VRAM_BANK1 ; $469b
	farcall LoadCompressedTileBlock ; $469e
	call AdvanceFrame ; $46a1
	ld b, TILEBLOCK_SharedMenuGfx41 ; $46a4
	ld c, SharedMenuGfx41_SIZE / 16 ; $46a6
	ld de, vTiles0 + $60 * TILE_SIZE + VRAM_BANK1 ; $46a8
	farcall LoadCompressedTileBlock ; $46ab
	call AdvanceFrame ; $46ae
	ld b, TILEBLOCK_SharedMenuGfx27 ; $46b1
	ld c, SharedMenuGfx27_SIZE / 16 ; $46b3
	ld de, vTiles0 + $70 * TILE_SIZE + VRAM_BANK1 ; $46b5
	farcall LoadCompressedTileBlock ; $46b8
	call AdvanceFrame ; $46bb
	ld b, TILEBLOCK_SharedMenuGfx63 ; $46be
	ld c, SharedMenuGfx63_SIZE / 16 ; $46c0
	ld de, vTiles0 ; $46c2
	farcall LoadCompressedTileBlock ; $46c5
	call AdvanceFrame ; $46c8
	ld b, $08 ; $46cb
	ld c, $10 ; $46cd
	farcall LoadIndexedPalette ; $46cf
	pop_wram_bank ; $46d2
	ret ; $46d7
MatchRulesMenuGraphicsTable:
	; $46d8, 14 bytes (7 records x 1 slot words)
	dslot DataPtr_N64RecordTypeLabelTiles0 ; record 0
	dslot DataPtr_N64RecordTypeLabelTiles1 ; record 1
	dslot DataPtr_GamesLabelTiles ; record 2
	dslot DataPtr_GamesLabelTiles2 ; record 3
	dslot DataPtr_OneSetLabelTiles ; record 4
	dslot DataPtr_ThreeSetsLabelTiles ; record 5
	dslot DataPtr_FiveSetsLabelTiles ; record 6
MatchRulesMenuTable:
	; $46e6, 14 bytes (records:2)
	dw $a800 ; record 0
	dw $a900 ; record 1
	dw $aa00 ; record 2
	dw $ab00 ; record 3
	dw $ac00 ; record 4
	dw $ad00 ; record 5
	dw $ae00 ; record 6
OpenMatchRulesPanel:
	ld a, b ; $46f4
	or a ; $46f5
	jr z, .zero ; $46f6
	ld c, $00 ; $46f8
.loop:
	call AdvanceFrame ; $46fa
	ld b, $02 ; $46fd
	farcall RestoreMenuBgAndDrawPanel ; $46ff
	ld b, $00 ; $4702
	farcall FlushWram3MapRows ; $4704
	ld a, c ; $4707
	inc a ; $4708
	ld c, a ; $4709
	cp $0e ; $470a
	jr nz, .loop ; $470c
	call AdvanceFrame ; $470e
	ret ; $4711
.zero:
	ld c, $0a ; $4712
.loopB:
	call AdvanceFrame ; $4714
	ld b, $03 ; $4717
	farcall RestoreMenuBgAndDrawPanel ; $4719
	ld b, $00 ; $471c
	farcall FlushWram3MapRows ; $471e
	ld a, c ; $4721
	dec a ; $4722
	ld c, a ; $4723
	cp $ff ; $4724
	jr nz, .loopB ; $4726
	call AdvanceFrame ; $4728
	ret ; $472b
; Instruction-identical to MatchFormatSlideOut (one copy per bank); a change here belongs in every copy.
	twin_named match_format_slide_out, CloseMatchRulesPanel ; $472c
HandleMatchRulesToggleInput:
	ld a, [wMenuInputPressed] ; $475d
	bit PADB_LEFT, a ; $4760
	jr nz, .playSfx ; $4762
	bit 4, a ; $4764
	jr nz, .playSfx2 ; $4766
	ret ; $4768
.playSfx:
	sound SFX_MENU_MOVE ; $4769
	ld c, $01 ; $476b
	call GetMenuCursorIndex_3e ; $476d
	or a ; $4770
	jr nz, .compare ; $4771
	ld a, [wMatchFormatDoubles] ; $4773
	xor $01 ; $4776
	ld [wMatchFormatDoubles], a ; $4778
	call DrawSinglesDoublesRow ; $477b
	call DrawMatchRulesCaption ; $477e
	ld b, $00 ; $4781
	call FlushMatchRuleRowAttrs ; $4783
	ret ; $4786
.compare:
	cp $01 ; $4787
	jr nz, .checkMatchFormatSets ; $4789
	ld a, [wMatchFormatGames] ; $478b
	xor $01 ; $478e
	ld [wMatchFormatGames], a ; $4790
	call DrawGameCountRow ; $4793
	call DrawMatchRulesCaption ; $4796
	ld b, $01 ; $4799
	call FlushMatchRuleRowAttrs ; $479b
	ret ; $479e
.checkMatchFormatSets:
	ld a, [wMatchFormatSets] ; $479f
	dec a ; $47a2
	add a ; $47a3
	jr nc, .noCarry ; $47a4
	ld a, $03 ; $47a6
	dec a ; $47a8
	jr .store ; $47a9
.noCarry:
	rra ; $47ab
	cp $03 ; $47ac
	jr c, .store ; $47ae
	xor a ; $47b0
.store:
	ld [wMatchFormatSets], a ; $47b1
	call DrawSetCountRow ; $47b4
	call DrawMatchRulesCaption ; $47b7
	ld b, $02 ; $47ba
	call FlushMatchRuleRowAttrs ; $47bc
	ret ; $47bf
.playSfx2:
	sound SFX_MENU_MOVE ; $47c0
	ld c, $01 ; $47c2
	call GetMenuCursorIndex_3e ; $47c4
	or a ; $47c7
	jr nz, .compare2 ; $47c8
	ld a, [wMatchFormatDoubles] ; $47ca
	xor $01 ; $47cd
	ld [wMatchFormatDoubles], a ; $47cf
	call DrawSinglesDoublesRow ; $47d2
	call DrawMatchRulesCaption ; $47d5
	ld b, $00 ; $47d8
	call FlushMatchRuleRowAttrs ; $47da
	ret ; $47dd
.compare2:
	cp $01 ; $47de
	jr nz, .checkMatchFormatSets2 ; $47e0
	ld a, [wMatchFormatGames] ; $47e2
	xor $01 ; $47e5
	ld [wMatchFormatGames], a ; $47e7
	call DrawGameCountRow ; $47ea
	call DrawMatchRulesCaption ; $47ed
	ld b, $01 ; $47f0
	call FlushMatchRuleRowAttrs ; $47f2
	ret ; $47f5
.checkMatchFormatSets2:
	ld a, [wMatchFormatSets] ; $47f6
	inc a ; $47f9
	add a ; $47fa
	jr nc, .noCarry2 ; $47fb
	ld a, $03 ; $47fd
	dec a ; $47ff
	jr .store2 ; $4800
.noCarry2:
	rra ; $4802
	cp $03 ; $4803
	jr c, .store2 ; $4805
	xor a ; $4807
.store2:
	ld [wMatchFormatSets], a ; $4808
	call DrawSetCountRow ; $480b
	call DrawMatchRulesCaption ; $480e
	ld b, $02 ; $4811
	call FlushMatchRuleRowAttrs ; $4813
	ret ; $4816
