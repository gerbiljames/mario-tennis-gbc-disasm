SaveQuitMenuIdByGameMode:
	; $44f3, 11 bytes (bytes:1)
	db $0d ; 0x00
	db $05 ; 0x01
	db $05 ; 0x02
	db $05 ; 0x03
	db $06 ; 0x04
	db $07 ; 0x05
	db $09 ; 0x06
	db $0a ; 0x07
	db $0b ; 0x08
	db $0c ; 0x09
	db $05 ; 0x0a
ShowMessageWindow:
	push af ; $44fe
	push bc ; $44ff
	push de ; $4500
	push hl ; $4501
	push_wram_bank WRAM_COURT_PLANES ; $4502
	ld a, $01 ; $450b
	ld [wMatchSimFrozen], a ; $450d
	farcall StepMatchFrame ; $4510
	push bc ; $4513
	push de ; $4514
	push hl ; $4515
	push bc ; $4516
	push de ; $4517
	call GetShadowAttrmapAddr ; $4518
	ld c, e ; $451b
	ld b, d ; $451c
	pop de ; $451d
	call GetShadowTilemapAddr ; $451e
	pop hl ; $4521
	call DrawWindowFramePriority ; $4522
	pop hl ; $4525
	pop de ; $4526
	pop bc ; $4527
	farcall PrepareGlyphBuffer ; $4528
	push hl ; $452b
	inc d ; $452c
	inc e ; $452d
	call GetShadowTilemapAddr ; $452e
	ld c, b ; $4531
	dec c ; $4532
	dec c ; $4533
	pop hl ; $4534
	farcall RenderProportionalTextAt ; $4535
	farcall UploadGlyphBuffer ; $4538
	call FlushTilemapToVram ; $453b
	ld a, $1e ; $453e
	farcall StepMatchFrames ; $4540
.waitInput:
	farcall StepMatchFrame ; $4543
	farcall ReadMatchInputPressed ; $4546
	and $0f ; $4549
	jr z, .waitInput ; $454b
	call RestoreBgTilemap ; $454d
	call FlushTilemapToVram ; $4550
	farcall StepMatchFrame ; $4553
	xor a ; $4556
	ld [wMatchSimFrozen], a ; $4557
	pop_wram_bank ; $455a
	pop hl ; $455f
	pop de ; $4560
	pop bc ; $4561
	pop af ; $4562
	ret ; $4563
DrawWindowFrameAt:
	push bc ; $4564
	push de ; $4565
	call GetShadowAttrmapAddr ; $4566
	ld c, e ; $4569
	ld b, d ; $456a
	pop de ; $456b
	call GetShadowTilemapAddr ; $456c
	pop hl ; $456f
	call DrawWindowFrameNoPriority ; $4570
	ret ; $4573
DrawMenuTextLine:
	push de ; $4574
	push hl ; $4575
	push hl ; $4576
	call GetShadowTilemapAddr ; $4577
	pop hl ; $457a
	call RenderProportionalMenuText ; $457b
	pop hl ; $457e
	pop de ; $457f
	inc hl ; $4580
	inc e ; $4581
	inc e ; $4582
	ret ; $4583
DrawMenuCaptionWindow:
	push hl ; $4584
	push de ; $4585
	call GetShadowAttrmapAddr ; $4586
	ld c, e ; $4589
	ld b, d ; $458a
	pop de ; $458b
	push de ; $458c
	call GetShadowTilemapAddr ; $458d
	ld hl, $1303 ; $4590
	ld a, $01 ; $4593
	ld [wWindowFrameAttr], a ; $4595
	call DrawWindowFrame ; $4598
	pop de ; $459b
	ld hl, $0101 ; $459c
	add hl, de ; $459f
	ld e, l ; $45a0
	ld d, h ; $45a1
	call GetShadowTilemapAddr ; $45a2
	pop hl ; $45a5
	call RenderProportionalMenuText ; $45a6
	ret ; $45a9
RestoreBgTilemap:
	ld hl, wCourtTilemapSaved ; $45aa
	ld de, wCourtTilemap ; $45ad
	ld c, $40 ; $45b0
	call CopyMemoryFast ; $45b2
	ld hl, wCourtAttrmapSaved ; $45b5
	ld de, wCourtAttrmap ; $45b8
	ld c, $40 ; $45bb
	call CopyMemoryFast ; $45bd
	ret ; $45c0
RestoreBgTilemapRegion:
	ld e, $0a ; $45c1
	call GetScrolledTilemapRowOffset ; $45c3
	ld c, l ; $45c6
	ld b, h ; $45c7
	push bc ; $45c8
	ld hl, wCourtTilemap ; $45c9
	add hl, bc ; $45cc
	ld e, l ; $45cd
	ld d, h ; $45ce
	ld hl, wCourtTilemapSaved ; $45cf
	add hl, bc ; $45d2
	ld c, $0e ; $45d3
	call CopyMemoryFast ; $45d5
	pop bc ; $45d8
	ld hl, wCourtAttrmap ; $45d9
	add hl, bc ; $45dc
	ld e, l ; $45dd
	ld d, h ; $45de
	ld hl, wCourtAttrmapSaved ; $45df
	add hl, bc ; $45e2
	ld c, $0e ; $45e3
	call CopyMemoryFast ; $45e5
	ret ; $45e8
ClearAttrPriorityRegion:
	ld a, [hl] ; $45e9
	and $7f ; $45ea
	ld [hl+], a ; $45ec
	dec bc ; $45ed
	ld a, b ; $45ee
	or c ; $45ef
	jr nz, ClearAttrPriorityRegion ; $45f0
	ret ; $45f2
FlushTilemapToVramIfDirty:
	ld a, [wTilemapDirtyFlag] ; $45f3
	and a ; $45f6
	ret z ; $45f7
FlushTilemapToVram:
	xor a ; $45f8
	ld [wTilemapDirtyFlag], a ; $45f9
	ld e, $00 ; $45fc
	call GetScrolledTilemapRowOffset ; $45fe
	ld c, l ; $4601
	ld b, h ; $4602
	push bc ; $4603
	ld hl, vBGMap0 ; $4604
	add hl, bc ; $4607
	ld e, l ; $4608
	ld d, h ; $4609
	ld hl, wCourtTilemap ; $460a
	add hl, bc ; $460d
	ld c, $22 ; $460e
	call QueueVRAMCopy ; $4610
	pop bc ; $4613
	ld hl, vBGMap0 + VRAM_BANK1 ; $4614
	add hl, bc ; $4617
	ld e, l ; $4618
	ld d, h ; $4619
	ld hl, wCourtAttrmap ; $461a
	add hl, bc ; $461d
	ld c, $22 ; $461e
	call QueueVRAMCopy ; $4620
	ret ; $4623
GetShadowTilemapAddr:
	call GetScrolledTilemapOffset ; $4624
	ld de, wActiveTilemap ; $4627
	add hl, de ; $462a
	ld e, l ; $462b
	ld d, h ; $462c
	ret ; $462d
GetShadowAttrmapAddr:
	call GetScrolledTilemapOffset ; $462e
	ld de, wActiveAttrmap ; $4631
	add hl, de ; $4634
	ld e, l ; $4635
	ld d, h ; $4636
	ret ; $4637
GetScrolledTilemapOffset:
	call GetScrolledTilemapRowOffset ; $4638
	ldh a, [hScrollX] ; $463b
	add $07 ; $463d
	rrca ; $463f
	rrca ; $4640
	rrca ; $4641
	add d ; $4642
	and $1f ; $4643
	add l ; $4645
	ld l, a ; $4646
	jr nc, .done ; $4647
	inc h ; $4649
.done:
	ret ; $464a
GetScrolledTilemapRowOffset:
	ldh a, [hScrollY] ; $464b
	add $07 ; $464d
	rrca ; $464f
	rrca ; $4650
	rrca ; $4651
	add e ; $4652
	and $1f ; $4653
	ld l, a ; $4655
	ld h, $00 ; $4656
	add hl, hl ; $4658
	add hl, hl ; $4659
	add hl, hl ; $465a
	add hl, hl ; $465b
	add hl, hl ; $465c
	ret ; $465d
AdjustSpriteCoordsForScroll:
	ldh a, [hScrollX] ; $465e
	cpl ; $4660
	inc a ; $4661
	and $07 ; $4662
	add d ; $4664
	ld d, a ; $4665
	ldh a, [hScrollY] ; $4666
	cpl ; $4668
	inc a ; $4669
	and $07 ; $466a
	add e ; $466c
	ld e, a ; $466d
	ret ; $466e
MatchMenuDefs:
	; $466f, 120 bytes (menu_def:MATCHMENUITEM)
	menu_def MATCHMENUITEM_RULES, MATCHMENUITEM_CONTROLS, MATCHMENUITEM_OPTIONS, MATCHMENUITEM_SAVE ; menu 0
	menu_def MATCHMENUITEM_RULES, MATCHMENUITEM_CONTROLS, MATCHMENUITEM_MUSIC, MATCHMENUITEM_SAVE ; menu 1
	menu_def MATCHMENUITEM_CAMERA_MODE, MATCHMENUITEM_MUSIC ; menu 2
	menu_def MATCHMENUITEM_CAMERA_NORMAL, MATCHMENUITEM_CAMERA_PLAYER ; menu 3
	menu_def MATCHMENUITEM_MUSIC_ON, MATCHMENUITEM_MUSIC_OFF ; menu 4
	menu_def MATCHMENUITEM_SAVE_GAME, MATCHMENUITEM_QUIT_GAME, MATCHMENUITEM_CANCEL ; menu 5
	menu_def MATCHMENUITEM_SAVE_GAME, MATCHMENUITEM_TO_MAIN_MENU, MATCHMENUITEM_CANCEL ; menu 6
	menu_def MATCHMENUITEM_RETRY_MINIGAME, MATCHMENUITEM_QUIT_MATCH, MATCHMENUITEM_CANCEL ; menu 7
	menu_def MATCHMENUITEM_RETRY_PRACTICE, MATCHMENUITEM_QUIT_PRACTICE, MATCHMENUITEM_CANCEL ; menu 8
	menu_def MATCHMENUITEM_RETRY_MACHINE, MATCHMENUITEM_QUIT_MACHINE, MATCHMENUITEM_CANCEL ; menu 9
	menu_def MATCHMENUITEM_RETRY_PRACTICE_ALT, MATCHMENUITEM_QUIT_PRACTICE_ALT, MATCHMENUITEM_CANCEL ; menu 10
	menu_def MATCHMENUITEM_RETRY_GAME, MATCHMENUITEM_TO_LEVEL_SELECT, MATCHMENUITEM_TO_MAIN_MENU, MATCHMENUITEM_CANCEL ; menu 11
	menu_def MATCHMENUITEM_TO_MAIN_MENU, MATCHMENUITEM_CANCEL ; menu 12
	menu_def MATCHMENUITEM_SAVE_GAME, MATCHMENUITEM_TO_MAIN_MENU, MATCHMENUITEM_CANCEL ; menu 13
	menu_def MATCHMENUITEM_RETRY_GAME, MATCHMENUITEM_TO_LEVEL_SELECT, MATCHMENUITEM_TO_MAIN_MENU ; menu 14
RunMatchMenu:
	call GetMatchMenuItemCount ; $46e7
	ld [wPauseMenuItemCount], a ; $46ea
	call DrawMatchMenuItems ; $46ed
	ld e, $0c ; $46f0
	call GetScrolledTilemapRowOffset ; $46f2
	ld de, wCourtAttrmap ; $46f5
	add hl, de ; $46f8
	ld bc, $0040 ; $46f9
	call ClearAttrPriorityRegion ; $46fc
	jr .redraw ; $46ff
.inputLoop:
	farcall ReadMatchInputPressed ; $4701
	and $0a ; $4704
	jr z, .checkA ; $4706
	sound SFX_MENU_CANCEL ; $4708
	ld a, MATCHMENUSEL_CANCELLED ; $470a
	ld [wMatchMenuSelection], a ; $470c
	jr .done ; $470f
.checkA:
	farcall ReadMatchInputPressed ; $4711
	and $01 ; $4714
	jr z, .checkLeftRight ; $4716
	sound SFX_MENU_SELECT ; $4718
	jr .done ; $471a
.checkLeftRight:
	farcall ReadMatchInputRepeat ; $471c
	and $30 ; $471f
	jr z, .drawCursor ; $4721
	ld b, a ; $4723
	ld a, [wPauseMenuItemCount] ; $4724
	ld c, a ; $4727
	ld a, [wMatchMenuSelection] ; $4728
	call MoveCursorHorizontal ; $472b
	ld [wMatchMenuSelection], a ; $472e
	sound SFX_MENU_MOVE ; $4731
.redraw:
	farcall PrepareGlyphBuffer ; $4733
	ld hl, wGlyphPenX ; $4736
	ld de, $2000 ; $4739
	ld a, e ; $473c
	ld [hl+], a ; $473d
	ld [hl], d ; $473e
	ld a, $40 ; $473f
	ld hl, wTextRowColumn ; $4741
	ld [hl+], a ; $4744
	ld [hl+], a ; $4745
	ld [hl+], a ; $4746
	ld a, [wMatchMenuSelection] ; $4747
	call GetMatchMenuItemId ; $474a
	push af ; $474d
	call LoadMatchMenuItemGfx ; $474e
	pop af ; $4751
	add $3f ; $4752
	ld l, a ; $4754
	adc $01 ; $4755
	sub l ; $4757
	ld h, a ; $4758
	ld de, $000e ; $4759
	call DrawMenuCaptionWindow ; $475c
	call DrawScoreboardCaption ; $475f
	farcall UploadGlyphBuffer ; $4762
	farcall StepMatchFrame ; $4765
	call FlushTilemapToVram ; $4768
	farcall StepMatchFrame ; $476b
.drawCursor:
	call DrawMatchMenuCursor ; $476e
	farcall StepMatchFrame ; $4771
	jr .inputLoop ; $4774
.done:
	farcall StepMatchFrame ; $4776
	ret ; $4779
DrawScoreboardCaption:
	ld a, [wScoreboardLayout] ; $477a
	rst Rst00 ; $477d
	dw ScoreboardCaption_SetGamePoint ; $477e jumptable
	dw ScoreboardCaption_SetGamePoint ; $4780 jumptable
	dw ScoreboardCaption_SetGamePoint ; $4782 jumptable
	dw ScoreboardCaption_Total ; $4784 jumptable
	dw ScoreboardCaption_Total ; $4786 jumptable
	dw ScoreboardCaption_Total ; $4788 jumptable
	dw ScoreboardCaption_ScoreTarget ; $478a jumptable
	dw ScoreboardCaption_ScoreHigh ; $478c jumptable
ScoreboardCaption_SetGamePoint:
	ld hl, wScoreboardOrigin ; $478e
	ld a, [hl+] ; $4791
	ld b, [hl] ; $4792
	ld c, a ; $4793
	ld hl, $0701 ; $4794
	add hl, bc ; $4797
	ld e, l ; $4798
	ld d, h ; $4799
	ld hl, Text_30_346 ; $479a
	call DrawMenuTextLine ; $479d
	ret ; $47a0
ScoreboardCaption_Total:
	ld hl, wScoreboardOrigin ; $47a1
	ld a, [hl+] ; $47a4
	ld b, [hl] ; $47a5
	ld c, a ; $47a6
	ld hl, $0e01 ; $47a7
	add hl, bc ; $47aa
	ld e, l ; $47ab
	ld d, h ; $47ac
	ld hl, Text_30_347 ; $47ad
	call DrawMenuTextLine ; $47b0
	ret ; $47b3
ScoreboardCaption_ScoreTarget:
	ld hl, wScoreboardOrigin ; $47b4
	ld a, [hl+] ; $47b7
	ld b, [hl] ; $47b8
	ld c, a ; $47b9
	ld hl, $0502 ; $47ba
	add hl, bc ; $47bd
	ld e, l ; $47be
	ld d, h ; $47bf
	ld hl, Text_30_348 ; $47c0
	call DrawMenuTextLine ; $47c3
	ld hl, $0304 ; $47c6
	add hl, bc ; $47c9
	ld e, l ; $47ca
	ld d, h ; $47cb
	ld hl, Text_30_349 ; $47cc
	call DrawMenuTextLine ; $47cf
	ld hl, $0505 ; $47d2
	add hl, bc ; $47d5
	ld e, l ; $47d6
	ld d, h ; $47d7
	ld hl, Text_30_348 ; $47d8
	call DrawMenuTextLine ; $47db
	ret ; $47de
ScoreboardCaption_ScoreHigh:
	ld hl, wScoreboardOrigin ; $47df
	ld a, [hl+] ; $47e2
	ld b, [hl] ; $47e3
	ld c, a ; $47e4
	ld hl, $0502 ; $47e5
	add hl, bc ; $47e8
	ld e, l ; $47e9
	ld d, h ; $47ea
	ld hl, Text_30_348 ; $47eb
	call DrawMenuTextLine ; $47ee
	ld hl, $0404 ; $47f1
	add hl, bc ; $47f4
	ld e, l ; $47f5
	ld d, h ; $47f6
	ld hl, Text_30_350 ; $47f7
	call DrawMenuTextLine ; $47fa
	ld hl, $0505 ; $47fd
	add hl, bc ; $4800
	ld e, l ; $4801
	ld d, h ; $4802
	ld hl, Text_30_348 ; $4803
	call DrawMenuTextLine ; $4806
	ret ; $4809
GetMatchMenuItemId:
	ld b, a ; $480a
	ld a, [wPauseMenuId] ; $480b
	add a ; $480e
	add a ; $480f
	add a ; $4810
	ld_hl_indexed MatchMenuDefs ; $4811
	ld a, b ; $4818
	add l ; $4819
	ld l, a ; $481a
	jr nc, .read ; $481b
	inc h ; $481d
.read:
	ld a, [hl] ; $481e
	ret ; $481f
GetMatchMenuItemCount:
	ld a, [wPauseMenuId] ; $4820
	add a ; $4823
	add a ; $4824
	add a ; $4825
	ld_hl_indexed MatchMenuDefs + 4 ; $4826
	ld a, [hl] ; $482d
	ret ; $482e
DrawMatchMenuItems:
	ld a, [wPauseMenuItemCount] ; $482f
	add a ; $4832
	ld_hl_indexed MatchMenuItemPosPointers ; $4833
	ld a, [hl+] ; $483a
	ld h, [hl] ; $483b
	ld l, a ; $483c
	ld a, [wPauseMenuItemCount] ; $483d
	ld c, a ; $4840
	ld b, $00 ; $4841
.loop:
	ld a, [hl+] ; $4843
	ld e, a ; $4844
	ld a, [hl+] ; $4845
	ld d, a ; $4846
	push bc ; $4847
	push hl ; $4848
	ld a, b ; $4849
	call GetMatchMenuItemId ; $484a
	call DrawMatchMenuItem ; $484d
	pop hl ; $4850
	pop bc ; $4851
	inc b ; $4852
	dec c ; $4853
	jr nz, .loop ; $4854
	ret ; $4856
MatchMenuItemPosPointers:
	; $4857, 10 bytes (records:2)
	dw MatchMenuItemPos2Items ; record 0
	dw MatchMenuItemPos2Items ; record 1
	dw MatchMenuItemPos2Items ; record 2
	dw MatchMenuItemPos3Items ; record 3
	dw MatchMenuItemPos4Items ; record 4
MatchMenuItemPos2Items:
	; $4861, 4 bytes (bytes:2)
	db $0a, $05 ; 0x00
	db $0a, $0b ; 0x02
MatchMenuItemPos3Items:
	; $4865, 6 bytes (bytes:2)
	db $0a, $04 ; 0x00
	db $0a, $08 ; 0x02
	db $0a, $0c ; 0x04
MatchMenuItemPos4Items:
	; $486b, 8 bytes (bytes:2)
	db $0a, $03 ; 0x00
	db $0a, $06 ; 0x02
	db $0a, $09 ; 0x04
	db $0a, $0c ; 0x06
DrawMatchMenuCursor:
	ld a, [wPauseMenuItemCount] ; $4873
	add a ; $4876
	ld_hl_indexed MatchMenuCursorPosPointers ; $4877
	ld a, [hl+] ; $487e
	ld h, [hl] ; $487f
	ld l, a ; $4880
	ld a, [wMatchMenuSelection] ; $4881
	add a ; $4884
	add l ; $4885
	ld l, a ; $4886
	jr nc, .read ; $4887
	inc h ; $4889
.read:
	ld a, [hl+] ; $488a
	ld d, [hl] ; $488b
	ld e, a ; $488c
	call QueueMatchMenuCursorSprite ; $488d
	ret ; $4890
MatchMenuCursorPosPointers:
	; $4891, 10 bytes (records:2)
	dw MatchMenuCursorPos2Items ; record 0
	dw MatchMenuCursorPos2Items ; record 1
	dw MatchMenuCursorPos2Items ; record 2
	dw MatchMenuCursorPos3Items ; record 3
	dw MatchMenuCursorPos4Items ; record 4
MatchMenuCursorPos2Items:
	; $489b, 4 bytes (bytes:2)
	db $60, $18 ; 0x00
	db $60, $48 ; 0x02
MatchMenuCursorPos3Items:
	; $489f, 6 bytes (bytes:2)
	db $60, $10 ; 0x00
	db $60, $30 ; 0x02
	db $60, $50 ; 0x04
MatchMenuCursorPos4Items:
	; $48a5, 8 bytes (bytes:2)
	db $60, $08 ; 0x00
	db $60, $20 ; 0x02
	db $60, $38 ; 0x04
	db $60, $50 ; 0x06
ShowMatchScoreboardScreen:
	ldh a, [hWramBank] ; $48ad
	push af ; $48af
	farcall StepMatchFrame ; $48b0
	call PrepareScoreboardGfx ; $48b3
	farcall StepMatchFrame ; $48b6
	ld a, $05 ; $48b9
	ld [wScoreboardOrigin], a ; $48bb
	call LoadScoreboardModeGfx ; $48be
	ld b, $01 ; $48c1
	call DrawScoreboard ; $48c3
	farcall PrepareGlyphBuffer ; $48c6
	call DrawScoreboardCaption ; $48c9
	farcall UploadGlyphBuffer ; $48cc
	ld a, $0a ; $48cf
	ld hl, DrawScoreboardSprites ; $48d1
	call RegisterFrameTask ; $48d4
	ld a, $0a ; $48d7
	ld hl, DrawScoreboardModeTitle ; $48d9
	call RegisterFrameTask ; $48dc
	farcall StepMatchFrame ; $48df
	call FlushTilemapToVram ; $48e2
	farcall StepMatchFrame ; $48e5
	wram_bank WRAM_COURT_PLANES ; $48e8
.loop:
	farcall ReadMatchInputPressed ; $48ee
	and $0f ; $48f1
	jr nz, .maskSet ; $48f3
	farcall StepMatchFrame ; $48f5
	jr .loop ; $48f8
.maskSet:
	ld hl, DrawScoreboardSprites ; $48fa
	call UnregisterFrameTask ; $48fd
	ld hl, DrawScoreboardModeTitle ; $4900
	call UnregisterFrameTask ; $4903
	call RestoreBgTilemap ; $4906
	call FlushTilemapToVram ; $4909
	farcall StepMatchFrame ; $490c
	pop_wram_bank ; $490f
	ret ; $4914
