DrawEquippedRacketPanel:
	ld a, $00 ; $5458
	ld [wEquipItemKind], a ; $545a
	call MarkOwnedRackets ; $545d
	call BuildOwnedItemList ; $5460
	ld a, $01 ; $5463
	ld [wEquipStatRowSet], a ; $5465
	ld a, [wEquipEquippedIndex] ; $5468
	ld [wMenuCursorX], a ; $546b
	call GetEquippedItemId ; $546e
	ld c, a ; $5471
	ld de, wShadowTilemap + 1 * TILEMAP_WIDTH + 5 ; $5472
	call DrawItemIcon2x2 ; $5475
	call GetEquippedItemId ; $5478
	ld c, a ; $547b
	ld de, wShadowTilemap + 1 * TILEMAP_WIDTH + 8 ; $547c
	call RenderRacketNameText ; $547f
	call DrawEquippedItemStatMods ; $5482
	ret ; $5485
DrawEquippedShoesPanel:
	ld hl, wEquipItemList ; $5486
	ld bc, $0003 ; $5489
	call ClearMemory16 ; $548c
	ld a, $01 ; $548f
	ld [wEquipItemKind], a ; $5491
	call MarkOwnedShoes ; $5494
	call BuildOwnedItemList ; $5497
	ld a, $02 ; $549a
	ld [wEquipStatRowSet], a ; $549c
	ld a, [wEquipEquippedIndex] ; $549f
	ld [wMenuCursorX], a ; $54a2
	call GetEquippedItemId ; $54a5
	ld c, a ; $54a8
	ld de, wShadowTilemap + 10 * TILEMAP_WIDTH + 5 ; $54a9
	call DrawItemIcon2x2 ; $54ac
	call GetEquippedItemId ; $54af
	ld c, a ; $54b2
	ld de, wShadowTilemap + 10 * TILEMAP_WIDTH + 8 ; $54b3
	call RenderShoesNameText ; $54b6
	call DrawEquippedItemStatMods ; $54b9
	ret ; $54bc
RunRacketSelectScreen:
	call DisableLCDSafely ; $54bd
	call LoadRacketSelectScreen ; $54c0
	ld a, $01 ; $54c3
	ld hl, EquipListCursorSpriteTask ; $54c5
	call RegisterFrameTask ; $54c8
	ld a, $01 ; $54cb
	ld hl, EquippedItemMarkerSpriteTask ; $54cd
	call RegisterFrameTask ; $54d0
	call EnableLCD ; $54d3
	script_fade_in $10 ; $54d6
	call WaitFadeEnd ; $54db
.loop:
	call HandleEquipSelectInput ; $54de
	ld a, [wEquipSelectExitTimer] ; $54e1
	or a ; $54e4
	jr z, .advanceFrame ; $54e5
	inc a ; $54e7
	ld [wEquipSelectExitTimer], a ; $54e8
	cp $14 ; $54eb
	jr nc, .ge14 ; $54ed
.advanceFrame:
	call AdvanceFrame ; $54ef
	jr .loop ; $54f2
.ge14:
	push af ; $54f4
	ld c, $10 ; $54f5
	call BeginFadeOut ; $54f7
	call WaitFadeEnd ; $54fa
	call ClearFrameTasks ; $54fd
	pop af ; $5500
	cp $45 ; $5501
	jr nz, .refreshMainCharacterStats ; $5503
	ld a, $ff ; $5505
	ret ; $5507
.refreshMainCharacterStats:
	farcall RefreshMainCharacterStats ; $5508
	xor a ; $550b
	ret ; $550c
LoadRacketSelectScreen:
	ld c, SCREENASSET_EquipmentSelect ; $550d
	farcall LoadScreenAssetRecord ; $550f
	farcall PrepareGlyphBuffer ; $5512
	call LoadEquipSelectCommon ; $5515
	ld c, $00 ; $5518
	ld b, $07 ; $551a
	call SetMenuCursorFromIndex_3e ; $551c
	wram_bank WRAM_SCREEN ; $551f
	ld hl, wEquipItemList ; $5525
	ld bc, $0002 ; $5528
	call ClearMemory16 ; $552b
	ld a, $00 ; $552e
	ld [wEquipItemKind], a ; $5530
	ld a, $00 ; $5533
	ld [wEquipStatRowSet], a ; $5535
	call MarkOwnedRackets ; $5538
	call BuildOwnedItemList ; $553b
	call DrawOwnedItemIcons ; $553e
	call DrawRacketInfoPanel ; $5541
	ld b, TILEBLOCK_SharedMenuGfx99 ; $5544
	ld c, SharedMenuGfx99_SIZE / 16 ; $5546
	ld de, vTiles0 + $20 * TILE_SIZE + VRAM_BANK1 ; $5548
	farcall LoadCompressedTileBlock ; $554b
	ld hl, Palette_3e ; $554e
	ld_obj_pals de, 1, 1 ; $5551
	call LoadPaletteShadow ; $5554
	farcall QueueWram3MapToVRAM ; $5557
	ret ; $555a
Palette_3e:
	INCLUDE "data/bank_03e/Palette_3e.asm" ; $555b, 8 bytes (palettes)
DrawOwnedItemIcons:
	ld hl, wEquipItemList ; $5563
	ld a, [wEquipItemCount] ; $5566
	ld b, a ; $5569
	ld de, wShadowTilemap + 1 * TILEMAP_WIDTH + 7 ; $556a
.loop:
	ld a, [hl+] ; $556d
	ld c, a ; $556e
	call DrawItemIcon2x2 ; $556f
	inc de ; $5572
	inc de ; $5573
	ld a, b ; $5574
	dec a ; $5575
	ld b, a ; $5576
	jr nz, .loop ; $5577
	ret ; $5579
DrawItemIcon2x2:
	push af ; $557a
	push bc ; $557b
	push de ; $557c
	push hl ; $557d
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH ; $557e
	ld a, [wEquipItemKind] ; $5581
	or a ; $5584
	jr z, .gotBase ; $5585
	ld hl, wShadowTilemap + 20 * TILEMAP_WIDTH ; $5587
.gotBase:
	ld a, c ; $558a
	add a ; $558b
	add l ; $558c
	ld l, a ; $558d
	jr nc, .copy ; $558e
	inc h ; $5590
.copy:
	ld b, $02 ; $5591
	ld c, $02 ; $5593
	farcall CopyTilemapRect ; $5595
	ld bc, $0400 ; $5598
	add hl, bc ; $559b
	push hl ; $559c
	ld h, d ; $559d
	ld l, e ; $559e
	add hl, bc ; $559f
	ld d, h ; $55a0
	ld e, l ; $55a1
	pop hl ; $55a2
	ld b, $02 ; $55a3
	ld c, $02 ; $55a5
	farcall CopyTilemapRect ; $55a7
	pop hl ; $55aa
	pop de ; $55ab
	pop bc ; $55ac
	pop af ; $55ad
	ret ; $55ae
HandleEquipSelectInput:
	ldh a, [hInputPressed] ; $55af
	ld [wMenuInputPressed], a ; $55b1
	bit PADB_A, a ; $55b4
	jr nz, .step ; $55b6
	bit 1, a ; $55b8
	jr nz, .playSfx ; $55ba
	jr .moveMenuCursorGrid ; $55bc
.step:
	ld a, [wEquipSelectExitTimer] ; $55be
	or a ; $55c1
	jr nz, .moveMenuCursorGrid ; $55c2
	sound SFX_MENU_DECIDE ; $55c4
	ld a, $01 ; $55c6
	ld [wEquipSelectExitTimer], a ; $55c8
	ld a, [wEquipItemCount] ; $55cb
	ld c, a ; $55ce
	call GetMenuCursorIndex_3e ; $55cf
	ld [wEquipEquippedIndex], a ; $55d2
	call GetEquippedItemId ; $55d5
	ld b, a ; $55d8
	ld a, [wEquipItemKind] ; $55d9
	cp $00 ; $55dc
	ld a, b ; $55de
	jr z, .checkEquippedRacket ; $55df
	swap a ; $55e1
	ld b, a ; $55e3
	ld a, [wEquippedRacket] ; $55e4
	and $0f ; $55e7
	or b ; $55e9
	ld [wEquippedRacket], a ; $55ea
	ret ; $55ed
.checkEquippedRacket:
	ld b, a ; $55ee
	ld a, [wEquippedRacket] ; $55ef
	and $f0 ; $55f2
	or b ; $55f4
	ld [wEquippedRacket], a ; $55f5
	ret ; $55f8
.playSfx:
	sound SFX_MENU_CANCEL ; $55f9
	ld a, $44 ; $55fb
	ld [wEquipSelectExitTimer], a ; $55fd
	ret ; $5600
.moveMenuCursorGrid:
	ld a, [wEquipItemCount] ; $5601
	ld b, a ; $5604
	ld c, $01 ; $5605
	call MoveMenuCursorGrid_3e ; $5607
	or a ; $560a
	jr z, .done ; $560b
	sound SFX_MENU_MOVE ; $560d
	call ClearEquipSelectTextRows ; $560f
	ld a, [wEquipItemKind] ; $5612
	or a ; $5615
	jr z, .drawRacketInfoPanel ; $5616
	call DrawShoesInfoPanel ; $5618
	jr .flushEquipSelectTextRows ; $561b
.drawRacketInfoPanel:
	call DrawRacketInfoPanel ; $561d
.flushEquipSelectTextRows:
	call FlushEquipSelectTextRows ; $5620
.done:
	ret ; $5623
DrawRacketInfoPanel:
	farcall PrepareGlyphBuffer ; $5624
	call DrawHoveredItemStatMods ; $5627
	call GetHoveredItemId ; $562a
	ld c, a ; $562d
	ld de, wShadowTilemap + 5 * TILEMAP_WIDTH + 5 ; $562e
	push bc ; $5631
	call DrawItemIcon2x2 ; $5632
	pop bc ; $5635
	push bc ; $5636
	call RenderRacketDescText ; $5637
	pop bc ; $563a
	ld de, wShadowTilemap + 5 * TILEMAP_WIDTH + 8 ; $563b
	call RenderRacketNameText ; $563e
	farcall UploadGlyphBuffer ; $5641
	ret ; $5644
RunShoesSelectScreen:
	call DisableLCDSafely ; $5645
	call LoadShoesSelectScreen ; $5648
	ld a, $01 ; $564b
	ld hl, EquipListCursorSpriteTask ; $564d
	call RegisterFrameTask ; $5650
	ld a, $01 ; $5653
	ld hl, EquippedItemMarkerSpriteTask ; $5655
	call RegisterFrameTask ; $5658
	call EnableLCD ; $565b
	script_fade_in $10 ; $565e
	call WaitFadeEnd ; $5663
.loop:
	call HandleEquipSelectInput ; $5666
	ld a, [wEquipSelectExitTimer] ; $5669
	or a ; $566c
	jr z, .advanceFrame ; $566d
	inc a ; $566f
	ld [wEquipSelectExitTimer], a ; $5670
	cp $14 ; $5673
	jr nc, .ge14 ; $5675
.advanceFrame:
	call AdvanceFrame ; $5677
	jr .loop ; $567a
.ge14:
	push af ; $567c
	ld c, $10 ; $567d
	call BeginFadeOut ; $567f
	call WaitFadeEnd ; $5682
	call ClearFrameTasks ; $5685
	pop af ; $5688
	cp $45 ; $5689
	jr nz, .refreshMainCharacterStats ; $568b
	ld a, $ff ; $568d
	ret ; $568f
.refreshMainCharacterStats:
	farcall RefreshMainCharacterStats ; $5690
	xor a ; $5693
	ret ; $5694
	ret ; $5695
LoadShoesSelectScreen:
	ld c, SCREENASSET_EquipmentSelect ; $5696
	farcall LoadScreenAssetRecord ; $5698
	farcall PrepareGlyphBuffer ; $569b
	call LoadEquipSelectCommon ; $569e
	wram_bank WRAM_SCREEN ; $56a1
	ld hl, wShadowTilemap + 26 * TILEMAP_WIDTH ; $56a7
	ld de, wShadowTilemap ; $56aa
	ld b, $14 ; $56ad
	ld c, $04 ; $56af
	farcall CopyTilemapRect ; $56b1
	ld hl, wShadowAttrmap + 26 * TILEMAP_WIDTH ; $56b4
	ld de, wShadowAttrmap ; $56b7
	ld b, $14 ; $56ba
	ld c, $04 ; $56bc
	farcall CopyTilemapRect ; $56be
	ld c, $00 ; $56c1
	ld b, $07 ; $56c3
	call SetMenuCursorFromIndex_3e ; $56c5
	wram_bank WRAM_SCREEN ; $56c8
	ld hl, wEquipItemList ; $56ce
	ld bc, $0002 ; $56d1
	call ClearMemory16 ; $56d4
	ld a, $01 ; $56d7
	ld [wEquipItemKind], a ; $56d9
	ld a, $00 ; $56dc
	ld [wEquipStatRowSet], a ; $56de
	call MarkOwnedShoes ; $56e1
	call BuildOwnedItemList ; $56e4
	call DrawOwnedItemIcons ; $56e7
	call DrawShoesInfoPanel ; $56ea
	ld b, TILEBLOCK_SharedMenuGfx99 ; $56ed
	ld c, SharedMenuGfx99_SIZE / 16 ; $56ef
	ld de, vTiles0 + $20 * TILE_SIZE + VRAM_BANK1 ; $56f1
	farcall LoadCompressedTileBlock ; $56f4
	ld hl, Palette_3e ; $56f7
	ld_obj_pals de, 1, 1 ; $56fa
	call LoadPaletteShadow ; $56fd
	farcall QueueWram3MapToVRAM ; $5700
	ret ; $5703
DrawShoesInfoPanel:
	farcall PrepareGlyphBuffer ; $5704
	call DrawHoveredItemStatMods ; $5707
	call GetHoveredItemId ; $570a
	ld c, a ; $570d
	ld de, wShadowTilemap + 5 * TILEMAP_WIDTH + 5 ; $570e
	push bc ; $5711
	call DrawItemIcon2x2 ; $5712
	pop bc ; $5715
	push bc ; $5716
	call RenderShoesDescText ; $5717
	pop bc ; $571a
	ld de, wShadowTilemap + 5 * TILEMAP_WIDTH + 8 ; $571b
	call RenderShoesNameText ; $571e
	farcall UploadGlyphBuffer ; $5721
	ret ; $5724
BuildOwnedItemList:
	xor a ; $5725
	ld [wEquipEquippedIndex], a ; $5726
	ld [wEquipItemCount], a ; $5729
	ld hl, wEquipItemList ; $572c
	ld bc, $0008 ; $572f
	call ClearBytes ; $5732
	ld hl, wEquipOwnedMap ; $5735
	ld de, wEquipItemList ; $5738
	ld c, $00 ; $573b
	ld b, $00 ; $573d
.scanLoop:
	ld a, [hl+] ; $573f
	or a ; $5740
	jr z, .next ; $5741
	cp $01 ; $5743
	jr z, .append ; $5745
	ld a, b ; $5747
	ld [wEquipEquippedIndex], a ; $5748
.append:
	ld a, c ; $574b
	ld [de], a ; $574c
	inc de ; $574d
	inc b ; $574e
.next:
	inc c ; $574f
	ld a, c ; $5750
	cp $08 ; $5751
	jr nz, .scanLoop ; $5753
	ld a, b ; $5755
	ld [wEquipItemCount], a ; $5756
	ret ; $5759
MarkOwnedRackets:
	ld hl, wEquipOwnedMap ; $575a
	ld bc, $0008 ; $575d
	call ClearBytes ; $5760
	ld hl, wEquipOwnedMap ; $5763
	ld a, $01 ; $5766
	ld [hl+], a ; $5768
	ld c, $00 ; $5769
.loop:
	ld a, c ; $576b
	push hl ; $576c
	ld hl, RacketItemTiles_3e ; $576d
	add l ; $5770
	ld l, a ; $5771
	jr nc, .gotPtr ; $5772
	inc h ; $5774
.gotPtr:
	ld d, $00 ; $5775
	ld e, [hl] ; $5777
	pop hl ; $5778
	call TestGameFlagByNumber ; $5779
	jr z, .countDone ; $577c
	ld a, $01 ; $577e
	ld [hl], a ; $5780
.countDone:
	inc hl ; $5781
	ld a, c ; $5782
	inc a ; $5783
	ld c, a ; $5784
	cp $06 ; $5785
	jr nz, .loop ; $5787
	ld a, [wEquippedRacket] ; $5789
	and $0f ; $578c
	ld hl, wEquipOwnedMap ; $578e
	add l ; $5791
	ld l, a ; $5792
	jr nc, .gotPtr2 ; $5793
	inc h ; $5795
.gotPtr2:
	ld a, $02 ; $5796
	ld [hl], a ; $5798
	ret ; $5799
Unused_3e_0:
	; $579a, 8 bytes (bytes:8)
	db $01, $00, $00, $00, $00, $00, $00, $00 ; 0x00
RacketItemTiles_3e:
	; $57a2, 6 bytes (bytes:6)
	db $61, $62, $63, $65, $64, $66 ; 0x00
MarkOwnedShoes:
	ld hl, wEquipOwnedMap ; $57a8
	ld bc, $0008 ; $57ab
	call ClearBytes ; $57ae
	ld hl, wEquipOwnedMap ; $57b1
	ld a, $01 ; $57b4
	ld [hl+], a ; $57b6
	ld c, $00 ; $57b7
.loop:
	ld a, c ; $57b9
	push hl ; $57ba
	ld hl, ShoeItemTiles_3e ; $57bb
	add l ; $57be
	ld l, a ; $57bf
	jr nc, .gotPtr ; $57c0
	inc h ; $57c2
.gotPtr:
	ld d, $00 ; $57c3
	ld e, [hl] ; $57c5
	pop hl ; $57c6
	call TestGameFlagByNumber ; $57c7
	jr z, .countDone ; $57ca
	ld a, $01 ; $57cc
	ld [hl], a ; $57ce
.countDone:
	inc hl ; $57cf
	ld a, c ; $57d0
	inc a ; $57d1
	ld c, a ; $57d2
	cp $02 ; $57d3
	jr nz, .loop ; $57d5
	ld a, [wEquippedRacket] ; $57d7
	and $f0 ; $57da
	swap a ; $57dc
	ld hl, wEquipOwnedMap ; $57de
	add l ; $57e1
	ld l, a ; $57e2
	jr nc, .gotPtr2 ; $57e3
	inc h ; $57e5
.gotPtr2:
	ld a, $02 ; $57e6
	ld [hl], a ; $57e8
	ret ; $57e9
Unused_3e_1:
	; $57ea, 8 bytes (bytes:8)
	db $01, $00, $00, $00, $00, $00, $00, $00 ; 0x00
