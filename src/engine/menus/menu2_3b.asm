RunMainMenu:
	call InitSerialLink ; $55d1
	sound BGM_MENU ; $55d4
	ld hl, rIE ; $55d6
	res 2, [hl] ; $55d9
	call BuildSaveSlotSummaries ; $55db
	xor a ; $55de
	ld [wCheatCodeLength], a ; $55df
	call LoadMainMenuGfx ; $55e2
	farcall InitMenuBgScroll ; $55e5
	ld b, $01 ; $55e8
	ld c, $01 ; $55ea
	farcall LoadMenuSpritePalettePair ; $55ec
	ld b, $03 ; $55ef
	ld a, [wMainMenuCursor] ; $55f1
	ld c, a ; $55f4
	call SetMenuCursorFromIndex_3b ; $55f5
	ld a, $00 ; $55f8
	ld [wMenuBgScrollTile + 1], a ; $55fa
	ld a, $01 ; $55fd
	ld [wMenuBgScrollAttr + 1], a ; $55ff
	wram_bank WRAM_SCREEN ; $5602
	ld a, [wMenuSlideDirection] ; $5608
	ld b, a ; $560b
	call MainMenuSlideIn ; $560c
	ld a, $7f ; $560f
	ld hl, MainMenuCursorSpriteTask ; $5611
	call RegisterFrameTask ; $5614
	call DrawMainMenuSelection ; $5617
	call ResetSerialState ; $561a
	farcall ResetCheatCodeBuffer ; $561d
	wram_bank WRAM_SCREEN ; $5620
.loop:
	call AdvanceFrame ; $5626
	farcall UpdateCheatCodeEntry ; $5629
	ldh a, [hInputPressed] ; $562c
	ld [wMenuInputPressed], a ; $562e
	ld b, $03 ; $5631
	ld c, $03 ; $5633
	call MoveMenuCursorGrid_3b ; $5635
	or a ; $5638
	jr nz, .playSfx ; $5639
	jr .checkMenuInputPressed ; $563b
.playSfx:
	sound SFX_MENU_MOVE ; $563d
	call DrawMainMenuSelection ; $563f
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $5642
	bit PADB_A, a ; $5645
	jr nz, .clearFrameTasks ; $5647
	bit 1, a ; $5649
	jr nz, .playSfx2 ; $564b
	bit 2, a ; $564d
	jr nz, .bit2Set ; $564f
	jr .loop ; $5651
.bit2Set:
	jr .loop ; $5653
.clearFrameTasks:
	ld a, $01 ; $5655
	ld [wCheatUnlockTriggered], a ; $5657
	sound SFX_MENU_SELECT ; $565a
	call ClearFrameTasks ; $565c
	ld hl, rIE ; $565f
	set 2, [hl] ; $5662
	ld b, $01 ; $5664
	call MainMenuSlideOut ; $5666
	ld a, [wMenuCursorX] ; $5669
	cp $02 ; $566c
	jr nz, .storeMenuSlideDirection ; $566e
	ld a, [wMenuCursorY] ; $5670
	cp $00 ; $5673
	jr nz, .storeMenuSlideDirection ; $5675
	ld c, $03 ; $5677
	call GetMenuCursorIndex_3b ; $5679
	ld [wMainMenuCursor], a ; $567c
	call TryMainMenuLinkHandshake ; $567f
	jp c, RunMainMenu ; $5682
.storeMenuSlideDirection:
	ld a, MENUSLIDE_FORWARD ; $5685
	ld [wMenuSlideDirection], a ; $5687
	ld c, $03 ; $568a
	call GetMenuCursorIndex_3b ; $568c
	ld [wMainMenuCursor], a ; $568f
	call MapMainMenuCursorToItemId ; $5692
	ret ; $5695
.playSfx2:
	sound SFX_MENU_CANCEL ; $5696
	call ResetSerialState ; $5698
	call ClearFrameTasks ; $569b
	ld hl, rIE ; $569e
	set 2, [hl] ; $56a1
	ld b, $00 ; $56a3
	call MainMenuSlideOut ; $56a5
	ld a, MENUSLIDE_BACK ; $56a8
	ld [wMenuSlideDirection], a ; $56aa
	ld a, $ff ; $56ad
	ret ; $56af
MapMainMenuCursorToItemId:
	ld hl, MapMainMenuCursorToItemIdTable ; $56b0
	add l ; $56b3
	ld l, a ; $56b4
	jr nc, .read ; $56b5
	inc h ; $56b7
.read:
	ld a, [hl] ; $56b8
	ret ; $56b9
MapMainMenuCursorToItemIdTable:
	; $56ba, 9 bytes (bytes:3)
	db $03, $04, $05 ; 0x00
	db $00, $01, $02 ; 0x03
	db $06, $07, $08 ; 0x06
	ret ; $56c3
LoadMainMenuGfx:
	push_wram_bank WRAM_STAGING ; $56c4
	ld c, $00 ; $56cd
.loop:
	ld a, c ; $56cf
	add a ; $56d0
	ld hl, MainMenuTable0 ; $56d1
	add l ; $56d4
	ld l, a ; $56d5
	jr nc, .read ; $56d6
	inc h ; $56d8
.read:
	ld a, [hl+] ; $56d9
	ld h, [hl] ; $56da
	ld l, a ; $56db
	push af ; $56dc
	push bc ; $56dd
	push de ; $56de
	push hl ; $56df
	ld de, wDecompBuffer ; $56e0
	call DecompressDataFromBank ; $56e3
	pop hl ; $56e6
	pop de ; $56e7
	pop bc ; $56e8
	pop af ; $56e9
	ld hl, MainMenuTable1 ; $56ea
	ld a, c ; $56ed
	add a ; $56ee
	add l ; $56ef
	ld l, a ; $56f0
	jr nc, .readB ; $56f1
	inc h ; $56f3
.readB:
	ld a, [hl+] ; $56f4
	ld d, [hl] ; $56f5
	ld e, a ; $56f6
	ld hl, wDecompBuffer ; $56f7
	push af ; $56fa
	push bc ; $56fb
	push de ; $56fc
	push hl ; $56fd
	ld bc, $0010 ; $56fe
	call QueueVRAMCopy ; $5701
	pop hl ; $5704
	pop de ; $5705
	pop bc ; $5706
	pop af ; $5707
	ld a, c ; $5708
	inc a ; $5709
	ld c, a ; $570a
	call AdvanceFrame ; $570b
	ld a, c ; $570e
	cp $06 ; $570f
	jr nz, .loop ; $5711
	wram_bank WRAM_SCREEN ; $5713
	ld a, $00 ; $5719
	ld [wCurrentStorySlot], a ; $571b
	ld a, [wShadowTilemap + 24 * TILEMAP_WIDTH] ; $571e
	farcall LoadCharMugshotToBuffer ; $5721
	ld de, $9680 + VRAM_BANK1 ; $5724
	farcall CopyMugshotBufferToVram ; $5727
	call AdvanceFrame ; $572a
	wram_bank WRAM_SCREEN ; $572d
	ld a, $01 ; $5733
	ld [wCurrentStorySlot], a ; $5735
	ld a, [wShadowTilemap + 24 * TILEMAP_WIDTH + 16] ; $5738
	farcall LoadCharMugshotToBuffer ; $573b
	ld de, $9710 + VRAM_BANK1 ; $573e
	farcall CopyMugshotBufferToVram ; $5741
	call AdvanceFrame ; $5744
	wram_bank WRAM_SCREEN ; $5747
	ld a, $02 ; $574d
	ld [wCurrentStorySlot], a ; $574f
	ld a, [wShadowTilemap + 25 * TILEMAP_WIDTH] ; $5752
	farcall LoadCharMugshotToBuffer ; $5755
	ld de, $8f00 + VRAM_BANK1 ; $5758
	farcall CopyMugshotBufferToVram ; $575b
	call AdvanceFrame ; $575e
	ld b, TILEBLOCK_MainMenuGfx0 ; $5761
	ld c, MainMenuGfx0_SIZE / 16 ; $5763
	ld de, vTiles0 + VRAM_BANK1 ; $5765
	farcall LoadCompressedTileBlock ; $5768
	call AdvanceFrame ; $576b
	ld b, TILEBLOCK_SharedMenuGfx29 ; $576e
	ld c, SharedMenuGfx29_SIZE / 16 ; $5770
	ld de, vTiles0 + $10 * TILE_SIZE + VRAM_BANK1 ; $5772
	farcall LoadCompressedTileBlock ; $5775
	call AdvanceFrame ; $5778
	ld b, TILEBLOCK_SharedMenuGfx30 ; $577b
	ld c, SharedMenuGfx30_SIZE / 16 ; $577d
	ld de, vTiles0 + $20 * TILE_SIZE + VRAM_BANK1 ; $577f
	farcall LoadCompressedTileBlock ; $5782
	call AdvanceFrame ; $5785
	ld b, TILEBLOCK_MainMenuGfx1 ; $5788
	ld c, MainMenuGfx1_SIZE / 16 ; $578a
	ld de, vTiles0 + $32 * TILE_SIZE + VRAM_BANK1 ; $578c
	farcall LoadCompressedTileBlock ; $578f
	call AdvanceFrame ; $5792
	ld b, TILEBLOCK_MainMenuGfx2 ; $5795
	ld c, MainMenuGfx2_SIZE / 16 ; $5797
	ld de, vTiles0 + $42 * TILE_SIZE + VRAM_BANK1 ; $5799
	farcall LoadCompressedTileBlock ; $579c
	call AdvanceFrame ; $579f
	ld b, TILEBLOCK_MainMenuGfx3 ; $57a2
	ld c, MainMenuGfx3_SIZE / 16 ; $57a4
	ld de, vTiles0 + $52 * TILE_SIZE + VRAM_BANK1 ; $57a6
	farcall LoadCompressedTileBlock ; $57a9
	call AdvanceFrame ; $57ac
	ld b, TILEBLOCK_MainMenuGfx4 ; $57af
	ld c, MainMenuGfx4_SIZE / 16 ; $57b1
	ld de, vTiles0 + $62 * TILE_SIZE + VRAM_BANK1 ; $57b3
	farcall LoadCompressedTileBlock ; $57b6
	call AdvanceFrame ; $57b9
	ld b, TILEBLOCK_SharedMenuGfx27 ; $57bc
	ld c, SharedMenuGfx27_SIZE / 16 ; $57be
	ld de, vTiles0 + $72 * TILE_SIZE + VRAM_BANK1 ; $57c0
	farcall LoadCompressedTileBlock ; $57c3
	ld b, $08 ; $57c6
	ld c, $10 ; $57c8
	farcall LoadIndexedPalette ; $57ca
	call AdvanceFrame ; $57cd
	ld b, TILEBLOCK_MainMenuGfx5Alias4 ; $57d0
	ld c, MainMenuGfx5_SIZE / 16 ; $57d2
	ld de, vTiles0 ; $57d4
	farcall LoadCompressedTileBlock ; $57d7
	pop_wram_bank ; $57da
	ret ; $57df
MainMenuTable0:
	; $57e0, 12 bytes (bytes:2)
	db $12, $3c ; 0x00
	db $14, $3c ; 0x02
	db $16, $3c ; 0x04
	db $18, $3c ; 0x06
	db $1a, $3c ; 0x08
	db $1c, $3c ; 0x0a
MainMenuTable1:
	; $57ec, 20 bytes (bytes:2)
	db $00, $a8 ; 0x00
	db $00, $a9 ; 0x02
	db $00, $aa ; 0x04
	db $00, $ab ; 0x06
	db $00, $ac ; 0x08
	db $00, $ad ; 0x0a
	db $00, $00 ; 0x0c
	db $8f, $01 ; 0x0e
	db $1f, $03 ; 0x10
	db $1f, $03 ; 0x12
MainMenuSlideIn:
	ld a, b ; $5800
	or a ; $5801
	jr z, .zero ; $5802
	ld c, $00 ; $5804
.loop:
	call AdvanceFrame ; $5806
	ld b, $00 ; $5809
	farcall RestoreMenuBgAndDrawPanel ; $580b
	ld b, $00 ; $580e
	farcall FlushWram3MapRows ; $5810
	ld a, c ; $5813
	inc a ; $5814
	ld c, a ; $5815
	cp $10 ; $5816
	jr nz, .loop ; $5818
	ret ; $581a
.zero:
	ld c, $09 ; $581b
.loopB:
	call AdvanceFrame ; $581d
	ld b, $01 ; $5820
	farcall RestoreMenuBgAndDrawPanel ; $5822
	ld b, $00 ; $5825
	farcall FlushWram3MapRows ; $5827
	ld a, c ; $582a
	dec a ; $582b
	ld c, a ; $582c
	cp $ff ; $582d
	jr nz, .loopB ; $582f
	ret ; $5831
MainMenuSlideOut:
	ld a, b ; $5832
	or a ; $5833
	jr z, .zero ; $5834
	ld c, $00 ; $5836
.loop:
	call AdvanceFrame ; $5838
	ld b, $01 ; $583b
	farcall RestoreMenuBgAndDrawPanel ; $583d
	ld b, $00 ; $5840
	farcall FlushWram3MapRows ; $5842
	ld a, c ; $5845
	inc a ; $5846
	ld c, a ; $5847
	cp $0c ; $5848
	jr nz, .loop ; $584a
	ret ; $584c
.zero:
	ld c, $0f ; $584d
.loopB:
	call AdvanceFrame ; $584f
	ld b, $00 ; $5852
	farcall RestoreMenuBgAndDrawPanel ; $5854
	ld b, $00 ; $5857
	farcall FlushWram3MapRows ; $5859
	ld a, c ; $585c
	dec a ; $585d
	ld c, a ; $585e
	or a ; $585f
	jr nz, .loopB ; $5860
	ret ; $5862
MainMenuCursorSpriteTask:
	farcall TickMenuBgScroll ; $5863
	ld c, $03 ; $5866
	call GetMenuCursorIndex_3b ; $5868
	push af ; $586b
	ld hl, MainMenuCursorSpriteTaskTable1 ; $586c
	add l ; $586f
	ld l, a ; $5870
	jr nc, .read ; $5871
	inc h ; $5873
.read:
	ld c, [hl] ; $5874
	ld hl, MainMenuCursorSpriteTaskTable0 ; $5875
	pop af ; $5878
	add a ; $5879
	push af ; $587a
	add l ; $587b
	ld l, a ; $587c
	jr nc, .readB ; $587d
	inc h ; $587f
.readB:
	ld a, [hl+] ; $5880
	ld d, [hl] ; $5881
	ld e, a ; $5882
	farcall ApplySpriteBobOffset ; $5883
	pop af ; $5886
	ld hl, MainMenuCursorSpriteTaskPtrs ; $5887
	add l ; $588a
	ld l, a ; $588b
	jr nc, .read2 ; $588c
	inc h ; $588e
.read2:
	ld a, [hl+] ; $588f
	ld h, [hl] ; $5890
	ld l, a ; $5891
	ld b, $08 ; $5892
	push de ; $5894
	call QueueSpriteTemplate ; $5895
	ld c, $03 ; $5898
	call GetMenuCursorIndex_3b ; $589a
	ld hl, MainMenuCursorSpriteTaskTable2 ; $589d
	add l ; $58a0
	ld l, a ; $58a1
	jr nc, .read3 ; $58a2
	inc h ; $58a4
.read3:
	ld a, [hl] ; $58a5
	pop de ; $58a6
	ld hl, $17f8 ; $58a7
	add hl, de ; $58aa
	ld d, h ; $58ab
	ld e, l ; $58ac
	add d ; $58ad
	ld d, a ; $58ae
	ld hl, MainMenuCursorSpriteTask_SpriteTemplate ; $58af
	ld b, $08 ; $58b2
	ld c, $72 ; $58b4
	call QueueSpriteTemplate ; $58b6
	ret ; $58b9
MainMenuCursorSpriteTaskPtrs:
	; $58ba, 18 bytes (records:2)
	dw MainMenuCursorSpriteTask0 ; record 0
	dw MainMenuCursorSpriteTask1 ; record 1
	dw MainMenuCursorSpriteTask0 ; record 2
	dw MainMenuCursorSpriteTask0 ; record 3
	dw MainMenuCursorSpriteTask0 ; record 4
	dw MainMenuCursorSpriteTask0 ; record 5
	dw MainMenuCursorSpriteTask0 ; record 6
	dw MainMenuCursorSpriteTask0 ; record 7
	dw MainMenuCursorSpriteTask0 ; record 8
MainMenuCursorSpriteTask0:
	; $58cc, 33 bytes (bytes:4)
	db $10, $08, $00, $00 ; 0x00
	db $10, $10, $02, $00 ; 0x04
	db $10, $18, $04, $00 ; 0x08
	db $10, $20, $06, $00 ; 0x0c
	db $10, $28, $08, $00 ; 0x10
	db $10, $30, $0a, $00 ; 0x14
	db $10, $38, $0c, $00 ; 0x18
	db $10, $40, $0e, $00 ; 0x1c
	db $80 ; 0x20
MainMenuCursorSpriteTask1:
	; $58ed, 37 bytes (bytes:4)
	db $10, $08, $00, $00 ; 0x00
	db $10, $10, $02, $00 ; 0x04
	db $10, $18, $04, $00 ; 0x08
	db $10, $20, $06, $00 ; 0x0c
	db $10, $28, $08, $00 ; 0x10
	db $10, $30, $0a, $00 ; 0x14
	db $10, $38, $0c, $00 ; 0x18
	db $10, $40, $0e, $00 ; 0x1c
	db $10, $48, $10, $00 ; 0x20
	db $80 ; 0x24
MainMenuCursorSpriteTask_SpriteTemplate:
	; $5912, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
MainMenuCursorSpriteTaskTable0:
	; $591b, 18 bytes (bytes:16)
	db $2e, $fc, $2e, $26, $2e, $5c, $52, $fe, $52, $2c, $52, $5e, $68, $fc, $68, $2c ; 0x00
	db $68, $5e ; 0x10
MainMenuCursorSpriteTaskTable1:
	; $592d, 9 bytes (bytes:9)
	db $10, $20, $32, $00, $00, $00, $42, $52, $62 ; 0x00
MainMenuCursorSpriteTaskTable2:
	; $5936, 50 bytes (bytes:16)
	db $00, $04, $00, $00, $00, $00, $00, $00, $00, $10, $08, $00, $00, $10, $10, $02 ; 0x00
	db $00, $10, $18, $04, $00, $10, $20, $06, $00, $10, $28, $08, $00, $10, $30, $0a ; 0x10
	db $00, $10, $38, $0c, $00, $10, $40, $0e, $00, $10, $48, $10, $00, $10, $50, $12 ; 0x20
	db $00, $80 ; 0x30
DrawMainMenuSelection:
	wram_bank WRAM_SCREEN ; $5968
	ld b, $00 ; $596e
	ld c, $00 ; $5970
.loop:
	call FillMainMenuCellHighlight ; $5972
	ld a, b ; $5975
	inc a ; $5976
	ld b, a ; $5977
	cp $09 ; $5978
	jr nz, .loop ; $597a
	ld c, $03 ; $597c
	call GetMenuCursorIndex_3b ; $597e
	ld b, a ; $5981
	ld c, $01 ; $5982
	call FillMainMenuCellHighlight ; $5984
	ld c, $03 ; $5987
	call GetMenuCursorIndex_3b ; $5989
	cp $06 ; $598c
	jr nc, .loadMainMenuItemPalette ; $598e
	cp $03 ; $5990
	jr c, .loadMainMenuItemPalette ; $5992
	sub $03 ; $5994
	add a ; $5996
	add a ; $5997
	add a ; $5998
	add a ; $5999
	ld bc, wShadowTilemap + 24 * TILEMAP_WIDTH ; $599a
	add c ; $599d
	ld c, a ; $599e
	jr nc, .gotPtr ; $599f
	inc b ; $59a1
.gotPtr:
	ld hl, $0001 ; $59a2
	add hl, bc ; $59a5
	ld a, [hl] ; $59a6
	ld d, $04 ; $59a7
	farcall LoadIndexedPalette_18 ; $59a9
	jr .fillTilemapRect ; $59ac
.loadMainMenuItemPalette:
	call LoadMainMenuItemPalette ; $59ae
.fillTilemapRect:
	wram_bank WRAM_SCREEN ; $59b1
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH ; $59b7
	ld b, $14 ; $59ba
	ld c, $01 ; $59bc
	ld h, $03 ; $59be
	farcall FillTilemapRect ; $59c0
	ld a, $02 ; $59c3
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH], a ; $59c5
	ld a, $04 ; $59c8
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH + 19], a ; $59ca
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $59cd
	ld b, $12 ; $59d0
	ld c, $01 ; $59d2
	ld h, $20 ; $59d4
	farcall FillTilemapRect ; $59d6
	call DrawMainMenuCaption ; $59d9
	ld hl, wShadowAttrmap + 3 * TILEMAP_WIDTH ; $59dc
	ld de, vBGMap0 + 3 * TILEMAP_WIDTH + VRAM_BANK1 ; $59df
	ld c, $06 ; $59e2
	call QueueVRAMCopy ; $59e4
	ld hl, wShadowAttrmap + 7 * TILEMAP_WIDTH ; $59e7
	ld de, vBGMap0 + 7 * TILEMAP_WIDTH + VRAM_BANK1 ; $59ea
	ld c, $06 ; $59ed
	call QueueVRAMCopy ; $59ef
	ld hl, wShadowAttrmap + 11 * TILEMAP_WIDTH ; $59f2
	ld de, vBGMap0 + 11 * TILEMAP_WIDTH + VRAM_BANK1 ; $59f5
	ld c, $06 ; $59f8
	call QueueVRAMCopy ; $59fa
	ld hl, wShadowTilemap + 15 * TILEMAP_WIDTH ; $59fd
	ld de, vBGMap0 + 15 * TILEMAP_WIDTH ; $5a00
	ld c, $04 ; $5a03
	call QueueVRAMCopy ; $5a05
	ret ; $5a08
FillMainMenuCellHighlight:
	push af ; $5a09
	push bc ; $5a0a
	push de ; $5a0b
	push hl ; $5a0c
	ld d, c ; $5a0d
	ld e, b ; $5a0e
	ld a, b ; $5a0f
	cp $06 ; $5a10
	jr nc, .step ; $5a12
	cp $03 ; $5a14
	jr c, .step ; $5a16
	ld b, $03 ; $5a18
	ld c, $03 ; $5a1a
	jr .step2 ; $5a1c
.step:
	ld b, $05 ; $5a1e
	ld c, $03 ; $5a20
.step2:
	ld a, d ; $5a22
	or a ; $5a23
	jr z, .zero ; $5a24
	ld h, $0c ; $5a26
	jr .step4 ; $5a28
.zero:
	ld h, $0d ; $5a2a
.step4:
	push hl ; $5a2c
	ld hl, FillMainMenuCellHighlightTable ; $5a2d
	ld a, e ; $5a30
	add a ; $5a31
	add l ; $5a32
	ld l, a ; $5a33
	jr nc, .read ; $5a34
	inc h ; $5a36
.read:
	ld a, [hl+] ; $5a37
	ld d, [hl] ; $5a38
	ld e, a ; $5a39
	pop hl ; $5a3a
	farcall FillTilemapRect ; $5a3b
	pop hl ; $5a3e
	pop de ; $5a3f
	pop bc ; $5a40
	pop af ; $5a41
	ret ; $5a42
FillMainMenuCellHighlightTable:
	; $5a43, 20 bytes (ram_ptrs:3)
	dw wShadowAttrmap + 3 * TILEMAP_WIDTH + 1 ; record 0
	dw wShadowAttrmap + 3 * TILEMAP_WIDTH + 7 ; record 1
	dw wShadowAttrmap + 3 * TILEMAP_WIDTH + 13 ; record 2
	dw wShadowAttrmap + 7 * TILEMAP_WIDTH + 2 ; record 3
	dw wShadowAttrmap + 7 * TILEMAP_WIDTH + 8 ; record 4
	dw wShadowAttrmap + 7 * TILEMAP_WIDTH + 14 ; record 5
	dw wShadowAttrmap + 11 * TILEMAP_WIDTH + 1 ; record 6
	dw wShadowAttrmap + 11 * TILEMAP_WIDTH + 7 ; record 7
	dw wShadowAttrmap + 11 * TILEMAP_WIDTH + 13 ; record 8
	dw wShadowAttrmap + 8 * TILEMAP_WIDTH + 7 ; record 9
LoadMainMenuItemPalette:
	ld hl, MainMenuItemPalettePtrs ; $5a57
	add a ; $5a5a
	add l ; $5a5b
	ld l, a ; $5a5c
	jr nc, .read ; $5a5d
	inc h ; $5a5f
.read:
	ld a, [hl+] ; $5a60
	ld h, [hl] ; $5a61
	ld l, a ; $5a62
	lb de, $04, $01 ; $5a63 palette index, count
	call LoadPaletteShadow ; $5a66
	ret ; $5a69
MainMenuItemPalettePtrs:
	; $5a6a, 18 bytes (records:2)
	dw MainMenuItemPalette0 ; record 0
	dw MainMenuItemPalette2 ; record 1
	dw MainMenuItemPalette3 ; record 2
	dw MainMenuItemPalette0 ; record 3
	dw MainMenuItemPalette0 ; record 4
	dw MainMenuItemPalette0 ; record 5
	dw MainMenuItemPalette4 ; record 6
	dw MainMenuItemPalette1 ; record 7
	dw MainMenuItemPalette5 ; record 8
MainMenuItemPalette0:
	; $5a7c, 8 bytes (bytes:8)
	db $9f, $3e, $ff, $6b, $0a, $50, $00, $00 ; 0x00
MainMenuItemPalette1:
	; $5a84, 8 bytes (bytes:8)
	db $cc, $3a, $ff, $6b, $40, $65, $00, $00 ; 0x00
MainMenuItemPalette2:
	; $5a8c, 8 bytes (bytes:8)
	db $9f, $5a, $ff, $6b, $1f, $00, $00, $00 ; 0x00
MainMenuItemPalette3:
	; $5a94, 8 bytes (bytes:8)
	db $32, $1b, $ff, $6b, $e0, $15, $00, $00 ; 0x00
MainMenuItemPalette4:
	; $5a9c, 8 bytes (bytes:8)
	db $5f, $1a, $ff, $6b, $7c, $00, $00, $00 ; 0x00
MainMenuItemPalette5:
	; $5aa4, 8 bytes (bytes:8)
	db $96, $59, $ff, $6b, $12, $14, $00, $00 ; 0x00
