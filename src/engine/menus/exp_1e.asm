ResultsScreenPalettes:
	INCLUDE "data/bank_01e/ResultsScreenPalettes.asm" ; $4c40, 48 bytes (palettes)
ResultsScreenGfx_1e:
	INCBIN "data/bank_01e/lz_ResultsScreenGfx_1e.bin" ; $4c70, 1455 bytes
ResultsScreenTilemap_1e:
	INCBIN "data/bank_01e/lz_ResultsScreenTilemap_1e.bin" ; $521f, 205 bytes
ResultsScreenAttrmap_1e:
	INCBIN "data/bank_01e/lz_ResultsScreenAttrmap_1e.bin" ; $52ec, 87 bytes
PanelFrameGfx_1e:
	INCBIN "data/bank_01e/lz_PanelFrameGfx_1e.bin" ; $5343, 156 bytes
	INCLUDE "data/bank_01e/lz_PanelFrameGfx_1e.inc" ; DEF PanelFrameGfx_1e_SIZE EQU its decoded length, generated from the .bin by make
ResultsSinglesLabelTilemap_1e:
	INCBIN "data/bank_01e/lz_ResultsSinglesLabelTilemap_1e.bin" ; $53df, 19 bytes
ResultsDoublesLabelTilemap_1e:
	INCBIN "data/bank_01e/lz_ResultsDoublesLabelTilemap_1e.bin" ; $53f2, 19 bytes
ResultsPlayerPanelTilemap_1e:
	INCBIN "data/bank_01e/lz_ResultsPlayerPanelTilemap_1e.bin" ; $5405, 28 bytes
ResultsPlayerPanelAttrmap_1e:
	INCBIN "data/bank_01e/lz_ResultsPlayerPanelAttrmap_1e.bin" ; $5421, 23 bytes
ShowExpAwardScreen:
	call HasPendingExpAwards ; $5438
	or a ; $543b
	ret z ; $543c
	farcall LoadMenuFontGfx ; $543d
	farcall InitTextWindows ; $5440
	ld hl, wShadowTilemapBank ; $5443
	ld [hl], $03 ; $5446
	farcall PrepareGlyphBuffer ; $5448
	call ClearFrameTasks ; $544b
	call DisableLCDSafely ; $544e
	xor a ; $5451
	ldh [hScrollX], a ; $5452
	ldh [hScrollY], a ; $5454
	ld [wCameraX], a ; $5456
	ld [wCameraX + 1], a ; $5459
	ld [wCameraY], a ; $545c
	ld [wCameraY + 1], a ; $545f
	ld a, $90 ; $5462
	ldh [rWY], a ; $5464
	call ClearSpriteQueue ; $5466
	farcall InitActorEngine ; $5469
	call InitExpAwardScreenState ; $546c
	call BuildExpAwardScreenTilemap ; $546f
	call InitResultsScreenCharacters ; $5472
	call EnableLCD ; $5475
	call AdvanceFrame ; $5478
	ld a, $01 ; $547b
	ld hl, DrawExpScreenCharSprites ; $547d
	call RegisterFrameTask ; $5480
	ld a, $01 ; $5483
	ld hl, DrawExpTotalDigits ; $5485
	call RegisterFrameTask ; $5488
	script_fade_in $10 ; $548b
	call WaitFadeEnd ; $5490
	wait_frames $14 ; $5493
	call RunExpAwardSequence ; $5497
	ld c, $10 ; $549a
	call BeginFadeOut ; $549c
	call WaitFadeEnd ; $549f
	ld hl, DrawExpScreenCharSprites ; $54a2
	call UnregisterFrameTask ; $54a5
	ld hl, DrawExpTotalDigits ; $54a8
	call UnregisterFrameTask ; $54ab
	wram_bank WRAM_SCENE ; $54ae
	ld hl, wExpAwardRunningTotal ; $54b4
	ld a, [hl+] ; $54b7
	ld h, [hl] ; $54b8
	ld l, a ; $54b9
	ret ; $54ba
InitExpAwardScreenState:
	wram_bank WRAM_SCENE ; $54bb
	xor a ; $54c1
	ld hl, wExpAwardScreenState ; $54c2
	ld d, $05 ; $54c5
	call FillMemoryD ; $54c7
	ld a, $20 ; $54ca
	ld d, $04 ; $54cc
	call FillMemoryD ; $54ce
	ld a, $30 ; $54d1
	ld [hl+], a ; $54d3
	xor a ; $54d4
	ld d, $0b ; $54d5
	call FillMemoryD ; $54d7
	ld a, $20 ; $54da
	ld d, $04 ; $54dc
	call FillMemoryD ; $54de
	ld a, $30 ; $54e1
	ld [hl+], a ; $54e3
	xor a ; $54e4
	ld d, $0a ; $54e5
	call FillMemoryD ; $54e7
	ld a, $01 ; $54ea
	ld [wContinuePromptKind], a ; $54ec
	ret ; $54ef
FillMemoryD:
	ld [hl+], a ; $54f0
	dec d ; $54f1
	jr nz, FillMemoryD ; $54f2
	ret ; $54f4
BuildExpAwardScreenTilemap:
	call LoadExpAwardScreenGraphics ; $54f5
	call DrawExpAwardScreenPanels ; $54f8
	wram_bank WRAM_SCREEN ; $54fb
	ld hl, wShadowTilemap ; $5501
	ld de, vBGMap0 ; $5504
	ld c, SCREEN_HEIGHT * TILEMAP_WIDTH / 16 ; $5507
	call QueueVRAMCopy ; $5509
	wram_bank WRAM_COURT_PLANES ; $550c
	ld hl, wScreenAttrmap ; $5512
	ld de, vBGMap0 + VRAM_BANK1 ; $5515
	ld c, SCREEN_HEIGHT * TILEMAP_WIDTH / 16 ; $5518
	call QueueVRAMCopy ; $551a
	ret ; $551d
LoadExpAwardScreenGraphics:
	ld hl, ExpAwardScreenPalettes0 ; $551e
	ld_bg_pals de, 0, 3 ; $5521
	call LoadPaletteShadow ; $5524
	wram_bank WRAM_STAGING ; $5527
	ld hl, ExpAwardScreenGfx_1e ; $552d
	ld de, wDecompBuffer ; $5530
	call DecompressData ; $5533
	ld hl, wDecompBuffer ; $5536
	ld de, vTiles2 + VRAM_BANK1 ; $5539
	ld c, $80 ; $553c -- 128 of ExpAwardScreenGfx_1e's 256 tiles
	call QueueVRAMCopy ; $553e
	ld hl, wTextTileBuffer ; $5541
	ld de, vTiles1 + VRAM_BANK1 ; $5544
	ld c, wTextTileBuffer_SIZE / 16 ; $5547
	call QueueVRAMCopy ; $5549
	wram_bank WRAM_STAGING ; $554c
	ld hl, ExpAwardScreenTilemap_1e ; $5552
	ld de, wDecompBuffer ; $5555
	call DecompressData ; $5558
	ld hl, wDecompBuffer ; $555b
	ld bc, $0240 ; $555e
	call ExpScreenCopyToTilemap ; $5561
	wram_bank WRAM_STAGING ; $5564
	ld hl, ExpAwardScreenAttrmap_1e ; $556a
	ld de, wDecompBuffer ; $556d
	call DecompressData ; $5570
	ld hl, wDecompBuffer ; $5573
	ld bc, $0240 ; $5576
	call ExpScreenCopyToAttrmap ; $5579
	wram_bank WRAM_STAGING ; $557c
	ld hl, PanelFrameGfx_1e ; $5582
	ld de, wDecompBuffer ; $5585
	call DecompressData ; $5588
	ld hl, wDecompBuffer ; $558b
	ld de, vTiles2 ; $558e
	ld c, PanelFrameGfx_1e_SIZE / 16 ; $5591
	call QueueVRAMCopy ; $5593
	ld hl, ExpAwardScreenPalettes1 ; $5596
	ld_obj_pals de, 0, 1 ; $5599
	call LoadPaletteShadow ; $559c
	wram_bank WRAM_STAGING ; $559f
	ld hl, ExpDigitSpriteGfx_1e ; $55a5
	ld de, wDecompBuffer ; $55a8
	call DecompressData ; $55ab
	ld hl, wDecompBuffer ; $55ae
	ld de, vTiles0 + $6c * TILE_SIZE + VRAM_BANK1 ; $55b1
	ld c, ExpDigitSpriteGfx_1e_SIZE / 16 ; $55b4
	call QueueVRAMCopy ; $55b6
	ret ; $55b9
ExpScreenCopyToTilemap:
	wram_bank WRAM_STAGING ; $55ba
	ld d, [hl] ; $55c0
	wram_bank WRAM_SCREEN ; $55c1
	ld [hl], d ; $55c7
	inc hl ; $55c8
	dec bc ; $55c9
	ld a, b ; $55ca
	or c ; $55cb
	jr nz, ExpScreenCopyToTilemap ; $55cc
	ret ; $55ce
ExpScreenCopyToAttrmap:
	wram_bank WRAM_STAGING ; $55cf
	ld d, [hl] ; $55d5
	wram_bank WRAM_COURT_PLANES ; $55d6
	ld [hl], d ; $55dc
	inc hl ; $55dd
	dec bc ; $55de
	ld a, b ; $55df
	or c ; $55e0
	jr nz, ExpScreenCopyToAttrmap ; $55e1
	ret ; $55e3
DrawExpAwardScreenPanels:
	call DrawExpMessageWindow ; $55e4
	call DrawNextExpAwardMessage ; $55e7
	call DrawExpTotalPanel ; $55ea
	test_flag FLAG_TEMP_RESULTS_SCREEN_OPEN ; $55ed
	jr nz, .drawExpDoublesPlayerPanel ; $55f0
	call DrawExpSinglesPlayerPanel ; $55f2
	ret ; $55f5
.drawExpDoublesPlayerPanel:
	call DrawExpDoublesPlayerPanel ; $55f6
	call DrawExpDoublesPartnerPanel ; $55f9
	ret ; $55fc
DrawExpSinglesPlayerPanel:
	ld hl, wShadowTilemap + 5 * TILEMAP_WIDTH + 3 ; $55fd
	ld b, $02 ; $5600
	ld c, $01 ; $5602
	call FillTilemapRun ; $5604
	ld b, $03 ; $5607
	ld c, $0c ; $5609
	call FillTilemapRun ; $560b
	ld b, $04 ; $560e
	ld c, $01 ; $5610
	call FillTilemapRun ; $5612
	ld hl, wScreenAttrmap + 6 * TILEMAP_WIDTH + 3 ; $5615
	ld b, $05 ; $5618
	ld c, $01 ; $561a
	call FillTilemapRun ; $561c
	ld b, $20 ; $561f
	ld c, $0c ; $5621
	call FillTilemapRun ; $5623
	ld b, $06 ; $5626
	ld c, $01 ; $5628
	call FillTilemapRun ; $562a
	ld hl, wScreenAttrmap + 7 * TILEMAP_WIDTH + 3 ; $562d
	ld b, $07 ; $5630
	ld c, $01 ; $5632
	call FillTilemapRun ; $5634
	ld b, $08 ; $5637
	ld c, $0c ; $5639
	call FillTilemapRun ; $563b
	ld b, $09 ; $563e
	ld c, $01 ; $5640
	call FillTilemapRun ; $5642
	ld bc, wPlayer1MainName ; $5645
	ld a, [wLinkMatchRole] ; $5648
	cp LINKSTATE_SLAVE ; $564b
	jr nz, .ne02 ; $564d
	ld bc, wPlayer2MainName ; $564f
	ld a, [wLinkMatchCharLevel] ; $5652
	ld [wPlayer2MainExpTier], a ; $5655
.ne02:
	push bc ; $5658
	ld hl, CHARREC_NAME ; $5659
	add hl, bc ; $565c
	call CopyStringToTextBuffer ; $565d
	ld de, wScreenAttrmap + 6 * TILEMAP_WIDTH + 4 ; $5660
	ld bc, $0020 ; $5663
	call WriteTextToTilemap ; $5666
	ld hl, Text_31_228 ; $5669
	ld de, wShadowTilemap + 6 * TILEMAP_WIDTH + 12 ; $566c
	ld bc, $0020 ; $566f
	call FetchAndDrawDialogueText ; $5672
	pop bc ; $5675
	ld hl, CHARREC_EXP_TIER ; $5676
	add hl, bc ; $5679
	ld a, [hl] ; $567a
	ld h, $00 ; $567b
	ld l, a ; $567d
	ld a, $02 ; $567e
	ld bc, $0020 ; $5680
	ld de, wTextBuffer ; $5683
	call FormatDecimalNumberUnsigned ; $5686
	ld hl, wTextBuffer ; $5689
	ld de, wShadowTilemap + 6 * TILEMAP_WIDTH + 14 ; $568c
	call WriteTextToTilemap ; $568f
	ret ; $5692
DrawExpDoublesPlayerPanel:
	ld hl, wShadowTilemap + 5 * TILEMAP_WIDTH ; $5693
	ld_tile_run bc, $02, $01 ; $5696
	call FillTilemapRun ; $5699
	ld_tile_run bc, $03, $07 ; $569c
	call FillTilemapRun ; $569f
	ld_tile_run bc, $04, $01 ; $56a2
	call FillTilemapRun ; $56a5
	ld hl, wScreenAttrmap + 6 * TILEMAP_WIDTH ; $56a8
	ld_tile_run bc, $05, $01 ; $56ab
	call FillTilemapRun ; $56ae
	ld_tile_run bc, $20, $07 ; $56b1
	call FillTilemapRun ; $56b4
	ld_tile_run bc, $06, $01 ; $56b7
	call FillTilemapRun ; $56ba
	ld hl, wScreenAttrmap + 7 * TILEMAP_WIDTH ; $56bd
	ld_tile_run bc, $05, $01 ; $56c0
	call FillTilemapRun ; $56c3
	ld_tile_run bc, $20, $07 ; $56c6
	call FillTilemapRun ; $56c9
	ld_tile_run bc, $06, $01 ; $56cc
	call FillTilemapRun ; $56cf
	ld hl, wScreenAttrmap + 8 * TILEMAP_WIDTH ; $56d2
	ld_tile_run bc, $05, $01 ; $56d5
	call FillTilemapRun ; $56d8
	ld_tile_run bc, $20, $07 ; $56db
	call FillTilemapRun ; $56de
	ld_tile_run bc, $06, $01 ; $56e1
	call FillTilemapRun ; $56e4
	ld hl, wScreenAttrmap + 9 * TILEMAP_WIDTH ; $56e7
	ld_tile_run bc, $07, $01 ; $56ea
	call FillTilemapRun ; $56ed
	ld_tile_run bc, $08, $07 ; $56f0
	call FillTilemapRun ; $56f3
	ld_tile_run bc, $09, $01 ; $56f6
	call FillTilemapRun ; $56f9
	ld a, [wGameMode] ; $56fc
	or a ; $56ff
	jr nz, .nonZero ; $5700
	ld bc, wStoryModeNameOfMainCharacter ; $5702
	jr .copyStringToTextBuffer ; $5705
.nonZero:
	ld bc, wPlayer1MainName ; $5707
	ld a, [wLinkMatchRole] ; $570a
	cp LINKSTATE_SLAVE ; $570d
	jr nz, .copyStringToTextBuffer ; $570f
	ld bc, wPlayer2MainName ; $5711
	ld a, [wLinkMatchCharLevel] ; $5714
	ld [wPlayer2MainExpTier], a ; $5717
.copyStringToTextBuffer:
	push bc ; $571a
	ld hl, CHARREC_NAME ; $571b
	add hl, bc ; $571e
	call CopyStringToTextBuffer ; $571f
	ld de, wScreenAttrmap + 6 * TILEMAP_WIDTH + 1 ; $5722
	ld bc, $0020 ; $5725
	call WriteTextToTilemap ; $5728
	ld hl, Text_31_228 ; $572b
	ld de, wShadowTilemap + 8 * TILEMAP_WIDTH + 1 ; $572e
	ld bc, $0020 ; $5731
	call FetchAndDrawDialogueText ; $5734
	pop bc ; $5737
	ld hl, CHARREC_EXP_TIER ; $5738
	add hl, bc ; $573b
	ld a, [hl] ; $573c
	ld h, $00 ; $573d
	ld l, a ; $573f
	ld a, $02 ; $5740
	ld bc, $0020 ; $5742
	ld de, wTextBuffer ; $5745
	call FormatDecimalNumberUnsigned ; $5748
	ld hl, wTextBuffer ; $574b
	ld de, wShadowTilemap + 8 * TILEMAP_WIDTH + 4 ; $574e
	ld bc, $0020 ; $5751
	call WriteTextToTilemap ; $5754
	ret ; $5757
DrawExpDoublesPartnerPanel:
	ld hl, wShadowTilemap + 5 * TILEMAP_WIDTH + 11 ; $5758
	ld_tile_run bc, $02, $01 ; $575b
	call FillTilemapRun ; $575e
	ld_tile_run bc, $03, $07 ; $5761
	call FillTilemapRun ; $5764
	ld_tile_run bc, $04, $01 ; $5767
	call FillTilemapRun ; $576a
	ld hl, wScreenAttrmap + 6 * TILEMAP_WIDTH + 11 ; $576d
	ld_tile_run bc, $05, $01 ; $5770
	call FillTilemapRun ; $5773
	ld_tile_run bc, $20, $07 ; $5776
	call FillTilemapRun ; $5779
	ld_tile_run bc, $06, $01 ; $577c
	call FillTilemapRun ; $577f
	ld hl, wScreenAttrmap + 7 * TILEMAP_WIDTH + 11 ; $5782
	ld_tile_run bc, $05, $01 ; $5785
	call FillTilemapRun ; $5788
	ld_tile_run bc, $20, $07 ; $578b
	call FillTilemapRun ; $578e
	ld_tile_run bc, $06, $01 ; $5791
	call FillTilemapRun ; $5794
	ld hl, wScreenAttrmap + 8 * TILEMAP_WIDTH + 11 ; $5797
	ld_tile_run bc, $05, $01 ; $579a
	call FillTilemapRun ; $579d
	ld_tile_run bc, $20, $07 ; $57a0
	call FillTilemapRun ; $57a3
	ld_tile_run bc, $06, $01 ; $57a6
	call FillTilemapRun ; $57a9
	ld hl, wScreenAttrmap + 9 * TILEMAP_WIDTH + 11 ; $57ac
	ld_tile_run bc, $07, $01 ; $57af
	call FillTilemapRun ; $57b2
	ld_tile_run bc, $08, $07 ; $57b5
	call FillTilemapRun ; $57b8
	ld_tile_run bc, $09, $01 ; $57bb
	call FillTilemapRun ; $57be
	ld a, [wGameMode] ; $57c1
	or a ; $57c4
	jr nz, .nonZero ; $57c5
	ld bc, wStoryModeNameOfPartnerCharacter ; $57c7
	jr .copyStringToTextBuffer ; $57ca
.nonZero:
	ld bc, wPlayer1PartnerName ; $57cc
	ld a, [wLinkMatchRole] ; $57cf
	cp LINKSTATE_SLAVE ; $57d2
	jr nz, .copyStringToTextBuffer ; $57d4
	ld bc, wPlayer2PartnerName ; $57d6
.copyStringToTextBuffer:
	push bc ; $57d9
	ld hl, CHARREC_NAME ; $57da
	add hl, bc ; $57dd
	call CopyStringToTextBuffer ; $57de
	ld de, wScreenAttrmap + 6 * TILEMAP_WIDTH + 12 ; $57e1
	ld bc, $0020 ; $57e4
	call WriteTextToTilemap ; $57e7
	ld hl, Text_31_228 ; $57ea
	ld de, wShadowTilemap + 8 * TILEMAP_WIDTH + 12 ; $57ed
	ld bc, $0020 ; $57f0
	call FetchAndDrawDialogueText ; $57f3
	pop bc ; $57f6
	ld hl, CHARREC_EXP_TIER ; $57f7
	add hl, bc ; $57fa
	ld a, [hl] ; $57fb
	ld h, $00 ; $57fc
	ld l, a ; $57fe
	ld a, $02 ; $57ff
	ld bc, $0020 ; $5801
	ld de, wTextBuffer ; $5804
	call FormatDecimalNumberUnsigned ; $5807
	ld hl, wTextBuffer ; $580a
	ld de, wShadowTilemap + 8 * TILEMAP_WIDTH + 15 ; $580d
	call WriteTextToTilemap ; $5810
	ret ; $5813
DrawExpTotalPanel:
	ld hl, wScreenAttrmap + 14 * TILEMAP_WIDTH + 2 ; $5814
	ld_tile_run bc, $02, $01 ; $5817
	call FillTilemapRun ; $581a
	ld_tile_run bc, $03, $08 ; $581d
	call FillTilemapRun ; $5820
	ld_tile_run bc, $04, $01 ; $5823
	call FillTilemapRun ; $5826
	ld_tile_run bc, $02, $01 ; $5829
	call FillTilemapRun ; $582c
	ld_tile_run bc, $03, $04 ; $582f
	call FillTilemapRun ; $5832
	ld_tile_run bc, $04, $01 ; $5835
	call FillTilemapRun ; $5838
	ld hl, wScreenAttrmap + 15 * TILEMAP_WIDTH + 2 ; $583b
	ld_tile_run bc, $05, $01 ; $583e
	call FillTilemapRun ; $5841
	ld_tile_run bc, $20, $08 ; $5844
	call FillTilemapRun ; $5847
	ld_tile_run bc, $06, $01 ; $584a
	call FillTilemapRun ; $584d
	ld_tile_run bc, $05, $01 ; $5850
	call FillTilemapRun ; $5853
	ld_tile_run bc, $20, $04 ; $5856
	call FillTilemapRun ; $5859
	ld_tile_run bc, $06, $01 ; $585c
	call FillTilemapRun ; $585f
	ld hl, wScreenAttrmap + 16 * TILEMAP_WIDTH + 2 ; $5862
	ld_tile_run bc, $07, $01 ; $5865
	call FillTilemapRun ; $5868
	ld_tile_run bc, $08, $08 ; $586b
	call FillTilemapRun ; $586e
	ld_tile_run bc, $09, $01 ; $5871
	call FillTilemapRun ; $5874
	ld_tile_run bc, $07, $01 ; $5877
	call FillTilemapRun ; $587a
	ld_tile_run bc, $08, $04 ; $587d
	call FillTilemapRun ; $5880
	ld_tile_run bc, $09, $01 ; $5883
	call FillTilemapRun ; $5886
	ld hl, Text_31_231 ; $5889
	ld de, wScreenAttrmap + 15 * TILEMAP_WIDTH + 3 ; $588c
	ld bc, $0020 ; $588f
	call FetchAndDrawDialogueText ; $5892
	ret ; $5895
DrawExpMessageWindow:
	ld hl, wScreenAttrmap ; $5896
	ld_tile_run bc, $02, $01 ; $5899
	call FillTilemapRun ; $589c
	ld_tile_run bc, $03, $12 ; $589f
	call FillTilemapRun ; $58a2
	ld_tile_run bc, $04, $01 ; $58a5
	call FillTilemapRun ; $58a8
	ld hl, wScreenAttrmap + 1 * TILEMAP_WIDTH ; $58ab
	ld_tile_run bc, $05, $01 ; $58ae
	call FillTilemapRun ; $58b1
	ld_tile_run bc, $20, $12 ; $58b4
	call FillTilemapRun ; $58b7
	ld_tile_run bc, $06, $01 ; $58ba
	call FillTilemapRun ; $58bd
	ld hl, wScreenAttrmap + 2 * TILEMAP_WIDTH ; $58c0
	ld_tile_run bc, $05, $01 ; $58c3
	call FillTilemapRun ; $58c6
	ld_tile_run bc, $20, $12 ; $58c9
	call FillTilemapRun ; $58cc
	ld_tile_run bc, $06, $01 ; $58cf
	call FillTilemapRun ; $58d2
	ld hl, wScreenAttrmap + 3 * TILEMAP_WIDTH ; $58d5
	ld_tile_run bc, $05, $01 ; $58d8
	call FillTilemapRun ; $58db
	ld_tile_run bc, $20, $12 ; $58de
	call FillTilemapRun ; $58e1
	ld_tile_run bc, $06, $01 ; $58e4
	call FillTilemapRun ; $58e7
	ld hl, wScreenAttrmap + 4 * TILEMAP_WIDTH ; $58ea
	ld_tile_run bc, $07, $01 ; $58ed
	call FillTilemapRun ; $58f0
	ld_tile_run bc, $08, $12 ; $58f3
	call FillTilemapRun ; $58f6
	ld_tile_run bc, $09, $01 ; $58f9
	call FillTilemapRun ; $58fc
	ret ; $58ff
FillTilemapRun:
	wram_bank WRAM_SCREEN ; $5900
	ld [hl], b ; $5906
	wram_bank WRAM_COURT_PLANES ; $5907
	ld a, $00 ; $590d
	ld [hl+], a ; $590f
	dec c ; $5910
	jr nz, FillTilemapRun ; $5911
	ret ; $5913
DrawExpScreenCharSprites:
	ld b, $04 ; $5914
	ld a, [wLinkMatchRole] ; $5916
	or a ; $5919
	jr z, .zero ; $591a
	srl a ; $591c
	add b ; $591e
	ld b, a ; $591f
.zero:
	push bc ; $5920
	ld a, b ; $5921
	wram_bank ; $5922
	xor a ; $5926
	call UpdateExpScreenCharSprite ; $5927
	ld hl, wCharSpriteSlot ; $592a
	farcall DrawCharSprite ; $592d
	wram_bank WRAM_ACTORS ; $5930
	pop bc ; $5936
	test_flag FLAG_TEMP_RESULTS_SCREEN_OPEN ; $5937
	ret z ; $593a
	inc b ; $593b
	inc b ; $593c
	ld a, b ; $593d
	wram_bank ; $593e
	ld a, $01 ; $5942
	call UpdateExpScreenCharSprite ; $5944
	ld hl, wCharSpriteSlot ; $5947
	farcall DrawCharSprite ; $594a
	wram_bank WRAM_CHAR0 ; $594d
	ret ; $5953
UpdateExpScreenCharSprite:
	push af ; $5954
	ld hl, wCharPosX ; $5955
	ld b, h ; $5958
	ld c, l ; $5959
	farcall StepCharAnimation ; $595a
	ld d, $00 ; $595d
	ld a, d ; $595f
	ld [wCharFacingOctant], a ; $5960
	farcall ReloadCharFacingTiles ; $5963
	ld a, [wCharFacingOctant] ; $5966
	ld_hl_indexed UpdateExpScreenCharSpriteTable ; $5969
	ld a, [wCharSpriteAttr] ; $5970
	or $08 ; $5973
	xor [hl] ; $5975
	ld b, a ; $5976
	pop af ; $5977
	push af ; $5978
	or a ; $5979
	jr nz, .nonZero ; $597a
	ld a, [wPlayer1MainLeftHanded] ; $597c
	jr .compare ; $597f
.nonZero:
	ld a, [wPlayer2MainLeftHanded] ; $5981
.compare:
	or a ; $5984
	jr z, .zero ; $5985
	ld a, $20 ; $5987
	xor b ; $5989
	ld b, a ; $598a
.zero:
	ld a, [wCharTileBase] ; $598b
	ld c, a ; $598e
	pop af ; $598f
	or a ; $5990
	jr nz, .nonZero2 ; $5991
	test_flag FLAG_TEMP_RESULTS_SCREEN_OPEN ; $5993
	jr z, .notTempResultsScreenOpen ; $5996
	ld d, $44 ; $5998
	ld e, $66 ; $599a
	jr .step5 ; $599c
.notTempResultsScreenOpen:
	ld d, $50 ; $599e
	ld e, $66 ; $59a0
	jr .step5 ; $59a2
.nonZero2:
	ld d, $5c ; $59a4
	ld e, $66 ; $59a6
.step5:
	ld hl, wCharSpriteSlot ; $59a8
	ld a, c ; $59ab
	ld [hl+], a ; $59ac
	ld a, b ; $59ad
	ld [hl+], a ; $59ae
	ld a, e ; $59af
	ld [hl+], a ; $59b0
	ld [hl], d ; $59b1
	ret ; $59b2
UpdateExpScreenCharSpriteTable:
	; $59b3, 8 bytes (bytes:8)
	db $00, $00, $00, $20, $20, $20, $00, $00 ; 0x00
DrawNextExpAwardMessage:
	wram_bank WRAM_SCENE ; $59bb
	ld a, [wExpAwardIndex] ; $59c1
	cp $05 ; $59c4
	jr z, .uploadGlyphBuffer ; $59c6
	rlca ; $59c8
	add $52 ; $59c9
	ld l, a ; $59cb
	adc $d1 ; $59cc
	sub l ; $59ce
	ld h, a ; $59cf
	ld a, [hl+] ; $59d0
	ld b, [hl] ; $59d1
	or b ; $59d2
	jr z, .zero ; $59d3
	dec hl ; $59d5
	ld c, [hl] ; $59d6
	push bc ; $59d7
	ld a, [wExpAwardIndex] ; $59d8
	add $5c ; $59db
	ld l, a ; $59dd
	adc $d1 ; $59de
	sub l ; $59e0
	ld h, a ; $59e1
	ld a, [hl] ; $59e2
	ld d, a ; $59e3
	ld a, [wExpAwardIndex] ; $59e4
	rlca ; $59e7
	ld_hl_indexed DrawNextExpAwardMessageTable ; $59e8
	ld a, [hl+] ; $59ef
	ld h, [hl] ; $59f0
	ld l, a ; $59f1
	ld a, d ; $59f2
	add l ; $59f3
	ld l, a ; $59f4
	jr nc, .drawExpMessageWindow ; $59f5
	inc h ; $59f7
.drawExpMessageWindow:
	push hl ; $59f8
	call DrawExpMessageWindow ; $59f9
	wram_bank WRAM_SCENE ; $59fc
	ld hl, wExpAwardRunningTotal ; $5a02
	ld a, [hl+] ; $5a05
	ld d, [hl] ; $5a06
	or d ; $5a07
	jr z, .drawProportionalTextLine ; $5a08
	ld hl, Text_31_200 ; $5a0a
	ld de, wScreenAttrmap + 1 * TILEMAP_WIDTH + 2 ; $5a0d
	ld bc, $0020 ; $5a10
	call DrawProportionalTextLine ; $5a13
	jr .restore ; $5a16
.drawProportionalTextLine:
	ld hl, Text_31_199 ; $5a18
	ld de, wScreenAttrmap + 1 * TILEMAP_WIDTH + 2 ; $5a1b
	ld bc, $0020 ; $5a1e
	call DrawProportionalTextLine ; $5a21
.restore:
	pop hl ; $5a24
	ld bc, $0020 ; $5a25
	ld de, wScreenAttrmap + 3 * TILEMAP_WIDTH + 2 ; $5a28
	call DrawProportionalTextLine ; $5a2b
	pop bc ; $5a2e
	farcall UploadGlyphBuffer ; $5a2f
	ld a, $01 ; $5a32
	ret ; $5a34
.zero:
	ld a, [wExpAwardIndex] ; $5a35
	inc a ; $5a38
	ld [wExpAwardIndex], a ; $5a39
	jp DrawNextExpAwardMessage ; $5a3c
.uploadGlyphBuffer:
	farcall UploadGlyphBuffer ; $5a3f
	xor a ; $5a42
	ret ; $5a43
DrawNextExpAwardMessageTable:
	; $5a44, 10 bytes (bytes:10)
	db $c9, $04, $ca, $04, $cb, $04, $cc, $04, $d1, $04 ; 0x00
DrawExpTotalDigits:
	wram_bank WRAM_SCENE ; $5a4e
	ld hl, wExpAwardRunningTotal ; $5a54
	ld a, [hl+] ; $5a57
	ld h, [hl] ; $5a58
	ld l, a ; $5a59
	ld a, $04 ; $5a5a
	ld de, wTextBuffer ; $5a5c
	call FormatDecimalNumberUnsigned ; $5a5f
	ld a, [wTextBuffer + 4] ; $5a62
	or a ; $5a65
	jr nz, .checkTextBuffer ; $5a66
	ld a, [wTextBuffer] ; $5a68
	cp $20 ; $5a6b
	jr z, .eq20 ; $5a6d
	call GetDigitSpriteTile ; $5a6f
	ld_xy de, $6b, $77 ; $5a72
	call QueueSprite ; $5a75
.eq20:
	ld a, [wTextBuffer + 1] ; $5a78
	cp $20 ; $5a7b
	jr z, .eq202 ; $5a7d
	call GetDigitSpriteTile ; $5a7f
	ld_xy de, $73, $77 ; $5a82
	call QueueSprite ; $5a85
.eq202:
	ld a, [wTextBuffer + 2] ; $5a88
	cp $20 ; $5a8b
	jr z, .eq203 ; $5a8d
	call GetDigitSpriteTile ; $5a8f
	ld_xy de, $7b, $77 ; $5a92
	call QueueSprite ; $5a95
.eq203:
	ld a, [wTextBuffer + 3] ; $5a98
	cp $20 ; $5a9b
	jr z, .done ; $5a9d
	call GetDigitSpriteTile ; $5a9f
	ld_xy de, $83, $77 ; $5aa2
	call QueueSprite ; $5aa5
.done:
	ret ; $5aa8
.checkTextBuffer:
	ld a, [wTextBuffer] ; $5aa9
	cp $20 ; $5aac
	jr z, .eq204 ; $5aae
	call GetDigitSpriteTile ; $5ab0
	ld_xy de, $67, $77 ; $5ab3
	call QueueSprite ; $5ab6
.eq204:
	ld a, [wTextBuffer + 1] ; $5ab9
	cp $20 ; $5abc
	jr z, .eq205 ; $5abe
	call GetDigitSpriteTile ; $5ac0
	ld_xy de, $6f, $77 ; $5ac3
	call QueueSprite ; $5ac6
.eq205:
	ld a, [wTextBuffer + 2] ; $5ac9
	cp $20 ; $5acc
	jr z, .eq206 ; $5ace
	call GetDigitSpriteTile ; $5ad0
	ld_xy de, $77, $77 ; $5ad3
	call QueueSprite ; $5ad6
.eq206:
	ld a, [wTextBuffer + 3] ; $5ad9
	cp $20 ; $5adc
	jr z, .eq207 ; $5ade
	call GetDigitSpriteTile ; $5ae0
	ld_xy de, $7f, $77 ; $5ae3
	call QueueSprite ; $5ae6
.eq207:
	ld a, [wTextBuffer + 4] ; $5ae9
	cp $20 ; $5aec
	jr z, .doneB ; $5aee
	call GetDigitSpriteTile ; $5af0
	ld_xy de, $87, $77 ; $5af3
	call QueueSprite ; $5af6
.doneB:
	ret ; $5af9
