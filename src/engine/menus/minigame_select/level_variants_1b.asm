FlushLevelSelectTextRows:
	push_wram_bank WRAM_SCREEN ; $6dc6
	ld hl, wShadowAttrmap + 7 * TILEMAP_WIDTH ; $6dcf
	ld de, vBGMap0 + 7 * TILEMAP_WIDTH + VRAM_BANK1 ; $6dd2
	ld c, 3 * TILEMAP_WIDTH / 16 ; $6dd5
	call QueueVRAMCopy ; $6dd7
	ld hl, wShadowTilemap + 15 * TILEMAP_WIDTH ; $6dda
	ld de, vBGMap0 + 15 * TILEMAP_WIDTH ; $6ddd
	ld c, 2 * TILEMAP_WIDTH / 16 ; $6de0
	call QueueVRAMCopy ; $6de2
	pop_wram_bank ; $6de5
	ret ; $6dea
ClearMinigameLevelDescriptionRow:
	push_wram_bank WRAM_SCREEN ; $6deb
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH ; $6df4
	rect_size $14, $01 ; $6df7
	ld h, $03 ; $6dfb
	farcall FillTilemapRect ; $6dfd
	ld a, $02 ; $6e00
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH], a ; $6e02
	ld a, $04 ; $6e05
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH + 19], a ; $6e07
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $6e0a
	rect_size $12, $01 ; $6e0d
	ld h, $20 ; $6e11
	farcall FillTilemapRect ; $6e13
	pop_wram_bank ; $6e16
	ret ; $6e1b
GetMinigameLevelColumnCount:
	push af ; $6e1c
	push_wram_bank WRAM_COURT_PLANES ; $6e1d
	ld a, [wLevelSelectColumns] ; $6e26
	ld b, a ; $6e29
	pop_wram_bank ; $6e2a
	pop af ; $6e2f
	ret ; $6e30
RunMinigameLevelSelect2:
	call ResumeBGM ; $6e31
	sound BGM_MARIO_MINIGAME ; $6e34
	ld hl, rIE ; $6e36
	res B_IE_TIMER, [hl] ; $6e39
	wram_bank WRAM_SCREEN ; $6e3b
	ld a, [wMenuSlideDirection] ; $6e41
	ld b, a ; $6e44
	farcall OpenChoiceTabPanel ; $6e45
	farcall InitMenuBgScroll ; $6e48
	ld b, $01 ; $6e4b
	ld c, $01 ; $6e4d
	farcall LoadMenuSpritePalettePair ; $6e4f
	wram_bank WRAM_COURT_PLANES ; $6e52
	ld a, [wLevelSelectClearedCount] ; $6e58
	ld c, a ; $6e5b
	ld b, $02 ; $6e5c
	call SetMenuCursorFromIndex ; $6e5e
	wram_bank WRAM_SCREEN ; $6e61
	frame_task DrawMinigameLevelSelect2Cursor ; $6e67
	call RedrawMinigameLevelSelect2 ; $6e6f
	wram_bank WRAM_SCREEN ; $6e72
.loop:
	call AdvanceFrame ; $6e78
	ldh a, [hInputPressed] ; $6e7b
	ld [wMenuInputPressed], a ; $6e7d
	call GetMinigameLevelColumnCount ; $6e80
	ld c, $01 ; $6e83
	call MoveMenuCursorGrid_1b ; $6e85
	or a ; $6e88
	jr z, .checkMenuInputPressed ; $6e89
	sound SFX_MENU_MOVE ; $6e8b
	call RedrawMinigameLevelSelect2 ; $6e8d
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $6e90
	bit PADB_A, a ; $6e93
	jr nz, .getMenuCursorIndex ; $6e95
	bit PADB_B, a ; $6e97
	jr nz, .playCancelSfx ; $6e99
	jr .loop ; $6e9b
.getMenuCursorIndex:
	ld c, $03 ; $6e9d
	call GetMenuCursorIndex_1b ; $6e9f
	or a ; $6ea2
	jr z, .playSelectSfx ; $6ea3
	wram_bank WRAM_COURT_PLANES ; $6ea5
	ld a, [wLevelSelectClearedCount] ; $6eab
	or a ; $6eae
	jr nz, .playSelectSfx ; $6eaf
	sound SFX_MENU_LOCKED ; $6eb1
	jr .loop ; $6eb3
.playSelectSfx:
	sound SFX_MENU_SELECT ; $6eb5
	call ClearFrameTasks ; $6eb7
	ld hl, rIE ; $6eba
	set B_IE_TIMER, [hl] ; $6ebd
	wram_bank WRAM_SCREEN ; $6ebf
	ld b, MENUSLIDE_FORWARD ; $6ec5
	farcall CloseChoiceTabPanel ; $6ec7
	ld a, MENUSLIDE_FORWARD ; $6eca
	ld [wMenuSlideDirection], a ; $6ecc
	wram_bank WRAM_COURT_PLANES ; $6ecf
	ld c, $03 ; $6ed5
	call GetMenuCursorIndex_1b ; $6ed7
	ld [wLevelSelectResult], a ; $6eda
	ret ; $6edd
.playCancelSfx:
	sound SFX_MENU_CANCEL ; $6ede
	call ClearFrameTasks ; $6ee0
	ld hl, rIE ; $6ee3
	set B_IE_TIMER, [hl] ; $6ee6
	wram_bank WRAM_SCREEN ; $6ee8
	ld b, MENUSLIDE_BACK ; $6eee
	farcall CloseChoiceTabPanel ; $6ef0
	ld a, MENUSLIDE_BACK ; $6ef3
	ld [wMenuSlideDirection], a ; $6ef5
	wram_bank WRAM_COURT_PLANES ; $6ef8
	ld a, $ff ; $6efe
	ld [wLevelSelectResult], a ; $6f00
	ret ; $6f03
RedrawMinigameLevelSelect2:
	wram_bank WRAM_SCREEN ; $6f04
	ld b, $00 ; $6f0a
	ld c, ATTRRECT_INACTIVE ; $6f0c
.loop:
	call SetSelectPanelAttrRect ; $6f0e
	ld a, b ; $6f11
	inc a ; $6f12
	ld b, a ; $6f13
	cp $02 ; $6f14
	jr nz, .loop ; $6f16
	ld c, $02 ; $6f18
	call GetMenuCursorIndex_1b ; $6f1a
	ld b, a ; $6f1d
	ld c, ATTRRECT_SELECTED ; $6f1e
	call SetSelectPanelAttrRect ; $6f20
	ld c, $03 ; $6f23
	call GetMenuCursorIndex_1b ; $6f25
	call LoadMinigameLevelSelectPalette ; $6f28
	call ClearMinigameLevelDescriptionRow ; $6f2b
	call DrawMinigameLevelDescription ; $6f2e
	call FlushLevelSelectTextRows ; $6f31
	ret ; $6f34
SetSelectPanelAttrRect:
	push af ; $6f35
	push bc ; $6f36
	push de ; $6f37
	push hl ; $6f38
	ld a, c ; $6f39
	or a ; $6f3a
	jr z, .inactiveAttr ; $6f3b
	ld h, $0c ; $6f3d
	jr .lookup ; $6f3f
.inactiveAttr:
	ld h, $0d ; $6f41
.lookup:
	push hl ; $6f43
	ld hl, SelectPanelAttrRectTable ; $6f44
	ld a, b ; $6f47
	add a ; $6f48
	add_hl_a ; $6f49
	ld a, [hl+] ; $6f4e
	ld d, [hl] ; $6f4f
	ld e, a ; $6f50
	pop hl ; $6f51
	rect_size $05, $03 ; $6f52
	farcall FillTilemapRect ; $6f56
	pop hl ; $6f59
	pop de ; $6f5a
	pop bc ; $6f5b
	pop af ; $6f5c
	ret ; $6f5d
SelectPanelAttrRectTable:
	; $6f5e, 4 bytes (ram_ptrs:3)
	dw wShadowAttrmap + 7 * TILEMAP_WIDTH + 3 ; record 0
	dw wShadowAttrmap + 7 * TILEMAP_WIDTH + 12 ; record 1
DrawMinigameLevelSelect2Cursor:
	farcall TickMenuBgScroll ; $6f62
	ld c, $03 ; $6f65
	call GetMenuCursorIndex_1b ; $6f67
	push af ; $6f6a
	ld hl, MinigameLevelSelect2CursorTileBases ; $6f6b
	add_hl_a ; $6f6e
	ld c, [hl] ; $6f73
	pop af ; $6f74
	ld hl, MinigameLevelSelect2CursorPositions ; $6f75
	add a ; $6f78
	add_hl_a ; $6f79
	ld a, [hl+] ; $6f7e
	ld d, [hl] ; $6f7f
	ld e, a ; $6f80
	farcall ApplySpriteBobOffset ; $6f81
	ld b, OAM_BANK1 ; $6f84
	ld hl, DrawMinigameLevelSelect2Cursor_SpriteTemplate0 ; $6f86
	push de ; $6f89
	call QueueSpriteTemplate ; $6f8a
	pop de ; $6f8d
	ld hl, $17f8 ; $6f8e
	add hl, de ; $6f91
	ld d, h ; $6f92
	ld e, l ; $6f93
	ld hl, DrawMinigameLevelSelect2Cursor_SpriteTemplate1 ; $6f94
	sprite_attr_tile OAM_BANK1, $70 ; $6f97
	call QueueSpriteTemplate ; $6f9b
	ret ; $6f9e
DrawMinigameLevelSelect2Cursor_SpriteTemplate0:
	; $6f9f, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
DrawMinigameLevelSelect2Cursor_SpriteTemplate1:
	; $6fc0, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
MinigameLevelSelect2CursorPositions:
	; $6fc9, 6 bytes (bytes:6)
	db $50, $0c, $50, $54, $50, $5c ; 0x00
MinigameLevelSelect2CursorTileBases:
	; $6fcf, 3 bytes (bytes:3)
	db $00, $10, $20 ; 0x00
RunMinigameLevelSelect3:
	call ResumeBGM ; $6fd2
	sound BGM_MARIO_MINIGAME ; $6fd5
	ld hl, rIE ; $6fd7
	res B_IE_TIMER, [hl] ; $6fda
	wram_bank WRAM_SCREEN ; $6fdc
	ld a, [wMenuSlideDirection] ; $6fe2
	ld b, a ; $6fe5
	farcall ThreeChoiceSlideIn ; $6fe6
	farcall InitMenuBgScroll ; $6fe9
	ld b, $01 ; $6fec
	ld c, $01 ; $6fee
	farcall LoadMenuSpritePalettePair ; $6ff0
	wram_bank WRAM_COURT_PLANES ; $6ff3
	ld a, [wLevelSelectClearedCount] ; $6ff9
	ld c, a ; $6ffc
	ld b, $03 ; $6ffd
	call SetMenuCursorFromIndex ; $6fff
	wram_bank WRAM_SCREEN ; $7002
	frame_task DrawMinigameLevelSelect3Cursor ; $7008
	call RedrawMinigameLevelSelect3 ; $7010
	wram_bank WRAM_SCREEN ; $7013
.loop:
	call AdvanceFrame ; $7019
	ldh a, [hInputPressed] ; $701c
	ld [wMenuInputPressed], a ; $701e
	call GetMinigameLevelColumnCount ; $7021
	ld c, $01 ; $7024
	call MoveMenuCursorGrid_1b ; $7026
	or a ; $7029
	jr z, .checkMenuInputPressed ; $702a
	sound SFX_MENU_MOVE ; $702c
	call RedrawMinigameLevelSelect3 ; $702e
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $7031
	bit PADB_A, a ; $7034
	jr nz, .playSelectSfx ; $7036
	bit PADB_B, a ; $7038
	jr nz, .playCancelSfx ; $703a
	jr .loop ; $703c
.playSelectSfx:
	sound SFX_MENU_SELECT ; $703e
	call ClearFrameTasks ; $7040
	ld hl, rIE ; $7043
	set B_IE_TIMER, [hl] ; $7046
	wram_bank WRAM_SCREEN ; $7048
	ld b, MENUSLIDE_FORWARD ; $704e
	farcall ThreeChoiceSlideOut ; $7050
	ld a, MENUSLIDE_FORWARD ; $7053
	ld [wMenuSlideDirection], a ; $7055
	wram_bank WRAM_COURT_PLANES ; $7058
	ld c, $03 ; $705e
	call GetMenuCursorIndex_1b ; $7060
	ld [wLevelSelectResult], a ; $7063
	ret ; $7066
.playCancelSfx:
	sound SFX_MENU_CANCEL ; $7067
	call ClearFrameTasks ; $7069
	ld hl, rIE ; $706c
	set B_IE_TIMER, [hl] ; $706f
	wram_bank WRAM_SCREEN ; $7071
	ld b, MENUSLIDE_BACK ; $7077
	farcall ThreeChoiceSlideOut ; $7079
	ld a, MENUSLIDE_BACK ; $707c
	ld [wMenuSlideDirection], a ; $707e
	wram_bank WRAM_COURT_PLANES ; $7081
	ld a, $ff ; $7087
	ld [wLevelSelectResult], a ; $7089
	ret ; $708c
RedrawMinigameLevelSelect3:
	wram_bank WRAM_SCREEN ; $708d
	ld b, $00 ; $7093
	ld c, ATTRRECT_INACTIVE ; $7095
.loop:
	call SetSelectPanelAttrRect3 ; $7097
	ld a, b ; $709a
	inc a ; $709b
	ld b, a ; $709c
	cp $03 ; $709d
	jr nz, .loop ; $709f
	ld c, $02 ; $70a1
	call GetMenuCursorIndex_1b ; $70a3
	ld b, a ; $70a6
	ld c, ATTRRECT_SELECTED ; $70a7
	call SetSelectPanelAttrRect3 ; $70a9
	ld c, $03 ; $70ac
	call GetMenuCursorIndex_1b ; $70ae
	call LoadMinigameLevelSelectPalette ; $70b1
	call ClearMinigameLevelDescriptionRow ; $70b4
	call DrawMinigameLevelDescription ; $70b7
	call FlushLevelSelectTextRows ; $70ba
	ret ; $70bd
SetSelectPanelAttrRect3:
	push af ; $70be
	push bc ; $70bf
	push de ; $70c0
	push hl ; $70c1
	ld a, c ; $70c2
	or a ; $70c3
	jr z, .unhighlighted ; $70c4
	ld h, $0c ; $70c6
	jr .fill ; $70c8
.unhighlighted:
	ld h, $0d ; $70ca
.fill:
	push hl ; $70cc
	ld hl, SelectPanelAttrRect3Table ; $70cd
	ld a, b ; $70d0
	add a ; $70d1
	add_hl_a ; $70d2
	ld a, [hl+] ; $70d7
	ld d, [hl] ; $70d8
	ld e, a ; $70d9
	pop hl ; $70da
	rect_size $05, $03 ; $70db
	farcall FillTilemapRect ; $70df
	pop hl ; $70e2
	pop de ; $70e3
	pop bc ; $70e4
	pop af ; $70e5
	ret ; $70e6
SelectPanelAttrRect3Table:
	; $70e7, 6 bytes (ram_ptrs:3)
	dw wShadowAttrmap + 7 * TILEMAP_WIDTH + 1 ; record 0
	dw wShadowAttrmap + 7 * TILEMAP_WIDTH + 7 ; record 1
	dw wShadowAttrmap + 7 * TILEMAP_WIDTH + 13 ; record 2
DrawMinigameLevelSelect3Cursor:
	farcall TickMenuBgScroll ; $70ed
	ld c, $03 ; $70f0
	call GetMenuCursorIndex_1b ; $70f2
	push af ; $70f5
	ld hl, MinigameLevelSelect3CursorTileBases ; $70f6
	add_hl_a ; $70f9
	ld c, [hl] ; $70fe
	pop af ; $70ff
	ld hl, MinigameLevelSelect3CursorPositions ; $7100
	add a ; $7103
	add_hl_a ; $7104
	ld a, [hl+] ; $7109
	ld d, [hl] ; $710a
	ld e, a ; $710b
	farcall ApplySpriteBobOffset ; $710c
	ld b, OAM_BANK1 ; $710f
	ld hl, DrawMinigameLevelSelect3Cursor_SpriteTemplate0 ; $7111
	push de ; $7114
	call QueueSpriteTemplate ; $7115
	pop de ; $7118
	ld hl, $17f8 ; $7119
	add hl, de ; $711c
	ld d, h ; $711d
	ld e, l ; $711e
	ld hl, DrawMinigameLevelSelect3Cursor_SpriteTemplate1 ; $711f
	sprite_attr_tile OAM_BANK1, $70 ; $7122
	call QueueSpriteTemplate ; $7126
	ret ; $7129
DrawMinigameLevelSelect3Cursor_SpriteTemplate0:
	; $712a, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
DrawMinigameLevelSelect3Cursor_SpriteTemplate1:
	; $714b, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
MinigameLevelSelect3CursorPositions:
	; $7154, 6 bytes (bytes:6)
	db $50, $fc, $50, $2c, $50, $5c ; 0x00
MinigameLevelSelect3CursorTileBases:
	; $715a, 3 bytes (bytes:3)
	db $00, $10, $20 ; 0x00
RunSavedDataTypeSelect:
	sound BGM_MENU ; $715d
	ld hl, rIE ; $715f
	res B_IE_TIMER, [hl] ; $7162
	call LoadSavedDataTypeSelectGfx ; $7164
	wram_bank WRAM_SCREEN ; $7167
	ld a, [wMenuSlideDirection] ; $716d
	ld b, a ; $7170
	farcall OpenChoiceTabPanel ; $7171
	farcall InitMenuBgScroll ; $7174
	ld b, $01 ; $7177
	ld c, $01 ; $7179
	farcall LoadMenuSpritePalettePair ; $717b
	ld a, [wSavedDataTypeTabIndex] ; $717e
	ld c, a ; $7181
	ld b, $02 ; $7182
	call SetMenuCursorFromIndex ; $7184
	frame_task TickMenuBgScrollTask_1b ; $7187
	frame_task DrawSavedDataTypeSelectCursor ; $718f
	call RedrawSavedDataTypeSelect ; $7197
	wram_bank WRAM_SCREEN ; $719a
.loop:
	call AdvanceFrame ; $71a0
	ldh a, [hInputPressed] ; $71a3
	ld [wMenuInputPressed], a ; $71a5
	ld b, $02 ; $71a8
	ld c, $01 ; $71aa
	call MoveMenuCursorGrid_1b ; $71ac
	or a ; $71af
	jr z, .checkMenuInputPressed ; $71b0
	sound SFX_MENU_MOVE ; $71b2
	call RedrawSavedDataTypeSelect ; $71b4
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $71b7
	bit PADB_A, a ; $71ba
	jr nz, .playSelectSfx ; $71bc
	bit PADB_B, a ; $71be
	jr nz, .playCancelSfx ; $71c0
	jr .loop ; $71c2
.playSelectSfx:
	sound SFX_MENU_SELECT ; $71c4
	call ClearFrameTasks ; $71c6
	ld hl, rIE ; $71c9
	set B_IE_TIMER, [hl] ; $71cc
	wram_bank WRAM_SCREEN ; $71ce
	ld b, MENUSLIDE_FORWARD ; $71d4
	farcall CloseChoiceTabPanel ; $71d6
	ld a, MENUSLIDE_FORWARD ; $71d9
	ld [wMenuSlideDirection], a ; $71db
	ld c, $02 ; $71de
	call GetMenuCursorIndex_1b ; $71e0
	ld [wSavedDataTypeTabIndex], a ; $71e3
	ret ; $71e6
.playCancelSfx:
	sound SFX_MENU_CANCEL ; $71e7
	call ClearFrameTasks ; $71e9
	ld hl, rIE ; $71ec
	set B_IE_TIMER, [hl] ; $71ef
	wram_bank WRAM_SCREEN ; $71f1
	ld b, MENUSLIDE_BACK ; $71f7
	farcall CloseChoiceTabPanel ; $71f9
	ld a, MENUSLIDE_BACK ; $71fc
	ld [wMenuSlideDirection], a ; $71fe
	wram_bank WRAM_COURT_PLANES ; $7201
	ld a, $ff ; $7207
	ret ; $7209
LoadSavedDataTypeSelectGfx:
	push_wram_bank WRAM_STAGING ; $720a
	ld c, $00 ; $7213
.loop:
	ld a, c ; $7215
	add a ; $7216
	ld hl, SavedDataTypeLabelTilePtrs ; $7217
	add_hl_a ; $721a
	ld a, [hl+] ; $721f
	ld h, [hl] ; $7220
	ld l, a ; $7221
	push af ; $7222
	push bc ; $7223
	push de ; $7224
	push hl ; $7225
	ld de, wDecompBuffer ; $7226
	call DecompressDataFromBank ; $7229
	pop hl ; $722c
	pop de ; $722d
	pop bc ; $722e
	pop af ; $722f
	ld hl, SavedDataTypeLabelTileVramDests ; $7230
	ld a, c ; $7233
	add a ; $7234
	add_hl_a ; $7235
	ld a, [hl+] ; $723a
	ld d, [hl] ; $723b
	ld e, a ; $723c
	ld hl, wDecompBuffer ; $723d
	push af ; $7240
	push bc ; $7241
	push de ; $7242
	push hl ; $7243
	ld bc, 16 ; $7244
	call QueueVRAMCopy ; $7247
	pop hl ; $724a
	pop de ; $724b
	pop bc ; $724c
	pop af ; $724d
	ld a, c ; $724e
	inc a ; $724f
	ld c, a ; $7250
	call AdvanceFrame ; $7251
	ld a, c ; $7254
	cp $02 ; $7255
	jr nz, .loop ; $7257
	ld b, TILEBLOCK_SharedMenuGfx29 ; $7259
	ld c, SharedMenuGfx29_SIZE / 16 ; $725b
	ld de, vTiles0 + VRAM_BANK1 ; $725d
	farcall LoadCompressedTileBlock ; $7260
	call AdvanceFrame ; $7263
	ld b, TILEBLOCK_SharedMenuGfx30 ; $7266
	ld c, SharedMenuGfx30_SIZE / 16 ; $7268
	ld de, vTiles0 tile $10 + VRAM_BANK1 ; $726a
	farcall LoadCompressedTileBlock ; $726d
	call AdvanceFrame ; $7270
	ld b, TILEBLOCK_SharedMenuGfx27 ; $7273
	ld c, SharedMenuGfx27_SIZE / 16 ; $7275
	ld de, vTiles0 tile $70 + VRAM_BANK1 ; $7277
	farcall LoadCompressedTileBlock ; $727a
	call AdvanceFrame ; $727d
	ld b, TILEBLOCK_SavedDataTypeSelectGfx ; $7280
	ld c, SavedDataTypeSelectGfx_SIZE / 16 ; $7282
	ld de, vTiles0 ; $7284
	farcall LoadCompressedTileBlock ; $7287
	call AdvanceFrame ; $728a
	ld b, $08 ; $728d
	ld c, $10 ; $728f
	farcall LoadIndexedPalette ; $7291
	pop_wram_bank ; $7294
	ret ; $7299
SavedDataTypeLabelTilePtrs:
	; $729a, 2 slot words
	dslot DataPtr_ExhibitionIconTiles ; record 0
	dslot DataPtr_MushroomIconTiles ; record 1
SavedDataTypeLabelTileVramDests:
	; $729e, 6 bytes (records:2)
	dw vTiles1 + VRAM_BANK1 ; record 0
	dw vTiles1 tile $10 + VRAM_BANK1 ; record 1
	dw vTiles1 tile $20 + VRAM_BANK1 ; record 2
