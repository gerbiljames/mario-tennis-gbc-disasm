Unused_1b_RunLevelUpStatusTrophiesMenu:
	push bc ; $6467
	push de ; $6468
	push hl ; $6469
	ldh a, [hWramBank] ; $646a
	push af ; $646c
	call ClearFrameTasks ; $646d
	call DisableLCDSafely ; $6470
	farcall LoadMenuFontGfx ; $6473
	call DisableLCDSafely ; $6476
	farcall ResetTextWindowState ; $6479
	call Unused_1b_ClearScreenMaps ; $647c
	wram_bank WRAM_TEXT ; $647f
	ld d, $02 ; $6485
	ld e, $02 ; $6487
	ld hl, Text_31_124 ; $6489
	farcall CreateMenuWindowFromText ; $648c
	farcall RestoreShadowTilemap ; $648f
	farcall RenderMenuWindowText ; $6492
	script_fade_in $20 ; $6495
	call WaitFadeEnd ; $649a
	farcall RunMenuSelection ; $649d
	ld b, a ; $64a0
	ld c, $20 ; $64a1
	call BeginFadeOut ; $64a3
	call WaitFadeEnd ; $64a6
	ld a, [wMenuWindowId] ; $64a9
	farcall CloseWindow ; $64ac
	pop_wram_bank ; $64af
	ld a, b ; $64b4
	pop hl ; $64b5
	pop de ; $64b6
	pop bc ; $64b7
	ret ; $64b8
Unused_1b_RunDebugSaveDataMenu:
	push bc ; $64b9
	push de ; $64ba
	push hl ; $64bb
	ldh a, [hWramBank] ; $64bc
	push af ; $64be
	call ClearFrameTasks ; $64bf
	call DisableLCDSafely ; $64c2
	farcall LoadMenuFontGfx ; $64c5
	call EnableLCD ; $64c8
	farcall ResetTextWindowState ; $64cb
	call Unused_1b_ClearScreenMaps ; $64ce
	call Unused_1b_ReadUnlockFlagsSaveBlock ; $64d1
	wram_bank WRAM_SCENE ; $64d4
	ld hl, wUnlockFlagsBlock ; $64da
	ld a, [hl+] ; $64dd
	ld d, [hl] ; $64de
	ld e, a ; $64df
	ld hl, Text_31_125 ; $64e0
	or d ; $64e3
	jr nz, .createMenuWindowFromText ; $64e4
	inc hl ; $64e6
.createMenuWindowFromText:
	wram_bank WRAM_TEXT ; $64e7
	ld d, $02 ; $64ed
	ld e, $02 ; $64ef
	farcall CreateMenuWindowFromText ; $64f1
	farcall RestoreShadowTilemap ; $64f4
	farcall RenderMenuWindowText ; $64f7
	script_fade_in $20 ; $64fa
	call WaitFadeEnd ; $64ff
	farcall RunMenuSelection ; $6502
	ld b, a ; $6505
	ld c, $20 ; $6506
	call BeginFadeOut ; $6508
	call WaitFadeEnd ; $650b
	ld a, [wMenuWindowId] ; $650e
	farcall CloseWindow ; $6511
	pop_wram_bank ; $6514
	ld a, b ; $6519
	pop hl ; $651a
	pop de ; $651b
	pop bc ; $651c
	ret ; $651d
Unused_1b_ClearScreenMaps:
	call DisableLCDSafely ; $651e
	wram_bank WRAM_COURT_PLANES ; $6521
	ld a, $00 ; $6527
	ld hl, wScreenAttrmap ; $6529
	ld bc, $0500 ; $652c
	call Unused_1b_FillBytesWithValue ; $652f
	wram_bank WRAM_SCREEN ; $6532
	ld a, $20 ; $6538
	ld hl, wShadowTilemap ; $653a
	ld bc, $0500 ; $653d
	call Unused_1b_FillBytesWithValue ; $6540
	wram_bank WRAM_SCREEN ; $6543
	ld hl, wShadowTilemap ; $6549
	ld de, vBGMap0 ; $654c
	ld c, SCREEN_HEIGHT * TILEMAP_WIDTH / 16 ; $654f
	call QueueVRAMCopy ; $6551
	wram_bank WRAM_COURT_PLANES ; $6554
	ld hl, wScreenAttrmap ; $655a
	ld de, vBGMap0 + VRAM_BANK1 ; $655d
	ld c, SCREEN_HEIGHT * TILEMAP_WIDTH / 16 ; $6560
	call QueueVRAMCopy ; $6562
	call EnableLCD ; $6565
	ret ; $6568
Unused_1b_FillBytesWithValue:
	ld e, a ; $6569
.loop:
	ld [hl], e ; $656a
	inc hl ; $656b
	dec bc ; $656c
	ld a, c ; $656d
	or b ; $656e
	jr nz, .loop ; $656f
	ret ; $6571
UnlockDebugNavGridTable:
	; $6572, 32 bytes (bytes:16)
	db $1a, $1b, $1c, $1d, $1e, $fe, $fd, $ff, $1f, $12, $13, $14, $15, $fe, $fd, $ff ; 0x00
	db $ff, $ff, $ff, $ff, $ff, $fe, $fd, $ff, $ff, $ff, $ff, $ff, $ff, $fe, $fd, $ff ; 0x10
UnlockDebugRosterTable:
	; $6592, 88 bytes (bytes:8)
	db $1a, $00, $00, $b6, $20, $18, $83, $00 ; 0x00
	db $1b, $00, $00, $b7, $20, $30, $86, $00 ; 0x08
	db $1c, $00, $00, $a8, $20, $48, $89, $00 ; 0x10
	db $1d, $00, $00, $a9, $20, $60, $8c, $00 ; 0x18
	db $1e, $00, $00, $aa, $20, $78, $8f, $00 ; 0x20
	db $1f, $00, $00, $ab, $38, $18, $e3, $00 ; 0x28
	db $12, $00, $00, $ac, $38, $30, $e6, $00 ; 0x30
	db $13, $00, $00, $ad, $38, $48, $e9, $00 ; 0x38
	db $14, $00, $00, $ae, $38, $60, $ec, $00 ; 0x40
	db $15, $00, $00, $af, $38, $78, $ef, $00 ; 0x48
	db $ff, $00, $00, $b0, $18, $20, $64, $00 ; 0x50
Unused_1b_FindUnlockDebugRosterEntry:
	ld hl, wCharSelectRoster ; $65ea
	farcall Unused_18_FindRosterEntry ; $65ed
	ret ; $65f0
Unused_1b_GetUnlockDebugRosterField:
	push hl ; $65f1
	call Unused_1b_FindUnlockDebugRosterEntry ; $65f2
	ld a, [hl+] ; $65f5
	ld d, [hl] ; $65f6
	ld e, a ; $65f7
	pop hl ; $65f8
	ret ; $65f9
Unused_1b_LoadUnlockDebugNavGrid:
	ld hl, UnlockDebugNavGridTable ; $65fa
	ld de, wNavGridBuffer ; $65fd
	ld bc, $0020 ; $6600
	call CopyMemoryBC ; $6603
	ret ; $6606
	db $0b ; $6607
	db $0c ; $6608
Unused_1b_LoadUnlockDebugRosterTable:
	ld hl, UnlockDebugRosterTable ; $6609
	ld de, wCharSelectRoster ; $660c
	ld bc, wCharSelectRoster_SIZE ; $660f
	call CopyMemoryBC ; $6612
	ret ; $6615
	db $08 ; $6616
	db $09 ; $6617
Unused_1b_LoadUnlockDebugScreenGfx:
	ld hl, wDecompBuffer ; $6618
	ld de, vTiles2 + VRAM_BANK1 ; $661b
	ld c, $80 ; $661e
	call QueueVRAMCopy ; $6620
	ld hl, wTextTileBuffer ; $6623
	ld de, vTiles1 + VRAM_BANK1 ; $6626
	ld c, wTextTileBuffer_SIZE / 16 ; $6629
	call QueueVRAMCopy ; $662b
	ld hl, UnlockDebugNavGridTable ; $662e
	ld de, wTextTileBuffer + 64 * TILE_SIZE ; $6631
	call DecompressData ; $6634
	ld hl, UnlockDebugNavGridTable ; $6637
	ld de, wTextTileBuffer ; $663a
	call DecompressData ; $663d
	ld hl, UnlockDebugNavGridTable ; $6640
	ld_bg_pals de, 0, 8 ; $6643
	call LoadPaletteShadow ; $6646
	ret ; $6649
; Decompresses UnlockDebugNavGridTable to $d000, uploads it to $8500 and loads
; its palette. The leading `ret` means it never runs -- this is debug-screen
; artwork, so the screen presumably renders without it.
Unused_1b_LoadUnlockDebugNavGridGfx:
	ret ; $664a
	ld hl, UnlockDebugNavGridTable ; $664b
	ld de, $d000 ; $664e
	call DecompressData ; $6651
	ld hl, $d000 ; $6654
	ld de, vTiles0 + $50 * TILE_SIZE ; $6657
	ld c, $28 ; $665a
	call QueueVRAMCopy ; $665c
	ld hl, UnlockDebugNavGridTable ; $665f
	ld_obj_pals de, 0, 1 ; $6662
	call LoadPaletteShadow ; $6665
	ld a, $0a ; $6668
	ld hl, Unused_1b_UpdateBobbingDecorSprite ; $666a
	call RegisterFrameTask ; $666d
	ret ; $6670
Unused_1b_UpdateBobbingDecorSprite:
	ld de, $2cfa ; $6671
	farcall Unused_18_ApplySpriteBobOffset ; $6674
	ld hl, UnlockDebugNavGridTable ; $6677
	ld_oam bc, 0, $50 ; $667a
	call QueueSpriteTemplate ; $667d
	ret ; $6680
Unused_1b_StartUnlockDebugCursorTask:
	farcall Unused_18_LoadCharSelectCursorGfx ; $6681
	ld a, $0a ; $6684
	ld hl, Unused_1b_UpdateUnlockDebugCursorTask ; $6686
	call RegisterFrameTask ; $6689
	ret ; $668c
Unused_1b_UpdateUnlockDebugCursorTask:
	ld a, [wCharSelectChar] ; $668d
	ld de, $0004 ; $6690
	call Unused_1b_GetUnlockDebugRosterField ; $6693
	ld a, [wCharSelectChar] ; $6696
	farcall Unused_18_DrawCharSelectCursor ; $6699
	ret ; $669c
Unused_1b_UpdateUnlockDebugSelectedMugshot:
	ld a, [wCharSelectChar] ; $669d
	push af ; $66a0
	ld de, $0006 ; $66a1
	call Unused_1b_GetUnlockDebugRosterField ; $66a4
	pop af ; $66a7
	ld b, a ; $66a8
	push bc ; $66a9
	farcall Unused_18_CheckUnlockFlag ; $66aa
	pop bc ; $66ad
	ld a, b ; $66ae
	jr z, .registerFrameTask2 ; $66af
	farcall LoadCharacterRecordToBuffer ; $66b1
	jr .registerFrameTask ; $66b4
.registerFrameTask2:
	ld a, $20 ; $66b6
	ld [wCharRecordBuffer + 11], a ; $66b8
.registerFrameTask:
	ld a, $0a ; $66bb
	ld hl, Unused_1b_UpdateUnlockDebugStatOnChange ; $66bd
	call RegisterFrameTask ; $66c0
	ret ; $66c3
Unused_1b_UpdateUnlockDebugStatOnChange:
	ld hl, wCharSelectChar ; $66c4
	ld a, [wCharSelectPrevChar] ; $66c7
	cp [hl] ; $66ca
	jr z, .done ; $66cb
	ld a, [wCharSelectChar] ; $66cd
	ld de, $0006 ; $66d0
	call Unused_1b_GetUnlockDebugRosterField ; $66d3
.done:
	ret ; $66d6
Unused_1b_DrawUnlockDebugMugshots:
	farcall Unused_1b_ResetMugshotPalettes ; $66d7
	ld hl, wCharSelectRoster ; $66da
.loop:
	ld a, [hl] ; $66dd
	farcall LoadCharacterRecordToBuffer ; $66de
	farcall Unused_18_CheckUnlockFlag ; $66e1
	jr z, .step ; $66e4
	ld a, [wCharRecordBuffer + 11] ; $66e6
	farcall LoadCharMugshotToBuffer ; $66e9
	ld a, [hl] ; $66ec
	ld de, $0002 ; $66ed
	call Unused_1b_GetUnlockDebugRosterField ; $66f0
	farcall CopyMugshotBufferToVram ; $66f3
	ld a, [hl] ; $66f6
	ld de, $0006 ; $66f7
	call Unused_1b_GetUnlockDebugRosterField ; $66fa
	ld a, [wCharRecordBuffer + 12] ; $66fd
	farcall Unused_1b_SetMugshotAttrs ; $6700
.step:
	ld a, $08 ; $6703
	add l ; $6705
	ld l, a ; $6706
	jr nc, .read ; $6707
	inc h ; $6709
.read:
	ld a, [hl] ; $670a
	cp $ff ; $670b
	jr nz, .loop ; $670d
	ld a, [wCharSelectChar] ; $670f
	farcall LoadCharacterRecordToBuffer ; $6712
	ld a, [wCharRecordBuffer + 11] ; $6715
	farcall Unused_1b_StubNop_1b_01 ; $6718
	ret ; $671b
Unused_1b_RunMinigameFlagsDebugScreen:
	wram_bank WRAM_STAGING ; $671c
	call ClearFrameTasks ; $6722
	call Unused_1b_LoadUnlockDebugNavGrid ; $6725
	call Unused_1b_LoadUnlockDebugRosterTable ; $6728
	ld hl, wUnlockDebugSelection ; $672b
	call Unused_1b_UpdateUnlockDebugSelection ; $672e
	ld a, [wCharSelectChar] ; $6731
	ld [wCharSelectPrevChar], a ; $6734
	call Unused_1b_ReadUnlockFlagsSaveBlock ; $6737
	ld c, $20 ; $673a
	call BeginFadeOut ; $673c
	call WaitFadeEnd ; $673f
	call DisableLCDSafely ; $6742
	call Unused_1b_LoadUnlockDebugNavGridGfx ; $6745
	call Unused_1b_StartUnlockDebugCursorTask ; $6748
	call Unused_1b_LoadUnlockDebugScreenGfx ; $674b
	call Unused_1b_DrawUnlockDebugMugshots ; $674e
	call Unused_1b_UpdateUnlockDebugSelectedMugshot ; $6751
	ld hl, wTextTileBuffer + 64 * TILE_SIZE ; $6754
	ld de, vBGMap0 + VRAM_BANK1 ; $6757
	ld c, $24 ; $675a
	call QueueVRAMCopy ; $675c
	ld hl, wTextTileBuffer ; $675f
	ld de, vBGMap0 ; $6762
	ld c, $24 ; $6765
	call QueueVRAMCopy ; $6767
	call Unused_1b_LoadUnlockDebugCursorGfx ; $676a
	call EnableLCD ; $676d
	script_fade_in $20 ; $6770
	call WaitFadeEnd ; $6775
.loop:
	wram_bank WRAM_STAGING ; $6778
	ldh a, [hInputRisingEdge] ; $677e
	and PADF_A ; $6780
	jr z, .checkInputRisingEdge ; $6782
	ld a, [wCharSelectChar] ; $6784
	ld b, a ; $6787
	push bc ; $6788
	farcall Unused_18_CheckUnlockFlag ; $6789
	pop bc ; $678c
	ld a, b ; $678d
	jr z, .playSfx ; $678e
	jr .playSfx2 ; $6790
.playSfx:
	sound SFX_MENU_CANCEL ; $6792
	jr .loop ; $6794
.playSfx2:
	sound SFX_MENU_SELECT ; $6796
	ld hl, wUnlockDebugSelection ; $6798
	jr .beginFadeOut ; $679b
.checkInputRisingEdge:
	ldh a, [hInputRisingEdge] ; $679d
	and PADF_B ; $679f
	jr z, .checkInputRisingEdge2 ; $67a1
	sound SFX_MENU_CANCEL ; $67a3
	ld hl, wUnlockDebugSelection ; $67a5
	ld a, $00 ; $67a8
	ld [hl], a ; $67aa
	ld a, $ff ; $67ab
	jr .beginFadeOut ; $67ad
.checkInputRisingEdge2:
	ldh a, [hInputRisingEdge] ; $67af
	and PADF_START ; $67b1
	jr z, .moveUnlockDebugCursor ; $67b3
	call Unused_1b_ToggleSelectedUnlockFlag ; $67b5
.moveUnlockDebugCursor:
	call Unused_1b_MoveUnlockDebugCursor ; $67b8
	call Unused_1b_UpdateUnlockDebugSelection ; $67bb
	ld a, [wCharSelectChar] ; $67be
	call AdvanceFrame ; $67c1
	jr .loop ; $67c4
.beginFadeOut:
	ld c, $08 ; $67c6
	call BeginFadeOut ; $67c8
	call WaitFadeEnd ; $67cb
	call Unused_1b_WriteUnlockFlagsSaveBlock ; $67ce
	call AdvanceFrame ; $67d1
	call AdvanceFrame ; $67d4
	ret ; $67d7
Unused_1b_UpdateUnlockDebugSelection:
	ld a, [wCharSelectChar] ; $67d8
	ld [wCharSelectPrevChar], a ; $67db
	ld a, [wCharSelectRow] ; $67de
	add a ; $67e1
	add a ; $67e2
	add a ; $67e3
	ld hl, wCharSelectCol ; $67e4
	add [hl] ; $67e7
	add $a0 ; $67e8
	ld l, a ; $67ea
	adc $c7 ; $67eb
	sub l ; $67ed
	ld h, a ; $67ee
	ld a, [hl] ; $67ef
	ld [wCharSelectChar], a ; $67f0
	ret ; $67f3
Unused_1b_MoveUnlockDebugCursor:
	ldh a, [hInputPressed] ; $67f4
	ld b, a ; $67f6
	and $f0 ; $67f7
	jr z, .done ; $67f9
	sound SFX_MENU_MOVE ; $67fb
	ld a, [wCharSelectCol] ; $67fd
	ld d, a ; $6800
	ld a, [wCharSelectRow] ; $6801
	ld e, a ; $6804
	ld hl, wNavGridBuffer ; $6805
	call Unused_1b_StepUnlockDebugCursor ; $6808
	ld b, a ; $680b
	push bc ; $680c
	farcall Unused_18_CheckUnlockFlag ; $680d
	pop bc ; $6810
	ld a, b ; $6811
	jr z, .storeCharSelectCol2 ; $6812
	farcall LoadCharacterRecordToBuffer ; $6814
	jr .storeCharSelectCol ; $6817
.storeCharSelectCol2:
	ld a, $20 ; $6819
	ld [wCharRecordBuffer + 11], a ; $681b
.storeCharSelectCol:
	ld a, d ; $681e
	ld [wCharSelectCol], a ; $681f
	ld a, e ; $6822
	ld [wCharSelectRow], a ; $6823
.done:
	ret ; $6826
Unused_1b_StepUnlockDebugCursor:
	bit 5, b ; $6827
	jr z, .bit5Clear ; $6829
	dec d ; $682b
	jr .wrapX ; $682c
.bit5Clear:
	bit 4, b ; $682e
	jr z, .bit4Clear ; $6830
	inc d ; $6832
	jr .wrapX ; $6833
.bit4Clear:
	bit 6, b ; $6835
	jr z, .bit6Clear ; $6837
	dec e ; $6839
	jr .wrapX ; $683a
.bit6Clear:
	bit 7, b ; $683c
	jr z, .wrapX ; $683e
	inc e ; $6840
.wrapX:
	ld a, d ; $6841
	add a ; $6842
	jr nc, .noCarry ; $6843
	ld a, $05 ; $6845
	dec a ; $6847
	jr .storeX ; $6848
.noCarry:
	rra ; $684a
	cp $05 ; $684b
	jr c, .storeX ; $684d
	xor a ; $684f
.storeX:
	ld d, a ; $6850
	ld a, e ; $6851
	add a ; $6852
	jr nc, .noCarry2 ; $6853
	ld a, $02 ; $6855
	dec a ; $6857
	jr .storeY ; $6858
.noCarry2:
	rra ; $685a
	cp $02 ; $685b
	jr c, .storeY ; $685d
	xor a ; $685f
.storeY:
	ld e, a ; $6860
	ld a, e ; $6861
	add a ; $6862
	add a ; $6863
	add a ; $6864
	add d ; $6865
	push hl ; $6866
	add l ; $6867
	ld l, a ; $6868
	jr nc, .read ; $6869
	inc h ; $686b
.read:
	ld a, [hl] ; $686c
	pop hl ; $686d
	ret ; $686e
Unused_1b_ReadUnlockFlagsSaveBlock:
	push bc ; $686f
	push_wram_bank WRAM_SCENE ; $6870
	ld hl, wUnlockFlagsBlock ; $6879
	ld b, SAVEBLOCK_N64_RECORDS ; $687c
	farcall ReadSaveBlock ; $687e
	ld b, a ; $6881
	pop_wram_bank ; $6882
	ld a, b ; $6887
	pop bc ; $6888
	ret ; $6889
Unused_1b_WriteUnlockFlagsSaveBlock:
	push_wram_bank WRAM_SCENE ; $688a
	ld hl, wUnlockFlagsBlock ; $6893
	ld de, $0000 ; $6896
	ld b, SAVEBLOCK_N64_RECORDS ; $6899
	farcall WriteSaveBlock ; $689b
	pop_wram_bank ; $689e
	ret ; $68a3
