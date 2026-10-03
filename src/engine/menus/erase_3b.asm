LoadN64RecordsToWram2:
	push_wram_bank WRAM_COURT_PLANES ; $6c3d
	ld hl, wScreenAttrmap ; $6c46
	ld bc, $0020 ; $6c49
	call ClearMemory16 ; $6c4c
	ld hl, wScreenAttrmap ; $6c4f
	ld b, SAVEBLOCK_N64_RECORDS ; $6c52
	farcall ReadSaveBlock ; $6c54
	pop_wram_bank ; $6c57
	ret ; $6c5c
CheckN64DataPresent:
	push_wram_bank WRAM_COURT_PLANES ; $6c5d
	ld a, [wN64BlockProbe] ; $6c66
	ld b, a ; $6c69
	ld a, [wN64BlockProbe + 1] ; $6c6a
	or b ; $6c6d
	jr z, .restore ; $6c6e
	pop_wram_bank ; $6c70
	ld a, $01 ; $6c75
	ret ; $6c77
.restore:
	pop_wram_bank ; $6c78
	xor a ; $6c7d
	ret ; $6c7e
RunEraseSavedDataSelect:
	ld hl, rIE ; $6c7f
	res 2, [hl] ; $6c82
	sound BGM_MENU ; $6c84
	call BuildSaveSlotSummaries ; $6c86
	call LoadEraseSavedDataGfx ; $6c89
	wram_bank WRAM_SCREEN ; $6c8c
	ld a, [wMenuSlideDirection] ; $6c92
	ld b, a ; $6c95
	call SavedDataPickerSlideIn ; $6c96
	farcall InitMenuBgScroll ; $6c99
	ld b, $01 ; $6c9c
	ld c, $01 ; $6c9e
	farcall LoadMenuSpritePalettePair ; $6ca0
	ld c, $00 ; $6ca3
	ld b, $03 ; $6ca5
	call SetMenuCursorFromIndex_3b ; $6ca7
	ld a, $01 ; $6caa
	ld hl, EraseSavedDataCursorSpriteTask ; $6cac
	call RegisterFrameTask ; $6caf
	call DrawEraseSavedDataGrid ; $6cb2
	wram_bank WRAM_SCREEN ; $6cb5
.loop:
	ldh a, [hInputPressed] ; $6cbb
	ld [wMenuInputPressed], a ; $6cbd
	call MoveSavedDataPickerCursor ; $6cc0
	or a ; $6cc3
	jr z, .advanceFrame ; $6cc4
	sound SFX_MENU_MOVE ; $6cc6
	call DrawEraseSavedDataGrid ; $6cc8
.advanceFrame:
	call AdvanceFrame ; $6ccb
	ld a, [wMenuInputPressed] ; $6cce
	bit PADB_A, a ; $6cd1
	jr nz, .getMenuCursorCellIndex ; $6cd3
	bit 1, a ; $6cd5
	jr nz, .playSfx3 ; $6cd7
	jr .loop ; $6cd9
.getMenuCursorCellIndex:
	ld c, $03 ; $6cdb
	call GetMenuCursorIndex_3b ; $6cdd
	cp $03 ; $6ce0
	jp nc, .playSfx2 ; $6ce2
	add a ; $6ce5
	add a ; $6ce6
	add a ; $6ce7
	add a ; $6ce8
	ld bc, wShadowTilemap + 24 * TILEMAP_WIDTH ; $6ce9
	add c ; $6cec
	ld c, a ; $6ced
	jr nc, .gotPtr ; $6cee
	inc b ; $6cf0
.gotPtr:
	ld hl, $0000 ; $6cf1
	add hl, bc ; $6cf4
	ld a, [hl] ; $6cf5
	cp $3f ; $6cf6
	jr z, .playSfx ; $6cf8
	jr .playSfx2 ; $6cfa
.playSfx:
	sound SFX_MENU_CANCEL ; $6cfc
	jr .loop ; $6cfe
.playSfx2:
	sound SFX_MENU_SELECT ; $6d00
	call ClearFrameTasks ; $6d02
	ld hl, rIE ; $6d05
	set 2, [hl] ; $6d08
	ld b, $01 ; $6d0a
	call SavedDataPickerSlideOut ; $6d0c
	ld a, MENUSLIDE_FORWARD ; $6d0f
	ld [wMenuSlideDirection], a ; $6d11
	ld c, $03 ; $6d14
	call GetMenuCursorIndex_3b ; $6d16
	ret ; $6d19
.playSfx3:
	sound SFX_MENU_CANCEL ; $6d1a
	call ClearFrameTasks ; $6d1c
	ld hl, rIE ; $6d1f
	set 2, [hl] ; $6d22
	ld b, $00 ; $6d24
	call SavedDataPickerSlideOut ; $6d26
	ld a, MENUSLIDE_BACK ; $6d29
	ld [wMenuSlideDirection], a ; $6d2b
	ld a, $ff ; $6d2e
	ret ; $6d30
LoadEraseSavedDataGfx:
	push_wram_bank WRAM_STAGING ; $6d31
	wram_bank WRAM_SCREEN ; $6d3a
	ld a, $00 ; $6d40
	ld [wCurrentStorySlot], a ; $6d42
	ld a, [wShadowTilemap + 24 * TILEMAP_WIDTH] ; $6d45
	farcall LoadCharMugshotToBuffer ; $6d48
	ld de, vTiles2 + $68 * TILE_SIZE + VRAM_BANK1 ; $6d4b
	farcall CopyMugshotBufferToVram ; $6d4e
	call AdvanceFrame ; $6d51
	wram_bank WRAM_SCREEN ; $6d54
	ld a, $01 ; $6d5a
	ld [wCurrentStorySlot], a ; $6d5c
	ld a, [wShadowTilemap + 24 * TILEMAP_WIDTH + 16] ; $6d5f
	farcall LoadCharMugshotToBuffer ; $6d62
	ld de, vTiles2 + $71 * TILE_SIZE + VRAM_BANK1 ; $6d65
	farcall CopyMugshotBufferToVram ; $6d68
	call AdvanceFrame ; $6d6b
	wram_bank WRAM_SCREEN ; $6d6e
	ld a, $02 ; $6d74
	ld [wCurrentStorySlot], a ; $6d76
	ld a, [wShadowTilemap + 25 * TILEMAP_WIDTH] ; $6d79
	farcall LoadCharMugshotToBuffer ; $6d7c
	ld de, vTiles1 + $70 * TILE_SIZE + VRAM_BANK1 ; $6d7f
	farcall CopyMugshotBufferToVram ; $6d82
	call AdvanceFrame ; $6d85
	wram_bank WRAM_STAGING ; $6d88
	ld_slot hl, DataPtr_N64TransferLabelTiles0 ; $6d8e
	ld de, wDecompBuffer ; $6d91
	call DecompressDataFromBank ; $6d94
	ld hl, wDecompBuffer ; $6d97
	ld de, vTiles1 + VRAM_BANK1 ; $6d9a
	ld c, $10 ; $6d9d
	call QueueVRAMCopy ; $6d9f
	call AdvanceFrame ; $6da2
	ld_slot hl, DataPtr_N64TransferLabelTiles1 ; $6da5
	ld de, wDecompBuffer ; $6da8
	call DecompressDataFromBank ; $6dab
	ld hl, wDecompBuffer ; $6dae
	ld de, vTiles1 + $10 * TILE_SIZE + VRAM_BANK1 ; $6db1
	ld c, $10 ; $6db4
	call QueueVRAMCopy ; $6db6
	call AdvanceFrame ; $6db9
	ld b, TILEBLOCK_EraseSavedDataGfx0 ; $6dbc
	ld c, EraseSavedDataGfx0_SIZE / 16 ; $6dbe
	ld de, vTiles0 + VRAM_BANK1 ; $6dc0
	farcall LoadCompressedTileBlock ; $6dc3
	call AdvanceFrame ; $6dc6
	ld b, TILEBLOCK_EraseSavedDataGfx1 ; $6dc9
	ld c, EraseSavedDataGfx1_SIZE / 16 ; $6dcb
	ld de, vTiles0 + $10 * TILE_SIZE + VRAM_BANK1 ; $6dcd
	farcall LoadCompressedTileBlock ; $6dd0
	call AdvanceFrame ; $6dd3
	ld b, TILEBLOCK_EraseSavedDataGfx2 ; $6dd6
	ld c, EraseSavedDataGfx2_SIZE / 16 ; $6dd8
	ld de, vTiles0 + $20 * TILE_SIZE + VRAM_BANK1 ; $6dda
	farcall LoadCompressedTileBlock ; $6ddd
	call AdvanceFrame ; $6de0
	ld b, TILEBLOCK_EraseSavedDataGfx3 ; $6de3
	ld c, EraseSavedDataGfx3_SIZE / 16 ; $6de5
	ld de, vTiles0 + $30 * TILE_SIZE + VRAM_BANK1 ; $6de7
	farcall LoadCompressedTileBlock ; $6dea
	call AdvanceFrame ; $6ded
	ld b, TILEBLOCK_EraseSavedDataGfx4 ; $6df0
	ld c, EraseSavedDataGfx4_SIZE / 16 ; $6df2
	ld de, vTiles0 + $40 * TILE_SIZE + VRAM_BANK1 ; $6df4
	farcall LoadCompressedTileBlock ; $6df7
	call AdvanceFrame ; $6dfa
	ld b, TILEBLOCK_SharedMenuGfx27 ; $6dfd
	ld c, SharedMenuGfx27_SIZE / 16 ; $6dff
	ld de, vTiles0 + $70 * TILE_SIZE + VRAM_BANK1 ; $6e01
	farcall LoadCompressedTileBlock ; $6e04
	call AdvanceFrame ; $6e07
	ld b, TILEBLOCK_SharedMenuGfx65 ; $6e0a
	ld c, SharedMenuGfx65_SIZE / 16 ; $6e0c
	ld de, vTiles0 ; $6e0e
	farcall LoadCompressedTileBlock ; $6e11
	call AdvanceFrame ; $6e14
	ld b, $08 ; $6e17
	ld c, $10 ; $6e19
	farcall LoadIndexedPalette ; $6e1b
	pop_wram_bank ; $6e1e
	ret ; $6e23
SavedDataPickerSlideIn:
	ld a, b ; $6e24
	or a ; $6e25
	jr z, .zero ; $6e26
	ld c, $00 ; $6e28
.loop:
	call AdvanceFrame ; $6e2a
	ld b, $08 ; $6e2d
	farcall RestoreMenuBgAndDrawPanel ; $6e2f
	ld b, $02 ; $6e32
	farcall FlushWram3MapRows ; $6e34
	ld a, c ; $6e37
	inc a ; $6e38
	ld c, a ; $6e39
	cp $0f ; $6e3a
	jr nz, .loop ; $6e3c
	ret ; $6e3e
.zero:
	ld c, $0b ; $6e3f
.loopB:
	call AdvanceFrame ; $6e41
	ld b, $09 ; $6e44
	farcall RestoreMenuBgAndDrawPanel ; $6e46
	ld b, $02 ; $6e49
	farcall FlushWram3MapRows ; $6e4b
	ld a, c ; $6e4e
	dec a ; $6e4f
	ld c, a ; $6e50
	cp $ff ; $6e51
	jr nz, .loopB ; $6e53
	ret ; $6e55
SavedDataPickerSlideOut:
	ld a, b ; $6e56
	or a ; $6e57
	jr z, .slideIn ; $6e58
	ld c, $00 ; $6e5a
.outLoop:
	call AdvanceFrame ; $6e5c
	ld b, $09 ; $6e5f
	farcall RestoreMenuBgAndDrawPanel ; $6e61
	ld b, $02 ; $6e64
	farcall FlushWram3MapRows ; $6e66
	ld a, c ; $6e69
	inc a ; $6e6a
	ld c, a ; $6e6b
	cp $0a ; $6e6c
	jr nz, .outLoop ; $6e6e
	ret ; $6e70
.slideIn:
	ld c, $0e ; $6e71
.inLoop:
	call AdvanceFrame ; $6e73
	ld b, $08 ; $6e76
	farcall RestoreMenuBgAndDrawPanel ; $6e78
	ld b, $02 ; $6e7b
	farcall FlushWram3MapRows ; $6e7d
	ld a, c ; $6e80
	dec a ; $6e81
	ld c, a ; $6e82
	or a ; $6e83
	jr nz, .inLoop ; $6e84
	ret ; $6e86
MoveSavedDataPickerCursor:
	ld a, [wMenuCursorY] ; $6e87
	or a ; $6e8a
	jr nz, .checkMenuInputPressed ; $6e8b
	ld a, [wMenuInputPressed] ; $6e8d
	bit PADB_RIGHT, a ; $6e90
	jr nz, .checkMenuCursorX ; $6e92
	bit 5, a ; $6e94
	jr nz, .checkMenuCursorX2 ; $6e96
	bit 6, a ; $6e98
	jr nz, .checkMenuCursorX3 ; $6e9a
	bit 7, a ; $6e9c
	jr nz, .checkMenuCursorX3 ; $6e9e
	xor a ; $6ea0
	jp .done ; $6ea1
.checkMenuCursorX:
	ld a, [wMenuCursorX] ; $6ea4
	inc a ; $6ea7
	add a ; $6ea8
	jr nc, .noCarry ; $6ea9
	ld a, $03 ; $6eab
	dec a ; $6ead
	jr .store ; $6eae
.noCarry:
	rra ; $6eb0
	cp $03 ; $6eb1
	jr c, .store ; $6eb3
	xor a ; $6eb5
.store:
	ld [wMenuCursorX], a ; $6eb6
	ld a, $01 ; $6eb9
	jp .done ; $6ebb
.checkMenuCursorX2:
	ld a, [wMenuCursorX] ; $6ebe
	dec a ; $6ec1
	add a ; $6ec2
	jr nc, .noCarry2 ; $6ec3
	ld a, $03 ; $6ec5
	dec a ; $6ec7
	jr .store2 ; $6ec8
.noCarry2:
	rra ; $6eca
	cp $03 ; $6ecb
	jr c, .store2 ; $6ecd
	xor a ; $6ecf
.store2:
	ld [wMenuCursorX], a ; $6ed0
	ld a, $01 ; $6ed3
	jr .done ; $6ed5
.checkMenuCursorX3:
	ld a, [wMenuCursorX] ; $6ed7
	ld hl, SavedDataPickerCursorTable0 ; $6eda
	add l ; $6edd
	ld l, a ; $6ede
	jr nc, .read ; $6edf
	inc h ; $6ee1
.read:
	ld a, [hl] ; $6ee2
	ld [wMenuCursorX], a ; $6ee3
	ld a, [wMenuCursorY] ; $6ee6
	xor $01 ; $6ee9
	ld [wMenuCursorY], a ; $6eeb
	ld a, $01 ; $6eee
	jr .done ; $6ef0
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $6ef2
	bit PADB_RIGHT, a ; $6ef5
	jr nz, .checkMenuCursorX4 ; $6ef7
	bit 5, a ; $6ef9
	jr nz, .checkMenuCursorX5 ; $6efb
	bit 6, a ; $6efd
	jr nz, .checkMenuCursorX6 ; $6eff
	bit 7, a ; $6f01
	jr nz, .checkMenuCursorX6 ; $6f03
	xor a ; $6f05
	jr .done ; $6f06
.checkMenuCursorX4:
	ld a, [wMenuCursorX] ; $6f08
	inc a ; $6f0b
	add a ; $6f0c
	jr nc, .noCarry3 ; $6f0d
	ld a, $02 ; $6f0f
	dec a ; $6f11
	jr .store3 ; $6f12
.noCarry3:
	rra ; $6f14
	cp $02 ; $6f15
	jr c, .store3 ; $6f17
	xor a ; $6f19
.store3:
	ld [wMenuCursorX], a ; $6f1a
	ld a, $01 ; $6f1d
	jr .done ; $6f1f
.checkMenuCursorX5:
	ld a, [wMenuCursorX] ; $6f21
	dec a ; $6f24
	add a ; $6f25
	jr nc, .noCarry4 ; $6f26
	ld a, $02 ; $6f28
	dec a ; $6f2a
	jr .store4 ; $6f2b
.noCarry4:
	rra ; $6f2d
	cp $02 ; $6f2e
	jr c, .store4 ; $6f30
	xor a ; $6f32
.store4:
	ld [wMenuCursorX], a ; $6f33
	ld a, $01 ; $6f36
	jr .done ; $6f38
.checkMenuCursorX6:
	ld a, [wMenuCursorX] ; $6f3a
	ld hl, SavedDataPickerCursorTable1 ; $6f3d
	add l ; $6f40
	ld l, a ; $6f41
	jr nc, .readB ; $6f42
	inc h ; $6f44
.readB:
	ld a, [hl] ; $6f45
	ld [wMenuCursorX], a ; $6f46
	ld a, [wMenuCursorY] ; $6f49
	xor $01 ; $6f4c
	ld [wMenuCursorY], a ; $6f4e
	ld a, $01 ; $6f51
	jr .done ; $6f53
.done:
	ret ; $6f55
SavedDataPickerCursorTable0:
	; $6f56, 3 bytes (bytes:8)
	db $00, $01, $01 ; 0x00
SavedDataPickerCursorTable1:
	db $00 ; $6f59
	db $02 ; $6f5a
EraseSavedDataCursorSpriteTask:
	farcall TickMenuBgScroll ; $6f5b
	ld c, $03 ; $6f5e
	call GetMenuCursorIndex_3b ; $6f60
	push af ; $6f63
	ld hl, EraseSavedDataCursorSpriteTaskTable1 ; $6f64
	add l ; $6f67
	ld l, a ; $6f68
	jr nc, .read ; $6f69
	inc h ; $6f6b
.read:
	ld c, [hl] ; $6f6c
	pop af ; $6f6d
	ld hl, EraseSavedDataCursorSpriteTaskTable0 ; $6f6e
	add a ; $6f71
	add l ; $6f72
	ld l, a ; $6f73
	jr nc, .readB ; $6f74
	inc h ; $6f76
.readB:
	ld a, [hl+] ; $6f77
	ld d, [hl] ; $6f78
	ld e, a ; $6f79
	farcall ApplySpriteBobOffset ; $6f7a
	ld b, OAM_BANK1 ; $6f7d
	ld hl, EraseSavedDataCursorSpriteTask_SpriteTemplate0 ; $6f7f
	push de ; $6f82
	call QueueSpriteTemplate ; $6f83
	pop de ; $6f86
	ld hl, $17f8 ; $6f87
	add hl, de ; $6f8a
	ld d, h ; $6f8b
	ld e, l ; $6f8c
	ld hl, EraseSavedDataCursorSpriteTask_SpriteTemplate1 ; $6f8d
	sprite_attr_tile OAM_BANK1, $70 ; $6f90
	call QueueSpriteTemplate ; $6f94
	ret ; $6f97
EraseSavedDataCursorSpriteTask_SpriteTemplate0:
	; $6f98, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
EraseSavedDataCursorSpriteTask_SpriteTemplate1:
	; $6fb9, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
EraseSavedDataCursorSpriteTaskTable0:
	; $6fc2, 10 bytes (bytes:10)
	db $3a, $fe, $3a, $2c, $3a, $5c, $60, $0c, $60, $4c ; 0x00
EraseSavedDataCursorSpriteTaskTable1:
	; $6fcc, 47 bytes (bytes:16)
	db $00, $10, $20, $30, $40, $30, $10, $08, $00, $00, $10, $10, $02, $00, $10, $18 ; 0x00
	db $04, $00, $10, $20, $06, $00, $10, $28, $08, $00, $10, $30, $0a, $00, $10, $38 ; 0x10
	db $0c, $00, $10, $40, $0e, $00, $10, $48, $10, $00, $10, $50, $12, $00, $80 ; 0x20
DrawEraseSavedDataGrid:
	wram_bank WRAM_SCREEN ; $6ffb
	ld b, $00 ; $7001
	ld c, $00 ; $7003
.loop:
	call FillEraseSavedDataCell ; $7005
	ld a, b ; $7008
	inc a ; $7009
	ld b, a ; $700a
	cp $05 ; $700b
	jr nz, .loop ; $700d
	ld c, $03 ; $700f
	call GetMenuCursorIndex_3b ; $7011
	ld b, a ; $7014
	ld c, $01 ; $7015
	call FillEraseSavedDataCell ; $7017
	ld c, $03 ; $701a
	call GetMenuCursorIndex_3b ; $701c
	cp $03 ; $701f
	jr nc, .loadEraseSavedDataCellPalette ; $7021
	add a ; $7023
	add a ; $7024
	add a ; $7025
	add a ; $7026
	ld bc, wShadowTilemap + 24 * TILEMAP_WIDTH ; $7027
	add c ; $702a
	ld c, a ; $702b
	jr nc, .gotPtr ; $702c
	inc b ; $702e
.gotPtr:
	ld hl, $0001 ; $702f
	add hl, bc ; $7032
	ld a, [hl] ; $7033
	ld d, $04 ; $7034
	farcall LoadIndexedPalette_18 ; $7036
	jr .fillTilemapRect ; $7039
.loadEraseSavedDataCellPalette:
	call LoadEraseSavedDataCellPalette ; $703b
.fillTilemapRect:
	wram_bank WRAM_SCREEN ; $703e
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH ; $7044
	rect_size $14, $01 ; $7047
	ld h, $03 ; $704b
	farcall FillTilemapRect ; $704d
	ld a, $02 ; $7050
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH], a ; $7052
	ld a, $04 ; $7055
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH + 19], a ; $7057
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $705a
	rect_size $12, $01 ; $705d
	ld h, $20 ; $7061
	farcall FillTilemapRect ; $7063
	call DrawEraseSavedDataCaption ; $7066
	ld hl, wShadowAttrmap + 4 * TILEMAP_WIDTH ; $7069
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH + VRAM_BANK1 ; $706c
	ld c, 3 * TILEMAP_WIDTH / 16 ; $706f
	call QueueVRAMCopy ; $7071
	ld hl, wShadowAttrmap + 9 * TILEMAP_WIDTH ; $7074
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH + VRAM_BANK1 ; $7077
	ld c, 3 * TILEMAP_WIDTH / 16 ; $707a
	call QueueVRAMCopy ; $707c
	ld hl, wShadowTilemap + 15 * TILEMAP_WIDTH ; $707f
	ld de, vBGMap0 + 15 * TILEMAP_WIDTH ; $7082
	ld c, 2 * TILEMAP_WIDTH / 16 ; $7085
	call QueueVRAMCopy ; $7087
	ret ; $708a
FillEraseSavedDataCell:
	push af ; $708b
	push bc ; $708c
	push de ; $708d
	push hl ; $708e
	ld d, c ; $708f
	ld e, b ; $7090
	ld a, b ; $7091
	cp $03 ; $7092
	jr nc, .ge03 ; $7094
	ld b, $03 ; $7096
	ld c, $03 ; $7098
	jr .step2 ; $709a
.ge03:
	ld b, $05 ; $709c
	ld c, $03 ; $709e
.step2:
	ld a, d ; $70a0
	or a ; $70a1
	jr z, .zero ; $70a2
	ld h, $0c ; $70a4
	jr .step4 ; $70a6
.zero:
	ld h, $0d ; $70a8
.step4:
	push hl ; $70aa
	ld hl, FillEraseSavedDataCellTable ; $70ab
	ld a, e ; $70ae
	add a ; $70af
	add l ; $70b0
	ld l, a ; $70b1
	jr nc, .read ; $70b2
	inc h ; $70b4
.read:
	ld a, [hl+] ; $70b5
	ld d, [hl] ; $70b6
	ld e, a ; $70b7
	pop hl ; $70b8
	farcall FillTilemapRect ; $70b9
	pop hl ; $70bc
	pop de ; $70bd
	pop bc ; $70be
	pop af ; $70bf
	ret ; $70c0
FillEraseSavedDataCellTable:
	; $70c1, 10 bytes (ram_ptrs:3)
	dw wShadowAttrmap + 4 * TILEMAP_WIDTH + 2 ; record 0
	dw wShadowAttrmap + 4 * TILEMAP_WIDTH + 8 ; record 1
	dw wShadowAttrmap + 4 * TILEMAP_WIDTH + 14 ; record 2
	dw wShadowAttrmap + 9 * TILEMAP_WIDTH + 3 ; record 3
	dw wShadowAttrmap + 9 * TILEMAP_WIDTH + 11 ; record 4
LoadEraseSavedDataCellPalette:
	ld hl, EraseSavedDataCellPalettePtrs ; $70cb
	add a ; $70ce
	add l ; $70cf
	ld l, a ; $70d0
	jr nc, .read ; $70d1
	inc h ; $70d3
.read:
	ld a, [hl+] ; $70d4
	ld h, [hl] ; $70d5
	ld l, a ; $70d6
	ld_bg_pals de, 4, 1 ; $70d7
	call LoadPaletteShadow ; $70da
	ret ; $70dd
EraseSavedDataCellPalettePtrs:
	; $70de, 18 bytes (records:2)
	dw SavedDataCellPalette0 ; record 0
	dw SavedDataCellPalette0 ; record 1
	dw SavedDataCellPalette0 ; record 2
	dw SavedDataCellPalette1 ; record 3
	dw SavedDataCellPalette0 ; record 4
	dw SavedDataCellPalette0 ; record 5
	dw SavedDataCellPalette0 ; record 6
	dw SavedDataCellPalette0 ; record 7
	dw SavedDataCellPalette0 ; record 8
