HexDigitChars_05:
	INCBIN "data/bank_005/HexDigitChars_05.bin" ; $6488, 16 bytes
DebugDrawHexRowLabel:
	push af ; $6498
	push bc ; $6499
	push de ; $649a
	push hl ; $649b
	ld hl, HexDigitChars_05 ; $649c
	swap a ; $649f
	and $0f ; $64a1
	add l ; $64a3
	ld l, a ; $64a4
	jr nc, .writeCell ; $64a5
	inc h ; $64a7
.writeCell:
	ld c, [hl] ; $64a8
	ld a, b ; $64a9
	ld b, $80 ; $64aa
	call WriteWindowCellTileAttr ; $64ac
	inc d ; $64af
	ld c, $3f ; $64b0
	call WriteWindowCellTileAttr ; $64b2
	pop hl ; $64b5
	pop de ; $64b6
	pop bc ; $64b7
	pop af ; $64b8
	ret ; $64b9
DebugDrawFlagBitRow:
	push af ; $64ba
	push bc ; $64bb
	push de ; $64bc
	push hl ; $64bd
	ld l, a ; $64be
	ld h, $00 ; $64bf
	ld c, $08 ; $64c1
.bitLoop:
	push de ; $64c3
	ld e, l ; $64c4
	ld d, h ; $64c5
	call TestGameFlagByNumber ; $64c6
	pop de ; $64c9
	push bc ; $64ca
	ld c, $65 ; $64cb
	jr z, .writeCell ; $64cd
	ld c, $40 ; $64cf
.writeCell:
	ld a, b ; $64d1
	ld b, $80 ; $64d2
	call WriteWindowCellTileAttr ; $64d4
	inc hl ; $64d7
	inc d ; $64d8
	inc d ; $64d9
	pop bc ; $64da
	dec c ; $64db
	jr nz, .bitLoop ; $64dc
	pop hl ; $64de
	pop de ; $64df
	pop bc ; $64e0
	pop af ; $64e1
	ret ; $64e2
DebugDrawFlagCursor:
	push af ; $64e3
	push bc ; $64e4
	push de ; $64e5
	push hl ; $64e6
	ld a, [wDebugFlagBit] ; $64e7
	add a ; $64ea
	add $03 ; $64eb
	ld d, a ; $64ed
	ld a, [wDebugFlagByte] ; $64ee
	and $03 ; $64f1
	add $01 ; $64f3
	cp $03 ; $64f5
	jr c, .lt03 ; $64f7
	inc a ; $64f9
.lt03:
	ld e, a ; $64fa
	ld hl, wDebugFlagWindow1Id ; $64fb
	ld a, [wDebugFlagByte] ; $64fe
	bit 2, a ; $6501
	jr z, .read ; $6503
	ld hl, wDebugFlagWindow2Id ; $6505
.read:
	ld a, [hl] ; $6508
	ld bc, $800d ; $6509
	call WriteWindowCellTileAttr ; $650c
	pop hl ; $650f
	pop de ; $6510
	pop bc ; $6511
	pop af ; $6512
	ret ; $6513
DebugEraseFlagCursor:
	push af ; $6514
	push bc ; $6515
	push de ; $6516
	push hl ; $6517
	ld a, [wDebugFlagBit] ; $6518
	add a ; $651b
	add $03 ; $651c
	ld d, a ; $651e
	ld a, [wDebugFlagByte] ; $651f
	and $03 ; $6522
	add $01 ; $6524
	cp $03 ; $6526
	jr c, .lt03 ; $6528
	inc a ; $652a
.lt03:
	ld e, a ; $652b
	ld hl, wDebugFlagWindow1Id ; $652c
	ld a, [wDebugFlagByte] ; $652f
	bit 2, a ; $6532
	jr z, .read ; $6534
	ld hl, wDebugFlagWindow2Id ; $6536
.read:
	ld a, [hl] ; $6539
	ld b, $80 ; $653a
	ld c, $20 ; $653c
	call WriteWindowCellTileAttr ; $653e
	pop hl ; $6541
	pop de ; $6542
	pop bc ; $6543
	pop af ; $6544
	ret ; $6545
DebugMoveFlagCursor:
	push af ; $6546
	push bc ; $6547
	push de ; $6548
	push hl ; $6549
	ld a, [wDebugFlagBit] ; $654a
	ld d, a ; $654d
	ld a, [wDebugFlagByte] ; $654e
	ld e, a ; $6551
	ldh a, [hPlayerInputFlags] ; $6552
	bit PADB_LEFT, a ; $6554
	jr nz, .next ; $6556
	bit 4, a ; $6558
	jr nz, .bit4Set ; $655a
	bit 6, a ; $655c
	jr nz, .bit6Set ; $655e
	bit 7, a ; $6560
	jr nz, .negative ; $6562
	jr .step5 ; $6564
.next:
	dec d ; $6566
	jr .step5 ; $6567
.bit4Set:
	inc d ; $6569
	jr .step5 ; $656a
.bit6Set:
	dec e ; $656c
	jr .step5 ; $656d
.negative:
	inc e ; $656f
.step5:
	ld a, d ; $6570
	and $07 ; $6571
	ld [wDebugFlagBit], a ; $6573
	ld a, e ; $6576
	and $07 ; $6577
	ld [wDebugFlagByte], a ; $6579
	pop hl ; $657c
	pop de ; $657d
	pop bc ; $657e
	pop af ; $657f
	ret ; $6580
StubNop_05_3:
	ret ; $6581
HexDigitHeaderRow0_05:
	; $6582, 16 bytes (ascii)
	db "0 1 2 3 4 5 6 7", $00
HexDigitHeaderRow1_05:
	; $6592, 16 bytes (ascii)
	db "8 9 A B C D E F", $00
RunDebugFlagEditor:
	push af ; $65a2
	push bc ; $65a3
	push de ; $65a4
	push hl ; $65a5
	test_flag FLAG_DEBUG_FLAG_EDITOR_OPEN ; $65a6
	jr z, .notDebugFlagEditorOpen ; $65a9
	set_flag FLAG_DEBUG_FLAG_EDITOR_OPEN ; $65ab
	xor a ; $65ae
	ld [wDebugFlagBit], a ; $65af
	ld [wDebugFlagByte], a ; $65b2
	ld [wDebugFlagPage], a ; $65b5
.notDebugFlagEditorOpen:
	ld_cell de, $00, $00 ; $65b8
	ld_size bc, $14, $04 ; $65bb
	call CreateWindow ; $65be
	ld [wDebugFlagHeaderWindowId], a ; $65c1
	call DrawTextWindowFrame ; $65c4
	ld hl, HexDigitHeaderRow0_05 ; $65c7
	ld_cell de, $04, $01 ; $65ca
	call WriteStringToWindow ; $65cd
	ld hl, HexDigitHeaderRow1_05 ; $65d0
	ld_cell de, $04, $02 ; $65d3
	call WriteStringToWindow ; $65d6
	ld_cell de, $00, $04 ; $65d9
	ld_size bc, $14, $07 ; $65dc
	call CreateWindow ; $65df
	ld [wDebugFlagWindow1Id], a ; $65e2
	call DrawTextWindowFrame ; $65e5
	ld_cell de, $00, $0b ; $65e8
	ld_size bc, $14, $07 ; $65eb
	call CreateWindow ; $65ee
	ld [wDebugFlagWindow2Id], a ; $65f1
	call DrawTextWindowFrame ; $65f4
	call DebugDrawFlagsWindow1 ; $65f7
	call DebugDrawFlagsWindow2 ; $65fa
	call DebugDrawFlagCursor ; $65fd
	ld a, [wDebugFlagHeaderWindowId] ; $6600
	call RedrawWindowRows ; $6603
	ld a, [wDebugFlagWindow1Id] ; $6606
	call RedrawWindowRows ; $6609
	ld a, [wDebugFlagWindow2Id] ; $660c
	call RedrawWindowRows ; $660f
	ld a, $0f ; $6612
	ld hl, StubNop_05_3 ; $6614
	call RegisterFrameTask ; $6617
.loop:
	ldh a, [hInputRisingEdge] ; $661a
	bit PADB_B, a ; $661c
	jr nz, .closeWindow ; $661e
	ldh a, [hInputRisingEdge] ; $6620
	bit PADB_A, a ; $6622
	jr z, .checkInputRisingEdge ; $6624
	call DebugToggleSelectedFlag ; $6626
	call DebugDrawFlagsWindow1 ; $6629
	call DebugDrawFlagsWindow2 ; $662c
	ld a, [wDebugFlagWindow1Id] ; $662f
	call RedrawWindowRows ; $6632
	ld a, [wDebugFlagWindow2Id] ; $6635
	call RedrawWindowRows ; $6638
.checkInputRisingEdge:
	ldh a, [hInputRisingEdge] ; $663b
	bit PADB_START, a ; $663d
	jr z, .checkPlayerInputFlags ; $663f
	ld a, [wDebugFlagPage] ; $6641
	inc a ; $6644
	and $03 ; $6645
	ld [wDebugFlagPage], a ; $6647
	call DebugDrawFlagsWindow1 ; $664a
	call DebugDrawFlagsWindow2 ; $664d
	ld a, [wDebugFlagWindow1Id] ; $6650
	call RedrawWindowRows ; $6653
	ld a, [wDebugFlagWindow2Id] ; $6656
	call RedrawWindowRows ; $6659
.checkPlayerInputFlags:
	ldh a, [hPlayerInputFlags] ; $665c
	and $f0 ; $665e
	jr z, .advanceFrame ; $6660
	call DebugEraseFlagCursor ; $6662
	call DebugMoveFlagCursor ; $6665
	call DebugDrawFlagCursor ; $6668
	ld a, [wDebugFlagHeaderWindowId] ; $666b
	call RedrawWindowRows ; $666e
	ld a, [wDebugFlagWindow1Id] ; $6671
	call RedrawWindowRows ; $6674
	ld a, [wDebugFlagWindow2Id] ; $6677
	call RedrawWindowRows ; $667a
.advanceFrame:
	call AdvanceFrame ; $667d
	jp .loop ; $6680
.closeWindow:
	ld a, [wDebugFlagHeaderWindowId] ; $6683
	call CloseWindow ; $6686
	ld a, [wDebugFlagWindow1Id] ; $6689
	call CloseWindow ; $668c
	ld a, [wDebugFlagWindow2Id] ; $668f
	call CloseWindow ; $6692
	ld hl, StubNop_05_3 ; $6695
	call UnregisterFrameTask ; $6698
	pop hl ; $669b
	pop de ; $669c
	pop bc ; $669d
	pop af ; $669e
	ret ; $669f
RunDebugMenu:
	ldh a, [hDebugStepMode] ; $66a0
	or a ; $66a2
	ret z ; $66a3
	push af ; $66a4
	push bc ; $66a5
	push de ; $66a6
	push hl ; $66a7
.loop:
	ld hl, Text_30_311 ; $66a8
	ld_cell de, $0a, $01 ; $66ab
	call CreateMenuWindowFromText ; $66ae
	ld [wDebugMenuWindowId], a ; $66b1
	farcall RestoreShadowTilemap ; $66b4
	call RenderMenuWindowText ; $66b7
	ld a, [wDebugMenuWindowId] ; $66ba
	call RunMenuSelection ; $66bd
	push af ; $66c0
	ld a, [wDebugMenuWindowId] ; $66c1
	call CloseWindow ; $66c4
	pop af ; $66c7
	cp $ff ; $66c8
	jr z, .restore ; $66ca
	ld hl, TextSubcmdHandlers_05 ; $66cc
	add a ; $66cf
	add l ; $66d0
	ld l, a ; $66d1
	jr nc, .read ; $66d2
	inc h ; $66d4
.read:
	ld a, [hl+] ; $66d5
	ld h, [hl] ; $66d6
	ld l, a ; $66d7
	jp hl ; $66d8
.restore:
	pop hl ; $66d9
	pop de ; $66da
	pop bc ; $66db
	pop af ; $66dc
	ret ; $66dd
TextSubcmdHandlers_05:
	; $66de, 8 bytes (records:2)
	dw RunDebugWarpMenuThunk ; record 0
	dw TextSubcmdHandler1 ; record 1
	dw StartDebugPaletteEditorThunk ; record 2
	dw RunDebugFlagEditorThunk ; record 3
RunDebugWarpMenuThunk:
	call RunDebugWarpMenu ; $66e6
	jr RunDebugMenu.loop ; $66e9
TextSubcmdHandler1:
	ld c, $10 ; $66eb
	call BeginFadeOut ; $66ed
	call WaitFadeEnd ; $66f0
	ld hl, wStoryModePlayersXPosition ; $66f3
	ld de, wStoryModeSpawnPosition ; $66f6
	ld bc, wStoryModeSpawnPosition_SIZE ; $66f9
	call CopyMemoryBC ; $66fc
	ld a, STORYENTRY_NONE ; $66ff
	ld [wStoryModeEntryPoint], a ; $6701
	ld [wUnusedExitTriggerIdMirror], a ; $6704
	ld [wStoryModeExitTriggerRequest], a ; $6707
	set_flag FLAG_CHAR_DATA_START_EXITS ; $670a
	ld c, $00 ; $670d
	farcall CharDataScreen_Show ; $670f
	ld c, $01 ; $6712
	farcall CharDataScreen_Show ; $6714
	clear_flag FLAG_CHAR_DATA_START_EXITS ; $6717
	farcall SaveStorySlotWithTimer ; $671a
	pop hl ; $671d
	pop de ; $671e
	pop bc ; $671f
	pop af ; $6720
	ret ; $6721
StartDebugPaletteEditorThunk:
	call StartDebugPaletteEditor ; $6722
	jr RunDebugMenu.loop ; $6725
RunDebugFlagEditorThunk:
	call RunDebugFlagEditor ; $6727
	jp RunDebugMenu.loop ; $672a
DebugDrawWarpMenu:
	ld a, [wDebugWarpWindowId] ; $672d
	call DrawTextWindowFrameSaveRegs ; $6730
	ld a, [wDebugMenuWindowId] ; $6733
	ld h, $00 ; $6736
	ld l, a ; $6738
	ld de, $0d02 ; $6739
	ld a, [wDebugWarpWindowId] ; $673c
	ld a, [wDebugMenuWindowId] ; $673f
	ld hl, $0179 ; $6742
	add l ; $6745
	ld l, a ; $6746
	jr nc, .draw ; $6747
	inc h ; $6749
.draw:
	ld de, $0102 ; $674a
	ld a, [wDebugWarpWindowId] ; $674d
	call WriteDialogueToWindow ; $6750
	ld hl, EnterNumberPrompt_05 ; $6753
	ld de, wDebugNumberEntryText ; $6756
	ld c, wDebugNumberEntryText_SIZE / 16 ; $6759
	call CopyMemoryFast ; $675b
	ld hl, wDebugNumberEntryText ; $675e
	ld_cell de, $01, $04 ; $6761
	ld a, [wDebugWarpWindowId] ; $6764
	call WriteStringToWindow ; $6767
	ld de, wDebugNumberEntryText ; $676a
	ld a, [wDebugMenuWindowId] ; $676d
	ld h, $00 ; $6770
	ld l, a ; $6772
	ld a, $02 ; $6773
	call FormatDecimalNumber ; $6775
	ld hl, wDebugNumberEntryText ; $6778
	ld_cell de, $11, $02 ; $677b
	ld a, [wDebugWarpWindowId] ; $677e
	call WriteStringToWindow ; $6781
	ld de, wDebugNumberEntryText ; $6784
	ld a, [wDebugWarpEntryPoint] ; $6787
	ld h, $00 ; $678a
	ld l, a ; $678c
	ld a, $02 ; $678d
	call FormatDecimalNumber ; $678f
	ld hl, wDebugNumberEntryText ; $6792
	ld_cell de, $11, $04 ; $6795
	ld a, [wDebugWarpWindowId] ; $6798
	call WriteStringToWindow ; $679b
	ld d, $10 ; $679e
	ld a, [wDebugWarpCursorRow] ; $67a0
	add a ; $67a3
	add $02 ; $67a4
	ld e, a ; $67a6
	ld bc, $800d ; $67a7
	ld a, [wDebugWarpWindowId] ; $67aa
	call WriteWindowCellTileAttr ; $67ad
	ld a, [wDebugWarpWindowId] ; $67b0
	call RedrawWindowRows ; $67b3
	ret ; $67b6
EnterNumberPrompt_05:
	; $67b7, 13 bytes (ascii)
	db "- ENTER NO -", $00
RunDebugWarpMenu:
	push af ; $67c4
	push bc ; $67c5
	push de ; $67c6
	push hl ; $67c7
	wram_bank WRAM_TEXT ; $67c8
	xor a ; $67ce
	ld [wDebugWarpCursorRow], a ; $67cf
	ld [wDebugWarpEntryPoint], a ; $67d2
	ld a, [wStoryModeCurrentLocation] ; $67d5
	ld [wDebugMenuWindowId], a ; $67d8
	farcall GetStoryLocationCount ; $67db
	ld [wDebugWarpLocationCount], a ; $67de
	ld_cell de, $00, $00 ; $67e1
	ld_size bc, $14, $06 ; $67e4
	call CreateWindow ; $67e7
	ld [wDebugWarpWindowId], a ; $67ea
	call DebugDrawWarpMenu ; $67ed
	call AdvanceFrame ; $67f0
.loop:
	ldh a, [hInputRisingEdge] ; $67f3
	and PADF_B ; $67f5
	jr nz, .closeWindow ; $67f7
	ldh a, [hInputRisingEdge] ; $67f9
	and PADF_A ; $67fb
	jr z, .checkInputPressed ; $67fd
	ld a, [wDebugMenuWindowId] ; $67ff
	ld [wStoryModeCurrentLocation], a ; $6802
	ld a, [wDebugWarpEntryPoint] ; $6805
	ld [wStoryModeEntryPoint], a ; $6808
	ld a, $ff ; $680b
	ld [wUnusedExitTriggerIdMirror], a ; $680d
	ld [wStoryModeExitTriggerRequest], a ; $6810
	jr .closeWindow ; $6813
.checkInputPressed:
	ldh a, [hInputPressed] ; $6815
	and PADF_UP | PADF_DOWN ; $6817
	jr z, .step2 ; $6819
	ld hl, wDebugWarpCursorRow ; $681b
	ld a, [hl] ; $681e
	xor $01 ; $681f
	ld [hl], a ; $6821
	call DebugDrawWarpMenu ; $6822
.step2:
	ld a, [wDebugWarpCursorRow] ; $6825
	cp $01 ; $6828
	jr z, .eq01 ; $682a
	ld a, [wDebugWarpLocationCount] ; $682c
	ld d, a ; $682f
	ld hl, wDebugMenuWindowId ; $6830
	ld a, [hl] ; $6833
	call DebugStepValueWithDpad ; $6834
	cp [hl] ; $6837
	jr z, .advanceFrame ; $6838
	ld [hl], a ; $683a
	call DebugDrawWarpMenu ; $683b
	jr .advanceFrame ; $683e
.eq01:
	ld d, $10 ; $6840
	ld hl, wDebugWarpEntryPoint ; $6842
	ld a, [hl] ; $6845
	call DebugStepValueWithDpad ; $6846
	cp [hl] ; $6849
	jr z, .advanceFrame ; $684a
	ld [hl], a ; $684c
	call DebugDrawWarpMenu ; $684d
	jr .advanceFrame ; $6850
.advanceFrame:
	call AdvanceFrame ; $6852
	jr .loop ; $6855
.closeWindow:
	ld a, [wDebugWarpWindowId] ; $6857
	call CloseWindow ; $685a
	pop hl ; $685d
	pop de ; $685e
	pop bc ; $685f
	pop af ; $6860
	ret ; $6861
DebugStepValueWithDpad:
	push bc ; $6862
	ld b, a ; $6863
	ldh a, [hInputPressed] ; $6864
	bit PADB_RIGHT, a ; $6866
	jr nz, .next ; $6868
	bit 5, a ; $686a
	jr nz, .bit5Set ; $686c
	ld a, b ; $686e
	pop bc ; $686f
	ret ; $6870
.next:
	inc b ; $6871
	jr .step3 ; $6872
.bit5Set:
	dec b ; $6874
	jr .step3 ; $6875
.step3:
	ld a, b ; $6877
	add a ; $6878
	jr nc, .noCarry ; $6879
	ld a, d ; $687b
	dec a ; $687c
	jr .restore ; $687d
.noCarry:
	rra ; $687f
	cp d ; $6880
	jr c, .restore ; $6881
	xor a ; $6883
.restore:
	pop bc ; $6884
	ret ; $6885
	; $6886, 10 bytes (fill)
	ds 10, $00
