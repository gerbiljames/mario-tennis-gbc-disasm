BuildMarioCastUnlockMask:
	ld c, $00 ; $667f
	ld b, $00 ; $6681
.loop:
	ld a, c ; $6683
	add a ; $6684
	ld hl, MarioCastUnlockMaskTable ; $6685
	add_hl_a ; $6688
	ld a, [hl+] ; $668d
	ld d, [hl] ; $668e
	ld e, a ; $668f
	farcall TestSaveFlag ; $6690
	jr z, .nextFlag ; $6693
	ld a, $01 ; $6695
	or b ; $6697
	ld b, a ; $6698
.nextFlag:
	ld a, c ; $6699
	inc a ; $669a
	ld c, a ; $669b
	cp $06 ; $669c
	jr z, .done ; $669e
	sla b ; $66a0
	jr .loop ; $66a2
.done:
	ld a, b ; $66a4
	ld [wMarioCastUnlockMask], a ; $66a5
	ret ; $66a8
MarioCastUnlockMaskTable:
	; $66a9, 12 bytes (save_flag_ids)
	dw SAVEFLAG_UNLOCKED_PEACH ; record 0
	dw SAVEFLAG_UNLOCKED_WARIO ; record 1
	dw SAVEFLAG_UNLOCKED_BOWSER ; record 2
	dw SAVEFLAG_UNLOCKED_YOSHI ; record 3
	dw SAVEFLAG_UNLOCKED_WALUIGI ; record 4
	dw SAVEFLAG_UNLOCKED_MARIO ; record 5
GetUnlockedMarioCastCharAtGridSlot:
	call GetMarioCastCharAtGridSlot ; $66b5
	cp CHAR_LUIGI ; $66b8
	ret z ; $66ba
	cp CHAR_BABY_MARIO ; $66bb
	ret z ; $66bd
	cp CHAR_DK ; $66be
	ret z ; $66c0
	ld d, a ; $66c1
	sub CHAR_MARIO ; $66c2
	ld hl, MarioCastUnlockBitByChar ; $66c4
	add_hl_a ; $66c7
	ld b, [hl] ; $66cc
	ld a, [wMarioCastUnlockMask] ; $66cd
	and b ; $66d0
	jr nz, .unlocked ; $66d1
	ld a, CHAR_UNUSED_15 ; $66d3
	ret ; $66d5
.unlocked:
	ld a, d ; $66d6
	ret ; $66d7
MarioCastUnlockBitByChar:
	; $66d8, 6 bytes (bytes:8)
	db $01, $02, $04, $08, $10, $20 ; 0x00
GetMarioCastCharAtGridSlot:
	ld hl, MarioCastCharAtGridSlotTable ; $66de
	ld a, c ; $66e1
	add_hl_a ; $66e2
	ld a, [hl] ; $66e7
	ret ; $66e8
MarioCastCharAtGridSlotTable:
	; $66e9, 9 bytes (bytes:3)
	db CHAR_MARIO, CHAR_LUIGI, CHAR_PEACH
	db CHAR_BABY_MARIO, CHAR_YOSHI, CHAR_DK
	db CHAR_WARIO, CHAR_WALUIGI, CHAR_BOWSER
CheckMinigameGridExpanded:
	ld c, MARIOGAME_TREASURE_BOX ; $66f2
	call GetUnlockedMarioCastCharAtGridSlot ; $66f4
	cp CHAR_UNUSED_15 ; $66f7
	jr nz, .expanded ; $66f9
	xor a ; $66fb
	ret ; $66fc
.expanded:
	ld a, $01 ; $66fd
	ret ; $66ff
MinigameSelectSlideIn6:
	ld a, b ; $6700
	or a ; $6701
	jr z, .slideBack ; $6702
	ld c, $00 ; $6704
.slideForwardLoop:
	call AdvanceFrame ; $6706
	ld b, PANELANIM_MINIGAME_GRID6_IN ; $6709
	farcall RestoreMenuBgAndDrawPanel ; $670b
	ld b, MAPROWS_BANDS_4_9 ; $670e
	farcall FlushWram3MapRows ; $6710
	ld a, c ; $6713
	inc a ; $6714
	ld c, a ; $6715
	cp $0e ; $6716
	jr nz, .slideForwardLoop ; $6718
	ret ; $671a
.slideBack:
	ld c, $0c ; $671b
.slideBackLoop:
	call AdvanceFrame ; $671d
	ld b, PANELANIM_MINIGAME_GRID6_OUT ; $6720
	farcall RestoreMenuBgAndDrawPanel ; $6722
	ld b, MAPROWS_BANDS_4_9 ; $6725
	farcall FlushWram3MapRows ; $6727
	ld a, c ; $672a
	dec a ; $672b
	ld c, a ; $672c
	cp $ff ; $672d
	jr nz, .slideBackLoop ; $672f
	ret ; $6731
MinigameSelectSlideOut6:
	ld a, b ; $6732
	or a ; $6733
	jr z, .slideBack ; $6734
	ld c, $00 ; $6736
.slideForwardLoop:
	call AdvanceFrame ; $6738
	ld b, PANELANIM_MINIGAME_GRID6_OUT ; $673b
	farcall RestoreMenuBgAndDrawPanel ; $673d
	ld b, MAPROWS_BANDS_4_9 ; $6740
	farcall FlushWram3MapRows ; $6742
	ld a, c ; $6745
	inc a ; $6746
	ld c, a ; $6747
	cp $0b ; $6748
	jr nz, .slideForwardLoop ; $674a
	ret ; $674c
.slideBack:
	ld c, $0d ; $674d
.slideBackLoop:
	call AdvanceFrame ; $674f
	ld b, PANELANIM_MINIGAME_GRID6_IN ; $6752
	farcall RestoreMenuBgAndDrawPanel ; $6754
	ld b, MAPROWS_BANDS_4_9 ; $6757
	farcall FlushWram3MapRows ; $6759
	ld a, c ; $675c
	dec a ; $675d
	ld c, a ; $675e
	or a ; $675f
	jr nz, .slideBackLoop ; $6760
	ret ; $6762
DrawMinigameSelectGrid6:
	wram_bank WRAM_SCREEN ; $6763
	ld b, $00 ; $6769
	ld c, $00 ; $676b
.loop:
	farcall SetMinigameGrid6CellPalette ; $676d
	ld a, b ; $6770
	inc a ; $6771
	ld b, a ; $6772
	cp $06 ; $6773
	jr nz, .loop ; $6775
	ld c, $03 ; $6777
	call GetMenuCursorIndex_3b ; $6779
	ld b, a ; $677c
	ld c, $01 ; $677d
	farcall SetMinigameGrid6CellPalette ; $677f
	ld c, $03 ; $6782
	call GetMenuCursorIndex_3b ; $6784
	call LoadMinigameCharPalette ; $6787
	ld hl, wShadowAttrmap + 4 * TILEMAP_WIDTH ; $678a
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH + VRAM_BANK1 ; $678d
	ld c, 3 * TILEMAP_WIDTH / 16 ; $6790
	call QueueVRAMCopy ; $6792
	ld hl, wShadowAttrmap + 9 * TILEMAP_WIDTH ; $6795
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH + VRAM_BANK1 ; $6798
	ld c, 3 * TILEMAP_WIDTH / 16 ; $679b
	call QueueVRAMCopy ; $679d
	ret ; $67a0
RunStatusSourceSelect:
	sound BGM_MENU ; $67a1
	ld hl, rIE ; $67a3
	res B_IE_TIMER, [hl] ; $67a6
	call BuildSaveSlotSummaries ; $67a8
	call LoadStatusSourceGfx ; $67ab
	farcall InitMenuBgScroll ; $67ae
	ld b, $01 ; $67b1
	ld c, $01 ; $67b3
	farcall LoadMenuSpritePalettePair ; $67b5
	call LoadN64RecordsToWram2 ; $67b8
	wram_bank WRAM_SCREEN ; $67bb
	ld a, [wMenuSlideDirection] ; $67c1
	ld b, a ; $67c4
	farcall SavedDataPickerSlideIn ; $67c5
	ld a, [wStatusMenuCursor] ; $67c8
	ld c, a ; $67cb
	ld b, $03 ; $67cc
	call SetMenuCursorFromIndex_3b ; $67ce
	frame_task StatusSourceCursorSpriteTask ; $67d1
	call DrawStatusSourceGrid ; $67d9
	wram_bank WRAM_SCREEN ; $67dc
.loop:
	call AdvanceFrame ; $67e2
	ldh a, [hInputPressed] ; $67e5
	ld [wMenuInputPressed], a ; $67e7
	farcall MoveSavedDataPickerCursor ; $67ea
	or a ; $67ed
	jr z, .checkMenuInputPressed ; $67ee
	sound SFX_MENU_MOVE ; $67f0
	call DrawStatusSourceGrid ; $67f2
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $67f5
	bit PADB_A, a ; $67f8
	jr nz, .getMenuCursorCellIndex ; $67fa
	bit PADB_B, a ; $67fc
	jr nz, .playCancelSfx ; $67fe
	jr .loop ; $6800
.getMenuCursorCellIndex:
	ld c, $03 ; $6802
	call GetMenuCursorIndex_3b ; $6804
	cp $04 ; $6807
	jr nz, .checkSaveSlot ; $6809
	call CheckN64DataPresent ; $680b
	or a ; $680e
	jr nz, .playSelectSfx ; $680f
	sound SFX_MENU_LOCKED ; $6811
	jr .loop ; $6813
.checkSaveSlot:
	ld c, $03 ; $6815
	call GetMenuCursorIndex_3b ; $6817
	cp $03 ; $681a
	jp nc, .playSelectSfx ; $681c
	add a ; $681f
	add a ; $6820
	add a ; $6821
	add a ; $6822
	ld bc, wSaveSlotSummaries ; $6823
	add_bc_a ; $6826
	ld hl, SLOTSUM_CHAR ; $682b
	add hl, bc ; $682e
	ld a, [hl] ; $682f
	cp CHAR_EMPTY_SLOT ; $6830
	jr z, .rejectEmptySlot ; $6832
	jr .playSelectSfx ; $6834
.rejectEmptySlot:
	sound SFX_MENU_LOCKED ; $6836
	jr .loop ; $6838
.playSelectSfx:
	sound SFX_MENU_SELECT ; $683a
	call ClearFrameTasks ; $683c
	ld hl, rIE ; $683f
	set B_IE_TIMER, [hl] ; $6842
	ld b, MENUSLIDE_FORWARD ; $6844
	farcall SavedDataPickerSlideOut ; $6846
	ld a, MENUSLIDE_FORWARD ; $6849
	ld [wMenuSlideDirection], a ; $684b
	ld c, $03 ; $684e
	call GetMenuCursorIndex_3b ; $6850
	ld [wStatusMenuCursor], a ; $6853
	ret ; $6856
.playCancelSfx:
	sound SFX_MENU_CANCEL ; $6857
	call ClearFrameTasks ; $6859
	ld hl, rIE ; $685c
	set B_IE_TIMER, [hl] ; $685f
	ld b, MENUSLIDE_BACK ; $6861
	farcall SavedDataPickerSlideOut ; $6863
	ld a, MENUSLIDE_BACK ; $6866
	ld [wMenuSlideDirection], a ; $6868
	ld a, $ff ; $686b
	ret ; $686d
LoadStatusSourceGfx:
	push_wram_bank WRAM_STAGING ; $686e
	ld_slot hl, DataPtr_MarioFaceIconTiles ; $6877
	ld de, wDecompBuffer ; $687a
	call DecompressDataFromBank ; $687d
	ld hl, wDecompBuffer ; $6880
	ld de, vTiles1 + VRAM_BANK1 ; $6883
	ld bc, 16 ; $6886
	call QueueVRAMCopy ; $6889
	call AdvanceFrame ; $688c
	ld_slot hl, DataPtr_N64DataIconTiles ; $688f
	ld de, wDecompBuffer ; $6892
	call DecompressDataFromBank ; $6895
	ld hl, wDecompBuffer ; $6898
	ld de, vTiles1 tile $10 + VRAM_BANK1 ; $689b
	ld bc, 16 ; $689e
	call QueueVRAMCopy ; $68a1
	call AdvanceFrame ; $68a4
	wram_bank WRAM_SCREEN ; $68a7
	ld a, $00 ; $68ad
	ld [wCurrentStorySlot], a ; $68af
	ld a, [wSaveSlotSummaries + SLOTSUM_CHAR] ; $68b2
	farcall LoadCharMugshotToBuffer ; $68b5
	ld de, vTiles2 tile $68 + VRAM_BANK1 ; $68b8
	farcall CopyMugshotBufferToVram ; $68bb
	call AdvanceFrame ; $68be
	wram_bank WRAM_SCREEN ; $68c1
	ld a, $01 ; $68c7
	ld [wCurrentStorySlot], a ; $68c9
	ld a, [wSaveSlotSummaries + SLOTSUM_SIZE + SLOTSUM_CHAR] ; $68cc
	farcall LoadCharMugshotToBuffer ; $68cf
	ld de, vTiles2 tile $71 + VRAM_BANK1 ; $68d2
	farcall CopyMugshotBufferToVram ; $68d5
	call AdvanceFrame ; $68d8
	wram_bank WRAM_SCREEN ; $68db
	ld a, $02 ; $68e1
	ld [wCurrentStorySlot], a ; $68e3
	ld a, [wSaveSlotSummaries + 2 * SLOTSUM_SIZE + SLOTSUM_CHAR] ; $68e6
	farcall LoadCharMugshotToBuffer ; $68e9
	ld de, vTiles1 tile $70 + VRAM_BANK1 ; $68ec
	farcall CopyMugshotBufferToVram ; $68ef
	call AdvanceFrame ; $68f2
	ld b, TILEBLOCK_File1LabelGfx ; $68f5
	ld c, File1LabelGfx_SIZE / 16 ; $68f7
	ld de, vTiles0 + VRAM_BANK1 ; $68f9
	farcall LoadCompressedTileBlock ; $68fc
	call AdvanceFrame ; $68ff
	ld b, TILEBLOCK_File2LabelGfx ; $6902
	ld c, File2LabelGfx_SIZE / 16 ; $6904
	ld de, vTiles0 tile $10 + VRAM_BANK1 ; $6906
	farcall LoadCompressedTileBlock ; $6909
	call AdvanceFrame ; $690c
	ld b, TILEBLOCK_File3LabelGfx ; $690f
	ld c, File3LabelGfx_SIZE / 16 ; $6911
	ld de, vTiles0 tile $20 + VRAM_BANK1 ; $6913
	farcall LoadCompressedTileBlock ; $6916
	call AdvanceFrame ; $6919
	ld b, TILEBLOCK_N64DataLabelGfx ; $691c
	ld c, N64DataLabelGfx_SIZE / 16 ; $691e
	ld de, vTiles0 tile $30 + VRAM_BANK1 ; $6920
	farcall LoadCompressedTileBlock ; $6923
	call AdvanceFrame ; $6926
	ld b, TILEBLOCK_MarioCharactersLabelGfx ; $6929
	ld c, MarioCharactersLabelGfx_SIZE / 16 ; $692b
	ld de, vTiles0 tile $40 + VRAM_BANK1 ; $692d
	farcall LoadCompressedTileBlock ; $6930
	call AdvanceFrame ; $6933
	ld b, TILEBLOCK_SharedMenuGfx27 ; $6936
	ld c, SharedMenuGfx27_SIZE / 16 ; $6938
	ld de, vTiles0 tile $70 + VRAM_BANK1 ; $693a
	farcall LoadCompressedTileBlock ; $693d
	call AdvanceFrame ; $6940
	ld b, TILEBLOCK_StatusTitleGfx ; $6943
	ld c, StatusTitleGfx_SIZE / 16 ; $6945
	ld de, vTiles0 ; $6947
	farcall LoadCompressedTileBlock ; $694a
	call AdvanceFrame ; $694d
	ld b, $08 ; $6950
	ld c, $10 ; $6952
	farcall LoadIndexedPalette ; $6954
	pop_wram_bank ; $6957
	ret ; $695c
Unused_3b_TableAfterLoadStatusSourceGfx:
	; $695d, 28 bytes (bytes:2)
	db $62, $3c ; 0x00
	db $64, $3c ; 0x02
	db $66, $3c ; 0x04
	db $68, $3c ; 0x06
	db $6a, $3c ; 0x08
	db $6c, $3c ; 0x0a
	db $6e, $3c ; 0x0c
	dw vTiles1 + VRAM_BANK1 ; 0x0e
	dw vTiles1 tile $10 + VRAM_BANK1 ; 0x10
	dw vTiles1 tile $20 + VRAM_BANK1 ; 0x12
	dw vTiles1 tile $30 + VRAM_BANK1 ; 0x14
	dw vTiles1 tile $40 + VRAM_BANK1 ; 0x16
	dw vTiles1 tile $50 + VRAM_BANK1 ; 0x18
	dw vTiles1 tile $60 + VRAM_BANK1 ; 0x1a
; MainMenuSlideIn with different start columns, end test (`cp $0c`) and row count: the same panel slide-in for a panel the bank never shows. Nothing calls it.
Unused_3b_SlideMenuPanel_1:
	ld a, b ; $6979
	or a ; $697a
	jr z, .slideBack ; $697b
	ld c, $00 ; $697d
.slideForwardLoop:
	call AdvanceFrame ; $697f
	ld b, PANELANIM_UNUSED_PANEL_IN ; $6982
	farcall RestoreMenuBgAndDrawPanel ; $6984
	ld b, MAPROWS_BANDS_4_9 ; $6987
	farcall FlushWram3MapRows ; $6989
	ld a, c ; $698c
	inc a ; $698d
	ld c, a ; $698e
	cp $0c ; $698f
	jr nz, .slideForwardLoop ; $6991
	ret ; $6993
.slideBack:
	ld c, $0a ; $6994
.slideBackLoop:
	call AdvanceFrame ; $6996
	ld b, PANELANIM_UNUSED_PANEL_OUT ; $6999
	farcall RestoreMenuBgAndDrawPanel ; $699b
	ld b, MAPROWS_BANDS_4_9 ; $699e
	farcall FlushWram3MapRows ; $69a0
	ld a, c ; $69a3
	dec a ; $69a4
	ld c, a ; $69a5
	cp $ff ; $69a6
	jr nz, .slideBackLoop ; $69a8
	ret ; $69aa
; MainMenuSlideOut with different start columns, end test (`cp $0d`) and row count: the slide-out matching Unused_3b_SlideMenuPanel_1. Nothing calls it.
Unused_3b_SlideMenuPanel_2:
	ld a, b ; $69ab
	or a ; $69ac
	jr z, .slideBack ; $69ad
	ld c, $00 ; $69af
.slideForwardLoop:
	call AdvanceFrame ; $69b1
	ld b, PANELANIM_UNUSED_PANEL_OUT ; $69b4
	farcall RestoreMenuBgAndDrawPanel ; $69b6
	ld b, MAPROWS_BANDS_4_9 ; $69b9
	farcall FlushWram3MapRows ; $69bb
	ld a, c ; $69be
	inc a ; $69bf
	ld c, a ; $69c0
	cp $0d ; $69c1
	jr nz, .slideForwardLoop ; $69c3
	ret ; $69c5
.slideBack:
	ld c, $0c ; $69c6
.slideBackLoop:
	call AdvanceFrame ; $69c8
	ld b, PANELANIM_UNUSED_PANEL_IN ; $69cb
	farcall RestoreMenuBgAndDrawPanel ; $69cd
	ld b, MAPROWS_BANDS_4_9 ; $69d0
	farcall FlushWram3MapRows ; $69d2
	ld a, c ; $69d5
	dec a ; $69d6
	ld c, a ; $69d7
	or a ; $69d8
	jr nz, .slideBackLoop ; $69d9
	ret ; $69db
StatusSourceCursorSpriteTask:
	farcall TickMenuBgScroll ; $69dc
	ld c, $03 ; $69df
	call GetMenuCursorIndex_3b ; $69e1
	push af ; $69e4
	ld hl, StatusSourceCursorTileBases ; $69e5
	add_hl_a ; $69e8
	ld c, [hl] ; $69ed
	pop af ; $69ee
	ld hl, StatusSourceCursorPositions ; $69ef
	add a ; $69f2
	add_hl_a ; $69f3
	ld a, [hl+] ; $69f8
	ld d, [hl] ; $69f9
	ld e, a ; $69fa
	farcall ApplySpriteBobOffset ; $69fb
	ld b, OAM_BANK1 ; $69fe
	ld hl, StatusSourceLabelTemplate ; $6a00
	push de ; $6a03
	call QueueSpriteTemplate ; $6a04
	pop de ; $6a07
	ld hl, $17f8 ; $6a08
	add hl, de ; $6a0b
	ld d, h ; $6a0c
	ld e, l ; $6a0d
	ld hl, StatusSourceLabelTailTemplate ; $6a0e
	sprite_attr_tile OAM_BANK1, $70 ; $6a11
	call QueueSpriteTemplate ; $6a15
	ret ; $6a18
StatusSourceLabelTemplate:
	; $6a19, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
StatusSourceLabelTailTemplate:
	; $6a3a, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
StatusSourceCursorPositions:
	; $6a43, 12 bytes (bytes:12)
	db $38, $fc, $38, $2c, $38, $5c, $60, $0c, $60, $4d, $60, $3e ; 0x00
StatusSourceCursorTileBases:
	; $6a4f, 6 bytes (bytes:6)
	db $00, $10, $20, $40, $30, $40 ; 0x00
Unused_3b_StatusSourceCursorWideTemplate:
	; $6a55, 41 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite $10, $48, $10, $00
	oam_sprite $10, $50, $12, $00
	oam_sprite_end
DrawStatusSourceGrid:
	wram_bank WRAM_SCREEN ; $6a7e
	ld b, $00 ; $6a84
	ld c, $00 ; $6a86
.loop:
	call FillStatusSourceCell ; $6a88
	ld a, b ; $6a8b
	inc a ; $6a8c
	ld b, a ; $6a8d
	cp $05 ; $6a8e
	jr nz, .loop ; $6a90
	ld c, $03 ; $6a92
	call GetMenuCursorIndex_3b ; $6a94
	ld b, a ; $6a97
	ld c, $01 ; $6a98
	call FillStatusSourceCell ; $6a9a
	ld c, $03 ; $6a9d
	call GetMenuCursorIndex_3b ; $6a9f
	cp $03 ; $6aa2
	jr nc, .loadStatusSourceCellPalette ; $6aa4
	add a ; $6aa6
	add a ; $6aa7
	add a ; $6aa8
	add a ; $6aa9
	ld bc, wSaveSlotSummaries ; $6aaa
	add_bc_a ; $6aad
	ld hl, SLOTSUM_PALETTE ; $6ab2
	add hl, bc ; $6ab5
	ld a, [hl] ; $6ab6
	ld d, $04 ; $6ab7
	farcall LoadIndexedPalette_18 ; $6ab9
	jr .fillTilemapRect ; $6abc
.loadStatusSourceCellPalette:
	call LoadStatusSourceCellPalette ; $6abe
.fillTilemapRect:
	wram_bank WRAM_SCREEN ; $6ac1
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH ; $6ac7
	rect_size $14, $01 ; $6aca
	ld h, $03 ; $6ace
	farcall FillTilemapRect ; $6ad0
	ld a, $02 ; $6ad3
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH], a ; $6ad5
	ld a, $04 ; $6ad8
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH + 19], a ; $6ada
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $6add
	rect_size $12, $01 ; $6ae0
	ld h, $20 ; $6ae4
	farcall FillTilemapRect ; $6ae6
	call DrawStatusSourceCaption ; $6ae9
	ld hl, wShadowAttrmap + 4 * TILEMAP_WIDTH ; $6aec
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH + VRAM_BANK1 ; $6aef
	ld c, 3 * TILEMAP_WIDTH / 16 ; $6af2
	call QueueVRAMCopy ; $6af4
	ld hl, wShadowAttrmap + 9 * TILEMAP_WIDTH ; $6af7
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH + VRAM_BANK1 ; $6afa
	ld c, 3 * TILEMAP_WIDTH / 16 ; $6afd
	call QueueVRAMCopy ; $6aff
	ld hl, wShadowTilemap + 15 * TILEMAP_WIDTH ; $6b02
	ld de, vBGMap0 + 15 * TILEMAP_WIDTH ; $6b05
	ld c, 2 * TILEMAP_WIDTH / 16 ; $6b08
	call QueueVRAMCopy ; $6b0a
	ret ; $6b0d
FillStatusSourceCell:
	push af ; $6b0e
	push bc ; $6b0f
	push de ; $6b10
	push hl ; $6b11
	ld d, c ; $6b12
	ld e, b ; $6b13
	ld a, b ; $6b14
	cp $03 ; $6b15
	jr nc, .wideCell ; $6b17
	ld b, $03 ; $6b19
	ld c, $03 ; $6b1b
	jr .pickAttr ; $6b1d
.wideCell:
	ld b, $05 ; $6b1f
	ld c, $03 ; $6b21
.pickAttr:
	ld a, d ; $6b23
	or a ; $6b24
	jr z, .unhighlighted ; $6b25
	ld h, $0c ; $6b27
	jr .fill ; $6b29
.unhighlighted:
	ld h, $0d ; $6b2b
.fill:
	push hl ; $6b2d
	ld hl, FillStatusSourceCellTable ; $6b2e
	ld a, e ; $6b31
	add a ; $6b32
	add_hl_a ; $6b33
	ld a, [hl+] ; $6b38
	ld d, [hl] ; $6b39
	ld e, a ; $6b3a
	pop hl ; $6b3b
	farcall FillTilemapRect ; $6b3c
	pop hl ; $6b3f
	pop de ; $6b40
	pop bc ; $6b41
	pop af ; $6b42
	ret ; $6b43
FillStatusSourceCellTable:
	; $6b44, 10 bytes (ram_ptrs:3)
	dw wShadowAttrmap + 4 * TILEMAP_WIDTH + 2 ; record 0
	dw wShadowAttrmap + 4 * TILEMAP_WIDTH + 8 ; record 1
	dw wShadowAttrmap + 4 * TILEMAP_WIDTH + 14 ; record 2
	dw wShadowAttrmap + 9 * TILEMAP_WIDTH + 3 ; record 3
	dw wShadowAttrmap + 9 * TILEMAP_WIDTH + 11 ; record 4
LoadStatusSourceCellPalette:
	ld hl, StatusSourceCellPalettePtrs ; $6b4e
	add a ; $6b51
	add_hl_a ; $6b52
	ld a, [hl+] ; $6b57
	ld h, [hl] ; $6b58
	ld l, a ; $6b59
	ld_bg_pals de, 4, 1 ; $6b5a
	call LoadPaletteShadow ; $6b5d
	ret ; $6b60
StatusSourceCellPalettePtrs:
	; $6b61, 18 bytes (records:2)
	dw StatusN64DataPalette ; record 0
	dw StatusN64DataPalette ; record 1
	dw StatusN64DataPalette ; record 2
	dw StatusMarioCharactersPalette ; record 3
	dw StatusN64DataPalette ; record 4
	dw StatusN64DataPalette ; record 5
	dw StatusN64DataPalette ; record 6
	dw StatusN64DataPalette ; record 7
	dw StatusN64DataPalette ; record 8
StatusN64DataPalette:
	INCLUDE "data/engine/menus/main_menu/StatusN64DataPalette.asm" ; $6b73, 8 bytes (palettes)
StatusMarioCharactersPalette:
	INCLUDE "data/engine/menus/main_menu/StatusMarioCharactersPalette.asm" ; $6b7b, 8 bytes (palettes)
DrawStatusSourceCaption:
	push_wram_bank WRAM_SCREEN ; $6b83
	ld c, $03 ; $6b8c
	call GetMenuCursorIndex_3b ; $6b8e
	ld b, a ; $6b91
	cp $03 ; $6b92
	jp nc, .compare ; $6b94
	add a ; $6b97
	add a ; $6b98
	add a ; $6b99
	add a ; $6b9a
	ld bc, wSaveSlotSummaries ; $6b9b
	add_bc_a ; $6b9e
	ld hl, SLOTSUM_CHAR ; $6ba3
	add hl, bc ; $6ba6
	ld a, [hl] ; $6ba7
	cp CHAR_EMPTY_SLOT ; $6ba8
	jr z, .emptySlot ; $6baa
	ld hl, SLOTSUM_NAME ; $6bac
	add hl, bc ; $6baf
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $6bb0
	call DrawNameWithDiacritics_3b ; $6bb3
	ld a, $4c ; $6bb6
	ld [wShadowTilemap + 16 * TILEMAP_WIDTH + 9], a ; $6bb8
	ld a, $56 ; $6bbb
	ld [wShadowTilemap + 16 * TILEMAP_WIDTH + 10], a ; $6bbd
	push af ; $6bc0
	push bc ; $6bc1
	push de ; $6bc2
	push hl ; $6bc3
	ld hl, SLOTSUM_LEVEL ; $6bc4
	add hl, bc ; $6bc7
	ld a, [hl] ; $6bc8
	ld h, $00 ; $6bc9
	ld l, a ; $6bcb
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 12 ; $6bcc
	ld bc, wShadowTilemap + 25 * TILEMAP_WIDTH + 16 ; $6bcf
	call PrintNumberRightAligned ; $6bd2
	pop hl ; $6bd5
	pop de ; $6bd6
	pop bc ; $6bd7
	pop af ; $6bd8
	push af ; $6bd9
	push bc ; $6bda
	push de ; $6bdb
	push hl ; $6bdc
	ld hl, SLOTSUM_HOURS ; $6bdd
	add hl, bc ; $6be0
	ld a, [hl] ; $6be1
	ld h, $00 ; $6be2
	ld l, a ; $6be4
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 15 ; $6be5
	ld bc, wShadowTilemap + 25 * TILEMAP_WIDTH + 16 ; $6be8
	call Print2DigitNumberRightAligned ; $6beb
	pop hl ; $6bee
	pop de ; $6bef
	pop bc ; $6bf0
	pop af ; $6bf1
	ld hl, SLOTSUM_MINUTES ; $6bf2
	add hl, bc ; $6bf5
	ld a, [hl] ; $6bf6
	ld h, $00 ; $6bf7
	ld l, a ; $6bf9
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 18 ; $6bfa
	ld bc, wShadowTilemap + 25 * TILEMAP_WIDTH + 16 ; $6bfd
	call Print2DigitNumberRightAligned ; $6c00
	ld a, $3a ; $6c03
	ld [wShadowTilemap + 16 * TILEMAP_WIDTH + 16], a ; $6c05
	pop_wram_bank ; $6c08
	ret ; $6c0d
.emptySlot:
	ld hl, Text_StatusNoDataInFile ; $6c0e
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $6c11
	ld c, $20 ; $6c14
	farcall RenderTextToBuffer64 ; $6c16
	jr .restore ; $6c19
.compare:
	cp $04 ; $6c1b
	jr nz, .otherItem ; $6c1d
	ld hl, Text_StatusN64TennisData ; $6c1f
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $6c22
	ld c, $20 ; $6c25
	farcall RenderTextToBuffer64 ; $6c27
	jr .restore ; $6c2a
.otherItem:
	ld hl, Text_StatusMarioCharData ; $6c2c
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $6c2f
	ld c, $20 ; $6c32
	farcall RenderTextToBuffer64 ; $6c34
.restore:
	pop_wram_bank ; $6c37
	ret ; $6c3c
