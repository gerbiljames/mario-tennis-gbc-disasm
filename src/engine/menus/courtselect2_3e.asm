FadeOutAndResetMenuScreen:
	push_wram_bank WRAM_SCREEN ; $64f8
	ld c, $10 ; $6501
	call BeginFadeOut ; $6503
	call WaitFadeEnd ; $6506
	call DisableLCDSafely ; $6509
	farcall LoadMenuFontGfx ; $650c
	farcall ResetScreenAndTextWindows ; $650f
	pop_wram_bank ; $6512
	ret ; $6517
RunCourtSelect9Menu:
	ld a, [wUnlockedCourtMask] ; $6518
	ld b, a ; $651b
	call StoreCourtUnlockBits ; $651c
	sound BGM_MENU ; $651f
	call ClearFrameTasks ; $6521
	ld hl, rIE ; $6524
	res 2, [hl] ; $6527
	farcall InitMenuBgScroll ; $6529
	ld b, $01 ; $652c
	ld c, $01 ; $652e
	farcall LoadMenuSpritePalettePair ; $6530
	call LoadCourtSelectHeader ; $6533
	wram_bank WRAM_SCREEN ; $6536
	ld a, [wMenuSlideDirection] ; $653c
	ld b, a ; $653f
	call OpenCourtSelect9Panel ; $6540
	xor a ; $6543
	ld c, a ; $6544
	ld b, $03 ; $6545
	call SetMenuCursorFromIndex_3e ; $6547
	ld a, $01 ; $654a
	ld hl, CourtSelect9CursorSpriteTask ; $654c
	call RegisterFrameTask ; $654f
	call RedrawCourtSelect9Menu ; $6552
	wram_bank WRAM_SCREEN ; $6555
.loop:
	call AdvanceFrame ; $655b
	ldh a, [hInputPressed] ; $655e
	ld [wMenuInputPressed], a ; $6560
	ld b, $03 ; $6563
	ld c, $03 ; $6565
	call MoveMenuCursorGrid_3e ; $6567
	or a ; $656a
	jr z, .checkMenuInputPressed ; $656b
	sound SFX_MENU_MOVE ; $656d
	call RedrawCourtSelect9Menu ; $656f
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $6572
	bit PADB_A, a ; $6575
	jr nz, .getMenuCursorIndex ; $6577
	bit 1, a ; $6579
	jr nz, .playSfx2 ; $657b
	jr .loop ; $657d
.getMenuCursorIndex:
	ld c, $03 ; $657f
	call GetMenuCursorIndex_3e ; $6581
	ld b, a ; $6584
	call IsCourtUnlocked ; $6585
	or a ; $6588
	jr nz, .playSfx ; $6589
	sound SFX_MENU_LOCKED ; $658b
	jr .loop ; $658d
.playSfx:
	sound SFX_MENU_DECIDE ; $658f
	call ClearFrameTasks ; $6591
	ld hl, rIE ; $6594
	set 2, [hl] ; $6597
	ld b, $01 ; $6599
	call CloseCourtSelect9Panel ; $659b
	ld a, MENUSLIDE_FORWARD ; $659e
	ld [wMenuSlideDirection], a ; $65a0
	ld c, $03 ; $65a3
	call GetMenuCursorIndex_3e ; $65a5
	push af ; $65a8
	ld c, a ; $65a9
	call SetCourtSelectBGM ; $65aa
	pop af ; $65ad
	call CourtSelectIndexToCourtId ; $65ae
	ret ; $65b1
.playSfx2:
	sound SFX_MENU_CANCEL ; $65b2
	call ClearFrameTasks ; $65b4
	ld hl, rIE ; $65b7
	set 2, [hl] ; $65ba
	ld b, $00 ; $65bc
	call CloseCourtSelect9Panel ; $65be
	ld a, MENUSLIDE_BACK ; $65c1
	ld [wMenuSlideDirection], a ; $65c3
	ld a, $ff ; $65c6
	ret ; $65c8
RunLinkCourtSelect9Menu:
	xor a ; $65c9
	ldh [hLinkExchangeActive], a ; $65ca
	call ResetSerialState ; $65cc
	call ClearFrameTasks ; $65cf
	call EnableTimerInterrupt ; $65d2
	sound BGM_MENU ; $65d5
	ld a, [wUnlockedCourtMask] ; $65d7
	ld b, a ; $65da
	ld a, [wLinkPartnerCourtMask] ; $65db
	or b ; $65de
	ld b, a ; $65df
	call StoreCourtUnlockBits ; $65e0
	farcall InitMenuBgScroll ; $65e3
	ld b, $01 ; $65e6
	ld c, $01 ; $65e8
	farcall LoadMenuSpritePalettePair ; $65ea
	call LoadCourtSelectHeader ; $65ed
	wram_bank WRAM_SCREEN ; $65f0
	ld a, [wMenuSlideDirection] ; $65f6
	ld b, a ; $65f9
	call OpenCourtSelect9Panel ; $65fa
	ld a, [wSubMenuCursor] ; $65fd
	ld c, a ; $6600
	ld b, $03 ; $6601
	call SetMenuCursorFromIndex_3e ; $6603
	ld a, $01 ; $6606
	ld hl, CourtSelect9CursorSpriteTask ; $6608
	call RegisterFrameTask ; $660b
	call RedrawCourtSelect9Menu ; $660e
	farcall ResyncLinkSessionWithTimer ; $6611
	push af ; $6614
	farcall RunLinkInputFrame ; $6615
	pop af ; $6618
	push af ; $6619
	farcall RunLinkInputFrame ; $661a
	pop af ; $661d
	push af ; $661e
	farcall RunLinkInputFrame ; $661f
	pop af ; $6622
	wram_bank WRAM_SCREEN ; $6623
.loop:
	ldh a, [hLinkInput] ; $6629
	ld [wMenuInputPressed], a ; $662b
	push af ; $662e
	farcall RunLinkInputFrame ; $662f
	pop af ; $6632
	ld b, $03 ; $6633
	ld c, $03 ; $6635
	call MoveMenuCursorGrid_3e ; $6637
	or a ; $663a
	jr z, .checkMenuInputPressed ; $663b
	sound SFX_MENU_MOVE ; $663d
	call RedrawCourtSelect9Menu ; $663f
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $6642
	bit PADB_A, a ; $6645
	jr nz, .getMenuCursorIndex ; $6647
	bit 1, a ; $6649
	jr nz, .playSfx2 ; $664b
	jr .loop ; $664d
.getMenuCursorIndex:
	ld c, $03 ; $664f
	call GetMenuCursorIndex_3e ; $6651
	ld b, a ; $6654
	call IsCourtUnlocked ; $6655
	or a ; $6658
	jr nz, .playSfx ; $6659
	sound SFX_MENU_LOCKED ; $665b
	jr .loop ; $665d
.playSfx:
	sound SFX_MENU_DECIDE ; $665f
	push af ; $6661
	farcall SyncLinkFrame ; $6662
	pop af ; $6665
	call ClearFrameTasks ; $6666
	xor a ; $6669
	ldh [hLinkExchangeActive], a ; $666a
	call ResetSerialState ; $666c
	call EnableTimerInterrupt ; $666f
	ld a, MENUSLIDE_FORWARD ; $6672
	ld [wMenuSlideDirection], a ; $6674
	ld c, $03 ; $6677
	call GetMenuCursorIndex_3e ; $6679
	push af ; $667c
	ld c, a ; $667d
	call SetCourtSelectBGMLink ; $667e
	pop af ; $6681
	call CourtSelectIndexToCourtId ; $6682
	ret ; $6685
.playSfx2:
	sound SFX_MENU_CANCEL ; $6686
	push af ; $6688
	farcall SyncLinkFrame ; $6689
	pop af ; $668c
	xor a ; $668d
	ldh [hLinkExchangeActive], a ; $668e
	call ResetSerialState ; $6690
	call ClearFrameTasks ; $6693
	ld b, $00 ; $6696
	call CloseCourtSelect9Panel ; $6698
	ld a, MENUSLIDE_BACK ; $669b
	ld [wMenuSlideDirection], a ; $669d
	ld c, $10 ; $66a0
	call BeginFadeOut ; $66a2
	call WaitFadeEnd ; $66a5
	ld a, $ff ; $66a8
	ret ; $66aa
OpenCourtSelect9Panel:
	ld a, b ; $66ab
	or a ; $66ac
	jr z, .zero ; $66ad
	ld c, $00 ; $66af
.loop:
	call AdvanceFrame ; $66b1
	ld b, $14 ; $66b4
	farcall RestoreMenuBgAndDrawPanel ; $66b6
	ld b, $00 ; $66b9
	farcall FlushWram3MapRows ; $66bb
	ld a, c ; $66be
	inc a ; $66bf
	ld c, a ; $66c0
	cp $0f ; $66c1
	jr nz, .loop ; $66c3
	call AdvanceFrame ; $66c5
	ret ; $66c8
.zero:
	ld c, $09 ; $66c9
.loopB:
	call AdvanceFrame ; $66cb
	ld b, $15 ; $66ce
	farcall RestoreMenuBgAndDrawPanel ; $66d0
	ld b, $00 ; $66d3
	farcall FlushWram3MapRows ; $66d5
	ld a, c ; $66d8
	dec a ; $66d9
	ld c, a ; $66da
	cp $ff ; $66db
	jr nz, .loopB ; $66dd
	call AdvanceFrame ; $66df
	ret ; $66e2
CloseCourtSelect9Panel:
	ld a, b ; $66e3
	or a ; $66e4
	jr z, .zero ; $66e5
	ld c, $00 ; $66e7
.loop:
	call AdvanceFrame ; $66e9
	ld b, $15 ; $66ec
	farcall RestoreMenuBgAndDrawPanel ; $66ee
	ld b, $00 ; $66f1
	farcall FlushWram3MapRows ; $66f3
	ld a, c ; $66f6
	inc a ; $66f7
	ld c, a ; $66f8
	cp $0b ; $66f9
	jr nz, .loop ; $66fb
	ret ; $66fd
.zero:
	ld c, $0e ; $66fe
.loopB:
	call AdvanceFrame ; $6700
	ld b, $14 ; $6703
	farcall RestoreMenuBgAndDrawPanel ; $6705
	ld b, $00 ; $6708
	farcall FlushWram3MapRows ; $670a
	ld a, c ; $670d
	dec a ; $670e
	ld c, a ; $670f
	or a ; $6710
	jr nz, .loopB ; $6711
	ret ; $6713
CourtSelect9CursorSpriteTask:
	farcall TickMenuBgScroll ; $6714
	ld c, $03 ; $6717
	call GetMenuCursorIndex_3e ; $6719
	push af ; $671c
	ld hl, CourtSelect9CursorTiles_3e ; $671d
	add l ; $6720
	ld l, a ; $6721
	jr nc, .read ; $6722
	inc h ; $6724
.read:
	ld c, [hl] ; $6725
	pop af ; $6726
	push af ; $6727
	ld hl, CourtSelect9CursorPositions_3e ; $6728
	add a ; $672b
	add l ; $672c
	ld l, a ; $672d
	jr nc, .readB ; $672e
	inc h ; $6730
.readB:
	ld a, [hl+] ; $6731
	ld d, [hl] ; $6732
	ld e, a ; $6733
	farcall ApplySpriteBobOffset ; $6734
	push bc ; $6737
	ld c, $03 ; $6738
	call GetMenuCursorIndex_3e ; $673a
	ld hl, CourtSelect9CursorAttrs_3e ; $673d
	add l ; $6740
	ld l, a ; $6741
	jr nc, .restore ; $6742
	inc h ; $6744
.restore:
	pop bc ; $6745
	ld b, [hl] ; $6746
	pop af ; $6747
	add a ; $6748
	ld hl, CourtSelect9CursorTemplatePtrs_3e ; $6749
	add l ; $674c
	ld l, a ; $674d
	jr nc, .read2 ; $674e
	inc h ; $6750
.read2:
	ld a, [hl+] ; $6751
	ld h, [hl] ; $6752
	ld l, a ; $6753
	push de ; $6754
	call AdjustCursorForLockedCourt ; $6755
	call QueueSpriteTemplate ; $6758
	pop de ; $675b
	ld c, $03 ; $675c
	call GetMenuCursorIndex_3e ; $675e
	ld hl, CourtSelect9LabelYOffsets_3e ; $6761
	add l ; $6764
	ld l, a ; $6765
	jr nc, .read3 ; $6766
	inc h ; $6768
.read3:
	ld a, [hl] ; $6769
	ld h, a ; $676a
	ld l, $f8 ; $676b
	add hl, de ; $676d
	ld d, h ; $676e
	ld e, l ; $676f
	ld hl, CourtSelect9CursorSpriteTask_SpriteTemplate ; $6770
	ld b, $08 ; $6773
	ld c, $72 ; $6775
	call QueueSpriteTemplate ; $6777
	ret ; $677a
CourtSelect9CursorTemplatePtrs_3e:
	dw CourtSelect9CursorTemplate0_3e, CourtSelect9CursorTemplate0_3e, CourtSelect9CursorTemplate0_3e, CourtSelect9CursorTemplate1_3e, CourtSelect9CursorTemplate0_3e, CourtSelect9CursorTemplate0_3e, CourtSelect9CursorTemplate0_3e, CourtSelect9CursorTemplate0_3e, CourtSelect9CursorTemplate0_3e ; $677b
CourtSelect9CursorTemplate0_3e:
	INCBIN "data/bank_03e/CourtSelect9CursorTemplate0_3e.bin" ; $678d, 33 bytes
CourtSelect9CursorTemplate1_3e:
	INCBIN "data/bank_03e/CourtSelect9CursorTemplate1_3e.bin" ; $67ae, 37 bytes
CourtSelect9CursorSpriteTask_SpriteTemplate:
	; $67d3, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
CourtSelect9CursorPositions_3e:
	; $67dc, 18 bytes (bytes:16)
	db $30, $fc, $30, $2c, $30, $5c, $50, $fe, $50, $2c, $50, $5c, $6c, $fc, $6c, $2c ; 0x00
	db $6c, $5c ; 0x10
CourtSelect9CursorTiles_3e:
	; $67ee, 10 bytes (bytes:10)
	db $00, $10, $20, $30, $42, $52, $62, $20, $30, $00 ; 0x00
CourtSelect9CursorAttrs_3e:
	; $67f8, 10 bytes (bytes:10)
	db $08, $08, $08, $08, $08, $08, $08, $00, $00, $00 ; 0x00
CourtSelect9LabelYOffsets_3e:
	; $6802, 10 bytes (bytes:10)
	db $17, $17, $17, $1b, $17, $17, $17, $17, $17, $17 ; 0x00
AdjustCursorForLockedCourt:
	push bc ; $680c
	push hl ; $680d
	ld c, $03 ; $680e
	call GetMenuCursorIndex_3e ; $6810
	ld b, a ; $6813
	call IsCourtUnlocked ; $6814
	or a ; $6817
	jr z, .zero ; $6818
	pop hl ; $681a
	pop bc ; $681b
	ret ; $681c
.zero:
	ld c, $40 ; $681d
	ld b, $00 ; $681f
	pop hl ; $6821
	pop af ; $6822
	ret ; $6823
RedrawCourtSelect9Menu:
	wram_bank WRAM_SCREEN ; $6824
	ld b, $00 ; $682a
	ld c, $00 ; $682c
.tabLoop:
	call SetCourtSelect9TabAttrRect ; $682e
	ld a, b ; $6831
	inc a ; $6832
	ld b, a ; $6833
	cp $09 ; $6834
	jr nz, .tabLoop ; $6836
	ld c, $03 ; $6838
	call GetMenuCursorIndex_3e ; $683a
	ld b, a ; $683d
	ld c, $01 ; $683e
	call SetCourtSelect9TabAttrRect ; $6840
	ld c, $03 ; $6843
	call GetMenuCursorIndex_3e ; $6845
	call SetCourtSelect9Palette ; $6848
	ld c, $03 ; $684b
	call GetMenuCursorIndex_3e ; $684d
	ld d, a ; $6850
	ld b, a ; $6851
	call IsCourtUnlocked ; $6852
	or a ; $6855
	ld b, $ff ; $6856
	jr z, .drawName ; $6858
	ld b, d ; $685a
.drawName:
	call DrawCourtNameTiles ; $685b
	ld hl, wShadowAttrmap + 3 * TILEMAP_WIDTH ; $685e
	ld de, vBGMap0 + 3 * TILEMAP_WIDTH + VRAM_BANK1 ; $6861
	ld c, $06 ; $6864
	call QueueVRAMCopy ; $6866
	ld hl, wShadowAttrmap + 7 * TILEMAP_WIDTH ; $6869
	ld de, vBGMap0 + 7 * TILEMAP_WIDTH + VRAM_BANK1 ; $686c
	ld c, $06 ; $686f
	call QueueVRAMCopy ; $6871
	ld hl, wShadowAttrmap + 11 * TILEMAP_WIDTH ; $6874
	ld de, vBGMap0 + 11 * TILEMAP_WIDTH + VRAM_BANK1 ; $6877
	ld c, $06 ; $687a
	call QueueVRAMCopy ; $687c
	ld hl, wShadowTilemap + 16 * TILEMAP_WIDTH ; $687f
	ld de, vBGMap0 + 16 * TILEMAP_WIDTH ; $6882
	ld c, $02 ; $6885
	call QueueVRAMCopy ; $6887
	ret ; $688a
SetCourtSelect9TabAttrRect:
	push af ; $688b
	push bc ; $688c
	push de ; $688d
	push hl ; $688e
	ld a, c ; $688f
	or a ; $6890
	jr z, .zero ; $6891
	ld h, $0c ; $6893
	jr .step2 ; $6895
.zero:
	ld h, $0d ; $6897
.step2:
	push hl ; $6899
	ld hl, CourtSelect9TabAttrAddrs_3e ; $689a
	ld a, b ; $689d
	add a ; $689e
	add l ; $689f
	ld l, a ; $68a0
	jr nc, .read ; $68a1
	inc h ; $68a3
.read:
	ld a, [hl+] ; $68a4
	ld d, [hl] ; $68a5
	ld e, a ; $68a6
	pop hl ; $68a7
	ld b, $05 ; $68a8
	ld c, $03 ; $68aa
	farcall FillTilemapRect ; $68ac
	pop hl ; $68af
	pop de ; $68b0
	pop bc ; $68b1
	pop af ; $68b2
	ret ; $68b3
CourtSelect9TabAttrAddrs_3e:
	; $68b4, 18 bytes (bytes:16)
	db $61, $d4, $67, $d4, $6d, $d4, $e1, $d4, $e7, $d4, $ed, $d4, $61, $d5, $67, $d5 ; 0x00
	db $6d, $d5 ; 0x10
SetCourtSelect9Palette:
	ld hl, CourtSelect9PalettePtrs ; $68c6
	add a ; $68c9
	add l ; $68ca
	ld l, a ; $68cb
	jr nc, .read ; $68cc
	inc h ; $68ce
.read:
	ld a, [hl+] ; $68cf
	ld h, [hl] ; $68d0
	ld l, a ; $68d1
	ld_bg_pals de, 4, 1 ; $68d2
	call LoadPaletteShadow ; $68d5
	ret ; $68d8
CourtSelect9PalettePtrs:
	; $68d9, 18 bytes (records:2)
	dw CourtSelect9Palette0 ; record 0
	dw CourtSelect9Palette1 ; record 1
	dw CourtSelect9Palette2 ; record 2
	dw CourtSelect9Palette3 ; record 3
	dw CourtSelect9Palette6 ; record 4
	dw CourtSelect9Palette5 ; record 5
	dw CourtSelect9Palette4 ; record 6
	dw CourtSelect9Palette7 ; record 7
	dw CourtSelect9Palette8 ; record 8
CourtSelect9Palette0:
	; $68eb, 8 bytes (bytes:8)
	db $40, $7d, $ff, $7f, $a0, $3c, $00, $00 ; 0x00
CourtSelect9Palette1:
	; $68f3, 8 bytes (bytes:8)
	db $1f, $00, $ff, $7f, $12, $00, $00, $00 ; 0x00
CourtSelect9Palette2:
	; $68fb, 8 bytes (bytes:8)
	db $e0, $01, $ff, $7f, $40, $01, $00, $00 ; 0x00
CourtSelect9Palette3:
	; $6903, 8 bytes (bytes:8)
	db $12, $48, $ff, $7f, $08, $00, $00, $00 ; 0x00
CourtSelect9Palette4:
	; $690b, 8 bytes (bytes:8)
	db $5e, $79, $ff, $6b, $40, $01, $00, $00 ; 0x00
CourtSelect9Palette5:
	; $6913, 8 bytes (bytes:8)
	db $c0, $2e, $ff, $6b, $12, $00, $00, $00 ; 0x00
CourtSelect9Palette6:
	; $691b, 8 bytes (bytes:8)
	db $1f, $01, $ff, $6b, $40, $01, $00, $00 ; 0x00
CourtSelect9Palette7:
	; $6923, 8 bytes (bytes:8)
	db $e0, $03, $ff, $6b, $40, $01, $00, $00 ; 0x00
CourtSelect9Palette8:
	; $692b, 47 bytes (bytes:8)
	db $1f, $01, $ff, $6b, $8f, $00, $00, $00 ; 0x00
	db $f0, $96, $f5, $3e, $03, $e0, $96, $e0 ; 0x08
	db $70, $0e, $03, $cd, $c9, $43, $47, $57 ; 0x10
	db $7a, $4f, $c5, $cd, $45, $60, $c1, $c5 ; 0x18
	db $cd, $6f, $60, $c1, $cd, $93, $60, $18 ; 0x20
	db $00, $f1, $e0, $96, $e0, $70, $c9 ; 0x28
StoreCourtUnlockBits:
	push_wram_bank WRAM_COURT_PLANES ; $695a
	ld c, $00 ; $6963
	ld hl, wScreenAttrmap ; $6965
.loop:
	ld a, b ; $6968
	and $01 ; $6969
	ld [hl+], a ; $696b
	srl b ; $696c
	ld a, c ; $696e
	inc a ; $696f
	ld c, a ; $6970
	cp $05 ; $6971
	jr nz, .loop ; $6973
	pop_wram_bank ; $6975
	ret ; $697a
IsCourtUnlocked:
	ld a, b ; $697b
	cp COURT_STAR ; $697c
	jr nc, .lookup ; $697e
	ld a, $01 ; $6980
	ret ; $6982
.lookup:
	push_wram_bank WRAM_COURT_PLANES ; $6983
	ld a, b ; $698c
	sub COURT_STAR ; $698d
	ld hl, wScreenAttrmap ; $698f
	add l ; $6992
	ld l, a ; $6993
	jr nc, .read ; $6994
	inc h ; $6996
.read:
	ld a, [hl] ; $6997
	ld b, a ; $6998
	pop_wram_bank ; $6999
	ld a, b ; $699e
	ret ; $699f
ComputeUnlockedCourtFlags:
	ld c, $00 ; $69a0
	ld b, $00 ; $69a2
.loop:
	ld a, c ; $69a4
	add a ; $69a5
	ld hl, CourtUnlockFlagIds_3e ; $69a6
	add l ; $69a9
	ld l, a ; $69aa
	jr nc, .read ; $69ab
	inc h ; $69ad
.read:
	ld a, [hl+] ; $69ae
	ld d, [hl] ; $69af
	ld e, a ; $69b0
	farcall TestSaveFlag ; $69b1
	jr z, .countDone ; $69b4
	ld a, $01 ; $69b6
	or b ; $69b8
	ld b, a ; $69b9
.countDone:
	ld a, c ; $69ba
	inc a ; $69bb
	ld c, a ; $69bc
	cp $05 ; $69bd
	jr z, .eq05 ; $69bf
	sla b ; $69c1
	jr .loop ; $69c3
.eq05:
	ld a, b ; $69c5
	ld [wUnlockedCourtMask], a ; $69c6
	ret ; $69c9
CourtUnlockFlagIds_3e:
	; $69ca, 10 bytes (flag_ids)
	flag_id FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL ; 0
	flag_id FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; 1
	flag_id FLAG_WON_DREAM_MATCH_SINGLES ; 2
	dw $0740 ; 3: flag $07, 2
	dw $0720 ; 4: flag $07, 1
StubNop_3e:
	ret ; $69d4
AwardCeremonyTiles:
	INCBIN "data/bank_03e/lz_AwardCeremonyTiles.bin" ; $69d5, 2641 bytes
AwardCeremonyPalettes:
	INCLUDE "data/bank_03e/AwardCeremonyPalettes.asm" ; $7426, 64 bytes (palettes)
AwardCeremonyTilemap5:
	INCBIN "data/bank_03e/lz_AwardCeremonyTilemap5.bin" ; $7466, 279 bytes
AwardCeremonyAttrmap5:
	INCBIN "data/bank_03e/lz_AwardCeremonyAttrmap5.bin" ; $757d, 107 bytes
N64TransferItemGfx4:
	INCBIN "data/bank_03e/lz_N64TransferItemGfx4.bin" ; $75e8, 179 bytes
N64TransferItemGfx5:
	INCBIN "data/bank_03e/lz_N64TransferItemGfx5.bin" ; $769b, 183 bytes
SavedDataSourceGfx5:
	INCBIN "data/bank_03e/lz_SavedDataSourceGfx5.bin" ; $7752, 179 bytes
	; $7805, 2043 bytes fill to bank end (linker-padded)
