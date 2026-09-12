ClearWram3Row64_38:
	push_wram_bank WRAM_SCREEN ; $43db
	xor a ; $43e4
	ld c, $40 ; $43e5
.loop:
	ld [hl+], a ; $43e7
	dec c ; $43e8
	jr nz, .loop ; $43e9
	pop_wram_bank ; $43eb
	ret ; $43f0
ClearWram3Row64Alt_38:
	push_wram_bank WRAM_SCREEN ; $43f1
	ld a, $00 ; $43fa
	ld c, $40 ; $43fc
.loopB:
	ld [hl+], a ; $43fe
	dec c ; $43ff
	jr nz, .loopB ; $4400
	pop_wram_bank ; $4402
	ret ; $4407
UpdateAnimatedTilesTask_38:
	farcall UpdateAnimatedTiles ; $4408
	ret ; $440b
; Instruction-identical to DrawNameWithDiacritics_3b (one copy per bank); a change here belongs in every copy.
	twin draw_name_with_diacritics_38, 38 ; $440c DrawNameWithDiacritics_38
DrawDecimalNumber:
	push af ; $4445
	push bc ; $4446
	push hl ; $4447
	add sp, -10 ; $4448
	push bc ; $444a
	push de ; $444b
	ld c, l ; $444c
	ld b, h ; $444d
	ld hl, sp + 4 ; $444e
	ld e, l ; $4450
	ld d, h ; $4451
	ld l, c ; $4452
	ld h, b ; $4453
	ld c, e ; $4454
	ld b, d ; $4455
	call FormatDecimalNumber ; $4456
	ld l, c ; $4459
	ld h, b ; $445a
	pop de ; $445b
	pop bc ; $445c
	call CopyDecimalStringToTilemap ; $445d
	add sp, 10 ; $4460
	pop hl ; $4462
	pop bc ; $4463
	pop af ; $4464
	ret ; $4465
CopyDecimalStringToTilemap:
	ld a, [hl+] ; $4466
	and a ; $4467
	jr z, .done ; $4468
	call WriteDecimalDigitTile ; $446a
	jr CopyDecimalStringToTilemap ; $446d
.done:
	ret ; $446f
WriteDecimalDigitTile:
	push hl ; $4470
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH ; $4471
	sub $30 ; $4474
	jr c, .skipOperand ; $4476
	add $30 ; $4478
	ld b, a ; $447a
	wram_bank WRAM_SCREEN ; $447b
	ld a, b ; $4481
	ld [de], a ; $4482
	inc de ; $4483
	pop hl ; $4484
	ret ; $4485
.skipOperand:
	inc de ; $4486
	pop hl ; $4487
	ret ; $4488
RunMatchTypeMenu:
	call DisableLCDSafely ; $4489
	farcall LoadMenuFontGfx ; $448c
	call SetupMatchTypeMenuScreen ; $448f
	ld a, $01 ; $4492
	ld hl, DrawMatchTypeOptionBoxes ; $4494
	call RegisterFrameTask ; $4497
	ld a, $01 ; $449a
	ld hl, UpdateAnimatedTilesTask_38 ; $449c
	call RegisterFrameTask ; $449f
	call EnableLCD ; $44a2
	script_fade_in $10 ; $44a5
	call WaitFadeEnd ; $44aa
.inputLoop:
	ldh a, [hInputPressed] ; $44ad
	ld [wMenuInputPressed], a ; $44af
	call AdjustMatchTypeSetting ; $44b2
	ld b, $01 ; $44b5
	ld c, $03 ; $44b7
	call MoveMenuCursorGrid_38 ; $44b9
	or a ; $44bc
	jr z, .adjust ; $44bd
	call RefreshMatchTypeLabelRow ; $44bf
.adjust:
	call AdvanceFrame ; $44c2
	ld a, [wMenuInputPressed] ; $44c5
	bit PADB_A, a ; $44c8
	jr nz, .confirm ; $44ca
	bit 1, a ; $44cc
	jr nz, .done ; $44ce
	jr .inputLoop ; $44d0
.confirm:
	sound SFX_MENU_SELECT ; $44d2
	ld c, $10 ; $44d4
	call BeginFadeOut ; $44d6
	call WaitFadeEnd ; $44d9
	call ClearFrameTasks ; $44dc
	xor a ; $44df
	ret ; $44e0
.done:
	sound SFX_MENU_CANCEL ; $44e1
	ld c, $10 ; $44e3
	call BeginFadeOut ; $44e5
	call WaitFadeEnd ; $44e8
	call ClearFrameTasks ; $44eb
	ld a, $ff ; $44ee
	ret ; $44f0
RunMatchTypeMenuLink:
	xor a ; $44f1
	ldh [hLinkExchangeActive], a ; $44f2
	call ResetSerialState ; $44f4
	call DisableLCDSafely ; $44f7
	call SetupMatchTypeMenuScreen ; $44fa
	ld a, $01 ; $44fd
	ld hl, DrawMatchTypeOptionBoxes ; $44ff
	call RegisterFrameTask ; $4502
	ld a, $01 ; $4505
	ld hl, UpdateAnimatedTilesTask_38 ; $4507
	call RegisterFrameTask ; $450a
	call EnableLCD ; $450d
	farcall ResyncLinkSession ; $4510
	script_fade_in $10 ; $4513
	push af ; $4518
	farcall RunLinkInputFrame ; $4519
	pop af ; $451c
	push af ; $451d
	farcall RunLinkInputFrame ; $451e
	pop af ; $4521
	push af ; $4522
	farcall RunLinkInputFrame ; $4523
	pop af ; $4526
	sound BGM_COURT_WAREHOUSE ; $4527
.inputLoop:
	ldh a, [hLinkInput] ; $4529
	ld [wMenuInputPressed], a ; $452b
	call AdjustMatchTypeSetting ; $452e
	ld b, $01 ; $4531
	ld c, $03 ; $4533
	call MoveMenuCursorGridFromLinkInput_38 ; $4535
	or a ; $4538
	jr z, .adjust ; $4539
	call RefreshMatchTypeLabelRow ; $453b
.adjust:
	push af ; $453e
	farcall RunLinkInputFrame ; $453f
	pop af ; $4542
	ld a, [wMenuInputPressed] ; $4543
	bit PADB_A, a ; $4546
	jr nz, .confirm ; $4548
	bit 1, a ; $454a
	jr nz, .done ; $454c
	jr .inputLoop ; $454e
.confirm:
	sound SFX_MENU_SELECT ; $4550
	push af ; $4552
	farcall SyncLinkFrame ; $4553
	pop af ; $4556
	xor a ; $4557
	ldh [hLinkExchangeActive], a ; $4558
	call ResetSerialState ; $455a
	ld c, $10 ; $455d
	call BeginFadeOut ; $455f
	call WaitFadeEnd ; $4562
	sound BGM_NONE ; $4565
	sound SFX_STOP ; $4567
	call ClearFrameTasks ; $4569
	xor a ; $456c
	ret ; $456d
.done:
	sound SFX_MENU_CANCEL ; $456e
	push af ; $4570
	farcall SyncLinkFrame ; $4571
	pop af ; $4574
	xor a ; $4575
	ldh [hLinkExchangeActive], a ; $4576
	call ResetSerialState ; $4578
	ld c, $10 ; $457b
	call BeginFadeOut ; $457d
	call WaitFadeEnd ; $4580
	sound BGM_NONE ; $4583
	sound SFX_STOP ; $4585
	call ClearFrameTasks ; $4587
	ld a, $ff ; $458a
	ret ; $458c
DrawMatchTypeOptionBoxes:
	ld a, [wMatchFormatDoubles] ; $458d
	add a ; $4590
	ld hl, MatchTypeOptionBoxesTable0 ; $4591
	add l ; $4594
	ld l, a ; $4595
	jr nc, .doublesBox ; $4596
	inc h ; $4598
.doublesBox:
	ld a, [hl+] ; $4599
	ld d, [hl] ; $459a
	ld e, a ; $459b
	ld c, $01 ; $459c
	call GetMenuCursorIndex_38 ; $459e
	or a ; $45a1
	jr z, .drawDoubles ; $45a2
	ld bc, $3010 ; $45a4
	call DrawCornerBrackets_38 ; $45a7
	jr .gamesBox ; $45aa
.drawDoubles:
	ld bc, $3010 ; $45ac
	call DrawSelectedOptionBox ; $45af
.gamesBox:
	ld a, [wMatchFormatGames] ; $45b2
	add a ; $45b5
	ld hl, MatchTypeOptionBoxesTable1 ; $45b6
	add l ; $45b9
	ld l, a ; $45ba
	jr nc, .gamesOption ; $45bb
	inc h ; $45bd
.gamesOption:
	ld a, [hl+] ; $45be
	ld d, [hl] ; $45bf
	ld e, a ; $45c0
	ld c, $01 ; $45c1
	call GetMenuCursorIndex_38 ; $45c3
	cp $01 ; $45c6
	jr z, .drawGames ; $45c8
	ld bc, $3010 ; $45ca
	call DrawCornerBrackets_38 ; $45cd
	jr .setsBox ; $45d0
.drawGames:
	ld bc, $3010 ; $45d2
	call DrawSelectedOptionBox ; $45d5
.setsBox:
	ld a, [wMatchFormatSets] ; $45d8
	add a ; $45db
	ld hl, MatchTypeOptionBoxesTable2 ; $45dc
	add l ; $45df
	ld l, a ; $45e0
	jr nc, .setsOption ; $45e1
	inc h ; $45e3
.setsOption:
	ld a, [hl+] ; $45e4
	ld d, [hl] ; $45e5
	ld e, a ; $45e6
	ld c, $01 ; $45e7
	call GetMenuCursorIndex_38 ; $45e9
	cp $02 ; $45ec
	jr z, .drawSets ; $45ee
	ld bc, $3010 ; $45f0
	call DrawCornerBrackets_38 ; $45f3
	jr .done ; $45f6
.drawSets:
	ld bc, $3010 ; $45f8
	call DrawSelectedOptionBox ; $45fb
.done:
	ret ; $45fe
MatchTypeOptionBoxesTable0:
	; $45ff, 4 bytes (bytes:4)
	db $18, $10, $18, $58 ; 0x00
MatchTypeOptionBoxesTable1:
	; $4603, 4 bytes (bytes:4)
	db $38, $10, $38, $58 ; 0x00
MatchTypeOptionBoxesTable2:
	; $4607, 8 bytes (bytes:8)
	db $58, $08, $58, $38, $58, $68, $c9, $c9 ; 0x00
SetupMatchTypeMenuScreen:
	ld b, $01 ; $460f
	ld a, [wMainMenuCursor] ; $4611
	ld c, a ; $4614
	call SetMenuCursorFromIndex_38 ; $4615
	ld c, SCREENASSET_MatchTypeMenu ; $4618
	farcall LoadScreenAssetRecord ; $461a
	farcall ResetTextWindowState ; $461d
	ld b, TILEBLOCK_SharedMenuGfx17Alias17 ; $4620
	ld c, SharedMenuGfx17_SIZE / 16 ; $4622
	ld de, vTiles2 ; $4624
	farcall LoadCompressedTileBlock ; $4627
	wram_bank WRAM_TEXT ; $462a
	ld a, $03 ; $4630
	ld [wShadowTilemapBank], a ; $4632
	ld a, $00 ; $4635
	ld [wWindowTileAttr], a ; $4637
	ld d, $00 ; $463a
	ld e, $0f ; $463c
	ld b, $14 ; $463e
	ld c, $03 ; $4640
	farcall CreateWindowFromScreenRect ; $4642
	farcall DrawTextWindowFrame ; $4645
	farcall RedrawWindowRows ; $4648
	call DrawMatchTypeOptionLabel ; $464b
	farcall QueueWram3MapToVRAM ; $464e
	ld de, $8000 + VRAM_BANK1 ; $4651
	farcall LoadFixedTileBlockAndPalette ; $4654
	ld b, $08 ; $4657
	ld c, $0d ; $4659
	farcall LoadIndexedPalette ; $465b
	ld b, $09 ; $465e
	ld c, $0e ; $4660
	farcall LoadIndexedPalette ; $4662
	ret ; $4665
RefreshMatchTypeLabelRow:
	sound SFX_MENU_MOVE ; $4666
	wram_bank WRAM_SCREEN ; $4668
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH + 1 ; $466e
	ld b, $12 ; $4671
	ld c, $01 ; $4673
	ld h, $03 ; $4675
	farcall FillTilemapRect ; $4677
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $467a
	ld b, $12 ; $467d
	ld c, $01 ; $467f
	ld h, $20 ; $4681
	farcall FillTilemapRect ; $4683
	call DrawMatchTypeOptionLabel ; $4686
	ld hl, wShadowTilemap + 15 * TILEMAP_WIDTH ; $4689
	ld de, vBGMap0 + 15 * TILEMAP_WIDTH ; $468c
	ld c, $04 ; $468f
	call QueueVRAMCopy ; $4691
	ret ; $4694
MatchTypeLabelSpriteLayouts:
	INCBIN "data/bank_038/MatchTypeLabelSpriteLayouts.bin" ; $4695, 141 bytes
DrawMatchTypeOptionLabel:
	wram_bank WRAM_SCREEN ; $4722
	ld c, $01 ; $4728
	call GetMenuCursorIndex_38 ; $472a
	ld b, a ; $472d
	add a ; $472e
	ld hl, MatchTypeOptionLabelTable ; $472f
	add l ; $4732
	ld l, a ; $4733
	jr nc, .read ; $4734
	inc h ; $4736
.read:
	ld a, [hl+] ; $4737
	ld d, [hl] ; $4738
	ld e, a ; $4739
	ld a, b ; $473a
	ld hl, $0084 ; $473b
	add l ; $473e
	ld l, a ; $473f
	jr nc, .render ; $4740
	inc h ; $4742
.render:
	ld c, $20 ; $4743
	farcall RenderTextToBuffer64 ; $4745
	ret ; $4748
MatchTypeOptionLabelTable:
	; $4749, 6 bytes (bytes:6)
	db $01, $d2, $02, $d2, $02, $d2 ; 0x00
AdjustMatchTypeSetting:
	ld a, [wMenuInputPressed] ; $474f
	bit PADB_LEFT, a ; $4752
	jr nz, .decrease ; $4754
	bit 4, a ; $4756
	jr nz, .increase ; $4758
	ret ; $475a
.decrease:
	sound SFX_MENU_MOVE ; $475b
	ld c, $01 ; $475d
	call GetMenuCursorIndex_38 ; $475f
	or a ; $4762
	jr nz, .decGames ; $4763
	ld a, [wMatchFormatDoubles] ; $4765
	xor $01 ; $4768
	ld [wMatchFormatDoubles], a ; $476a
	ret ; $476d
.decGames:
	cp $01 ; $476e
	jr nz, .decSets ; $4770
	ld a, [wMatchFormatGames] ; $4772
	xor $01 ; $4775
	ld [wMatchFormatGames], a ; $4777
	ret ; $477a
.decSets:
	ld a, [wMatchFormatSets] ; $477b
	dec a ; $477e
	add a ; $477f
	jr nc, .decCheckMax ; $4780
	ld a, $03 ; $4782
	dec a ; $4784
	jr .storeDecSets ; $4785
.decCheckMax:
	rra ; $4787
	cp $03 ; $4788
	jr c, .storeDecSets ; $478a
	xor a ; $478c
.storeDecSets:
	ld [wMatchFormatSets], a ; $478d
	ret ; $4790
.increase:
	sound SFX_MENU_MOVE ; $4791
	ld c, $01 ; $4793
	call GetMenuCursorIndex_38 ; $4795
	or a ; $4798
	jr nz, .incGames ; $4799
	ld a, [wMatchFormatDoubles] ; $479b
	xor $01 ; $479e
	ld [wMatchFormatDoubles], a ; $47a0
	ret ; $47a3
.incGames:
	cp $01 ; $47a4
	jr nz, .incSets ; $47a6
	ld a, [wMatchFormatGames] ; $47a8
	xor $01 ; $47ab
	ld [wMatchFormatGames], a ; $47ad
	ret ; $47b0
.incSets:
	ld a, [wMatchFormatSets] ; $47b1
	inc a ; $47b4
	add a ; $47b5
	jr nc, .incCheckMax ; $47b6
	ld a, $03 ; $47b8
	dec a ; $47ba
	jr .storeIncSets ; $47bb
.incCheckMax:
	rra ; $47bd
	cp $03 ; $47be
	jr c, .storeIncSets ; $47c0
	xor a ; $47c2
.storeIncSets:
	ld [wMatchFormatSets], a ; $47c3
	ret ; $47c6
