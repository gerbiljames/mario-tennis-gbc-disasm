RunCourtSelect4Menu:
	sound BGM_MENU ; $5b99
	call ClearFrameTasks ; $5b9b
	ld hl, rIE ; $5b9e
	res 2, [hl] ; $5ba1
	farcall InitMenuBgScroll ; $5ba3
	ld b, $01 ; $5ba6
	ld c, $01 ; $5ba8
	farcall LoadMenuSpritePalettePair ; $5baa
	call LoadCourtSelectHeader ; $5bad
	wram_bank WRAM_SCREEN ; $5bb0
	ld a, [wMenuSlideDirection] ; $5bb6
	ld b, a ; $5bb9
	call OpenCourtSelect4Panel ; $5bba
	ld a, [wSubMenuCursor] ; $5bbd
	ld c, a ; $5bc0
	ld b, $02 ; $5bc1
	call SetMenuCursorFromIndex_3e ; $5bc3
	ld a, $01 ; $5bc6
	ld hl, CourtSelect4CursorSpriteTask ; $5bc8
	call RegisterFrameTask ; $5bcb
	call RedrawCourtSelect4Menu ; $5bce
	wram_bank WRAM_SCREEN ; $5bd1
.loop:
	call AdvanceFrame ; $5bd7
	ldh a, [hInputPressed] ; $5bda
	ld [wMenuInputPressed], a ; $5bdc
	ld b, $02 ; $5bdf
	ld c, $02 ; $5be1
	call MoveMenuCursorGrid_3e ; $5be3
	or a ; $5be6
	jr z, .checkMenuInputPressed ; $5be7
	sound SFX_MENU_MOVE ; $5be9
	call RedrawCourtSelect4Menu ; $5beb
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $5bee
	bit PADB_A, a ; $5bf1
	jr nz, .playSfx ; $5bf3
	bit 1, a ; $5bf5
	jr nz, .playSfx2 ; $5bf7
	jr .loop ; $5bf9
.playSfx:
	sound SFX_MENU_DECIDE ; $5bfb
	call ClearFrameTasks ; $5bfd
	ld hl, rIE ; $5c00
	set 2, [hl] ; $5c03
	ld b, $01 ; $5c05
	call CloseCourtSelect4Panel ; $5c07
	ld a, MENUSLIDE_FORWARD ; $5c0a
	ld [wMenuSlideDirection], a ; $5c0c
	ld c, $02 ; $5c0f
	call GetMenuCursorIndex_3e ; $5c11
	push af ; $5c14
	ld c, a ; $5c15
	call SetCourtSelectBGM ; $5c16
	pop af ; $5c19
	call CourtSelectIndexToCourtId ; $5c1a
	ret ; $5c1d
.playSfx2:
	sound SFX_MENU_CANCEL ; $5c1e
	call ClearFrameTasks ; $5c20
	ld hl, rIE ; $5c23
	set 2, [hl] ; $5c26
	ld b, $00 ; $5c28
	call CloseCourtSelect4Panel ; $5c2a
	ld a, MENUSLIDE_BACK ; $5c2d
	ld [wMenuSlideDirection], a ; $5c2f
	call FadeOutAndResetMenuScreen ; $5c32
	ld a, $ff ; $5c35
	ret ; $5c37
RunLinkCourtSelect4Menu:
	xor a ; $5c38
	ldh [hLinkExchangeActive], a ; $5c39
	call ResetSerialState ; $5c3b
	call ClearFrameTasks ; $5c3e
	call EnableTimerInterrupt ; $5c41
	sound BGM_MENU ; $5c44
	farcall InitMenuBgScroll ; $5c46
	ld b, $01 ; $5c49
	ld c, $01 ; $5c4b
	farcall LoadMenuSpritePalettePair ; $5c4d
	call LoadCourtSelectHeader ; $5c50
	wram_bank WRAM_SCREEN ; $5c53
	ld a, [wMenuSlideDirection] ; $5c59
	ld b, a ; $5c5c
	call OpenCourtSelect4Panel ; $5c5d
	ld a, [wSubMenuCursor] ; $5c60
	ld c, a ; $5c63
	ld b, $02 ; $5c64
	call SetMenuCursorFromIndex_3e ; $5c66
	ld a, $01 ; $5c69
	ld hl, CourtSelect4CursorSpriteTask ; $5c6b
	call RegisterFrameTask ; $5c6e
	call RedrawCourtSelect4Menu ; $5c71
	farcall ResyncLinkSessionWithTimer ; $5c74
	push af ; $5c77
	farcall RunLinkInputFrame ; $5c78
	pop af ; $5c7b
	push af ; $5c7c
	farcall RunLinkInputFrame ; $5c7d
	pop af ; $5c80
	push af ; $5c81
	farcall RunLinkInputFrame ; $5c82
	pop af ; $5c85
	wram_bank WRAM_SCREEN ; $5c86
.loop:
	push af ; $5c8c
	farcall RunLinkInputFrame ; $5c8d
	pop af ; $5c90
	ldh a, [hLinkInput] ; $5c91
	ld [wMenuInputPressed], a ; $5c93
	ld b, $02 ; $5c96
	ld c, $02 ; $5c98
	call MoveMenuCursorGrid_3e ; $5c9a
	or a ; $5c9d
	jr z, .checkMenuInputPressed ; $5c9e
	sound SFX_MENU_MOVE ; $5ca0
	call RedrawCourtSelect4Menu ; $5ca2
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $5ca5
	bit PADB_A, a ; $5ca8
	jr nz, .playSfx ; $5caa
	bit 1, a ; $5cac
	jr nz, .playSfx2 ; $5cae
	jr .loop ; $5cb0
.playSfx:
	sound SFX_MENU_DECIDE ; $5cb2
	push af ; $5cb4
	farcall SyncLinkFrame ; $5cb5
	pop af ; $5cb8
	call ClearFrameTasks ; $5cb9
	xor a ; $5cbc
	ldh [hLinkExchangeActive], a ; $5cbd
	call ResetSerialState ; $5cbf
	call EnableTimerInterrupt ; $5cc2
	ld a, MENUSLIDE_FORWARD ; $5cc5
	ld [wMenuSlideDirection], a ; $5cc7
	ld c, $02 ; $5cca
	call GetMenuCursorIndex_3e ; $5ccc
	push af ; $5ccf
	ld c, a ; $5cd0
	call SetCourtSelectBGMLink ; $5cd1
	pop af ; $5cd4
	call CourtSelectIndexToCourtId ; $5cd5
	ret ; $5cd8
.playSfx2:
	sound SFX_MENU_CANCEL ; $5cd9
	push af ; $5cdb
	farcall SyncLinkFrame ; $5cdc
	pop af ; $5cdf
	xor a ; $5ce0
	ldh [hLinkExchangeActive], a ; $5ce1
	call ResetSerialState ; $5ce3
	call ClearFrameTasks ; $5ce6
	ld b, $00 ; $5ce9
	call CloseCourtSelect4Panel ; $5ceb
	ld a, MENUSLIDE_BACK ; $5cee
	ld [wMenuSlideDirection], a ; $5cf0
	ld c, $10 ; $5cf3
	call BeginFadeOut ; $5cf5
	call WaitFadeEnd ; $5cf8
	ld a, $ff ; $5cfb
	ret ; $5cfd
CourtSelectIndexToCourtId:
	ld hl, CourtSelectCourtIds_3e ; $5cfe
	add l ; $5d01
	ld l, a ; $5d02
	jr nc, .read ; $5d03
	inc h ; $5d05
.read:
	ld a, [hl] ; $5d06
	ret ; $5d07
CourtSelectCourtIds_3e:
	; $5d08, 9 bytes (bytes:9)
	db $00, $01, $02, $03, $04, $05, $06, $07, $08 ; 0x00
LoadCourtSelectGraphics:
	ldh a, [hWramBank] ; $5d11
	push af ; $5d13
	ld a, [wUnlockedCourtMask] ; $5d14
	ld b, a ; $5d17
	ld a, [wLinkPartnerCourtMask] ; $5d18
	or b ; $5d1b
	ld b, a ; $5d1c
	call StoreCourtUnlockBits ; $5d1d
	wram_bank WRAM_STAGING ; $5d20
	ld c, $00 ; $5d26
.loop:
	ld a, c ; $5d28
	add a ; $5d29
	ld hl, CourtSelectGraphicsTable ; $5d2a
	add l ; $5d2d
	ld l, a ; $5d2e
	jr nc, .read ; $5d2f
	inc h ; $5d31
.read:
	ld a, [hl+] ; $5d32
	ld h, [hl] ; $5d33
	ld l, a ; $5d34
	push af ; $5d35
	push bc ; $5d36
	push de ; $5d37
	push hl ; $5d38
	call GetCourtThumbnailPtr ; $5d39
	ld de, wDecompBuffer ; $5d3c
	call DecompressDataFromBank ; $5d3f
	pop hl ; $5d42
	pop de ; $5d43
	pop bc ; $5d44
	pop af ; $5d45
	ld hl, CourtSelectTable ; $5d46
	ld a, c ; $5d49
	add a ; $5d4a
	add l ; $5d4b
	ld l, a ; $5d4c
	jr nc, .readB ; $5d4d
	inc h ; $5d4f
.readB:
	ld a, [hl+] ; $5d50
	ld d, [hl] ; $5d51
	ld e, a ; $5d52
	ld hl, wDecompBuffer ; $5d53
	push af ; $5d56
	push bc ; $5d57
	push de ; $5d58
	push hl ; $5d59
	ld bc, $0010 ; $5d5a
	call QueueVRAMCopy ; $5d5d
	pop hl ; $5d60
	pop de ; $5d61
	pop bc ; $5d62
	pop af ; $5d63
	ld a, c ; $5d64
	inc a ; $5d65
	ld c, a ; $5d66
	ld a, c ; $5d67
	cp $09 ; $5d68
	jr nz, .loop ; $5d6a
	ld b, TILEBLOCK_CourtSelectGfx1 ; $5d6c
	ld c, $12 ; $5d6e -- 18 of CourtSelectGfx1's 16 tiles
	ld de, vTiles0 + VRAM_BANK1 ; $5d70
	farcall LoadCompressedTileBlock ; $5d73
	ld b, TILEBLOCK_CourtSelectGfx2 ; $5d76
	ld c, $12 ; $5d78 -- 18 of CourtSelectGfx2's 16 tiles
	ld de, vTiles0 + $10 * TILE_SIZE + VRAM_BANK1 ; $5d7a
	farcall LoadCompressedTileBlock ; $5d7d
	ld b, TILEBLOCK_CourtSelectGfx3 ; $5d80
	ld c, $12 ; $5d82 -- 18 of CourtSelectGfx3's 16 tiles
	ld de, vTiles0 + $20 * TILE_SIZE + VRAM_BANK1 ; $5d84
	farcall LoadCompressedTileBlock ; $5d87
	ld b, TILEBLOCK_CourtSelectGfx4 ; $5d8a
	ld c, $14 ; $5d8c -- 20 of CourtSelectGfx4's 18 tiles
	ld de, vTiles0 + $30 * TILE_SIZE + VRAM_BANK1 ; $5d8e
	farcall LoadCompressedTileBlock ; $5d91
	ld b, TILEBLOCK_CourtSelectGfx5Alias16 ; $5d94
	ld c, $12 ; $5d96 -- 18 of CourtSelectGfx5's 16 tiles
	ld de, vTiles0 + $42 * TILE_SIZE + VRAM_BANK1 ; $5d98
	farcall LoadCompressedTileBlock ; $5d9b
	ld b, TILEBLOCK_CourtSelectGfx6 ; $5d9e
	ld c, $12 ; $5da0 -- 18 of CourtSelectGfx6's 16 tiles
	ld de, vTiles0 + $52 * TILE_SIZE + VRAM_BANK1 ; $5da2
	farcall LoadCompressedTileBlock ; $5da5
	ld b, TILEBLOCK_CourtSelectGfx7 ; $5da8
	ld c, $12 ; $5daa -- 18 of CourtSelectGfx7's 16 tiles
	ld de, vTiles0 + $62 * TILE_SIZE + VRAM_BANK1 ; $5dac
	farcall LoadCompressedTileBlock ; $5daf
	ld b, TILEBLOCK_CourtSelectGfx8 ; $5db2
	ld c, $12 ; $5db4 -- 18 of CourtSelectGfx8's 16 tiles
	ld de, vTiles0 + $20 * TILE_SIZE ; $5db6
	farcall LoadCompressedTileBlock ; $5db9
	ld b, TILEBLOCK_CourtSelectGfx9 ; $5dbc
	ld c, $12 ; $5dbe -- 18 of CourtSelectGfx9's 16 tiles
	ld de, vTiles0 + $30 * TILE_SIZE ; $5dc0
	farcall LoadCompressedTileBlock ; $5dc3
	ld b, TILEBLOCK_SharedMenuGfx111 ; $5dc6
	ld c, $12 ; $5dc8 -- 18 of SharedMenuGfx111's 16 tiles
	ld de, vTiles0 + $40 * TILE_SIZE ; $5dca
	farcall LoadCompressedTileBlock ; $5dcd
	ld b, TILEBLOCK_SharedMenuGfx27 ; $5dd0
	ld c, SharedMenuGfx27_SIZE / 16 ; $5dd2
	ld de, vTiles0 + $72 * TILE_SIZE + VRAM_BANK1 ; $5dd4
	farcall LoadCompressedTileBlock ; $5dd7
	ld b, TILEBLOCK_CourtSelectGfx0 ; $5dda
	ld c, CourtSelectGfx0_SIZE / 16 ; $5ddc
	ld de, vTiles0 ; $5dde
	farcall LoadCompressedTileBlock ; $5de1
	ld b, $08 ; $5de4
	ld c, $10 ; $5de6
	farcall LoadIndexedPalette ; $5de8
	pop_wram_bank ; $5deb
	ret ; $5df0
CourtSelectGraphicsTable:
	; $5df1, 20 bytes (10 records x 1 slot words)
	dslot DataPtr_HardCourtLabelTiles ; record 0
	dslot DataPtr_ClayCourtLabelTiles ; record 1
	dslot DataPtr_GrassCourtLabelTiles ; record 2
	dslot DataPtr_CompositionCourtLabelTiles ; record 3
	dslot DataPtr_CourtNameLabelTiles0 ; record 4
	dslot DataPtr_CourtNameLabelTiles1 ; record 5
	dslot DataPtr_CourtNameLabelTiles2 ; record 6
	dslot DataPtr_CourtNameLabelTiles3 ; record 7
	dslot DataPtr_CourtNameLabelTiles4 ; record 8
	dslot DataPtr_CourtNameLabelTiles5 ; record 9
CourtSelectTable:
	; $5e05, 18 bytes (records:2)
	dw $a800 ; record 0
	dw $a900 ; record 1
	dw $aa00 ; record 2
	dw $ab00 ; record 3
	dw $ac00 ; record 4
	dw $ad00 ; record 5
	dw $ae00 ; record 6
	dw $af00 ; record 7
	dw $b700 ; record 8
GetCourtThumbnailPtr:
	push af ; $5e17
	push bc ; $5e18
	push de ; $5e19
	ld b, c ; $5e1a
	push hl ; $5e1b
	call IsCourtUnlocked ; $5e1c
	or a ; $5e1f
	pop hl ; $5e20
	jr nz, .restore ; $5e21
	ld hl, $3f14 ; $5e23
.restore:
	pop de ; $5e26
	pop bc ; $5e27
	pop af ; $5e28
	ret ; $5e29
OpenCourtSelect4Panel:
	ld a, b ; $5e2a
	or a ; $5e2b
	jr z, .zero ; $5e2c
	ld c, $00 ; $5e2e
.loop:
	call AdvanceFrame ; $5e30
	ld b, $12 ; $5e33
	farcall RestoreMenuBgAndDrawPanel ; $5e35
	ld b, $02 ; $5e38
	farcall FlushWram3MapRows ; $5e3a
	ld a, c ; $5e3d
	inc a ; $5e3e
	ld c, a ; $5e3f
	cp $0d ; $5e40
	jr nz, .loop ; $5e42
	call AdvanceFrame ; $5e44
	ret ; $5e47
.zero:
	ld c, $0a ; $5e48
.loopB:
	call AdvanceFrame ; $5e4a
	ld b, $13 ; $5e4d
	farcall RestoreMenuBgAndDrawPanel ; $5e4f
	ld b, $02 ; $5e52
	farcall FlushWram3MapRows ; $5e54
	ld a, c ; $5e57
	dec a ; $5e58
	ld c, a ; $5e59
	cp $ff ; $5e5a
	jr nz, .loopB ; $5e5c
	call AdvanceFrame ; $5e5e
	ret ; $5e61
CloseCourtSelect4Panel:
	ld a, b ; $5e62
	or a ; $5e63
	jr z, .close ; $5e64
	ld c, $00 ; $5e66
.openLoop:
	call AdvanceFrame ; $5e68
	ld b, $13 ; $5e6b
	farcall RestoreMenuBgAndDrawPanel ; $5e6d
	ld b, $02 ; $5e70
	farcall FlushWram3MapRows ; $5e72
	ld a, c ; $5e75
	inc a ; $5e76
	ld c, a ; $5e77
	cp $0b ; $5e78
	jr nz, .openLoop ; $5e7a
	ret ; $5e7c
.close:
	ld c, $0c ; $5e7d
.closeLoop:
	call AdvanceFrame ; $5e7f
	ld b, $12 ; $5e82
	farcall RestoreMenuBgAndDrawPanel ; $5e84
	ld b, $02 ; $5e87
	farcall FlushWram3MapRows ; $5e89
	ld a, c ; $5e8c
	dec a ; $5e8d
	ld c, a ; $5e8e
	or a ; $5e8f
	jr nz, .closeLoop ; $5e90
	ret ; $5e92
CourtSelect4CursorSpriteTask:
	farcall TickMenuBgScroll ; $5e93
	ld c, $02 ; $5e96
	call GetMenuCursorIndex_3e ; $5e98
	push af ; $5e9b
	ld hl, CourtSelect4CursorTiles_3e ; $5e9c
	add l ; $5e9f
	ld l, a ; $5ea0
	jr nc, .read ; $5ea1
	inc h ; $5ea3
.read:
	ld c, [hl] ; $5ea4
	pop af ; $5ea5
	push af ; $5ea6
	ld hl, CourtSelect4CursorPositions_3e ; $5ea7
	add a ; $5eaa
	add l ; $5eab
	ld l, a ; $5eac
	jr nc, .readB ; $5ead
	inc h ; $5eaf
.readB:
	ld a, [hl+] ; $5eb0
	ld d, [hl] ; $5eb1
	ld e, a ; $5eb2
	farcall ApplySpriteBobOffset ; $5eb3
	ld b, [hl] ; $5eb6
	pop af ; $5eb7
	add a ; $5eb8
	ld hl, CourtSelect4CursorSpriteTaskPtrs ; $5eb9
	add l ; $5ebc
	ld l, a ; $5ebd
	jr nc, .read2 ; $5ebe
	inc h ; $5ec0
.read2:
	ld a, [hl+] ; $5ec1
	ld h, [hl] ; $5ec2
	ld l, a ; $5ec3
	ld b, $08 ; $5ec4
	push de ; $5ec6
	call QueueSpriteTemplate ; $5ec7
	pop de ; $5eca
	ld c, $02 ; $5ecb
	call GetMenuCursorIndex_3e ; $5ecd
	ld hl, CourtSelect4LabelYOffsets_3e ; $5ed0
	add l ; $5ed3
	ld l, a ; $5ed4
	jr nc, .read3 ; $5ed5
	inc h ; $5ed7
.read3:
	ld a, [hl] ; $5ed8
	ld h, a ; $5ed9
	ld l, $f8 ; $5eda
	add hl, de ; $5edc
	ld d, h ; $5edd
	ld e, l ; $5ede
	ld hl, CourtSelect4CursorSpriteTask_SpriteTemplate ; $5edf
	ld b, $08 ; $5ee2
	ld c, $72 ; $5ee4
	call QueueSpriteTemplate ; $5ee6
	ret ; $5ee9
CourtSelect4CursorSpriteTaskPtrs:
	; $5eea, 8 bytes (records:2)
	dw CourtSelect4CursorSpriteTask0 ; record 0
	dw CourtSelect4CursorSpriteTask0 ; record 1
	dw CourtSelect4CursorSpriteTask0 ; record 2
	dw CourtSelect4CursorSpriteTask1 ; record 3
CourtSelect4CursorSpriteTask0:
	; $5ef2, 33 bytes (bytes:8)
	db $10, $08, $00, $00, $10, $10, $02, $00 ; 0x00
	db $10, $18, $04, $00, $10, $20, $06, $00 ; 0x08
	db $10, $28, $08, $00, $10, $30, $0a, $00 ; 0x10
	db $10, $38, $0c, $00, $10, $40, $0e, $00 ; 0x18
	db $80 ; 0x20
CourtSelect4CursorSpriteTask1:
	; $5f13, 37 bytes (bytes:8)
	db $10, $08, $00, $00, $10, $10, $02, $00 ; 0x00
	db $10, $18, $04, $00, $10, $20, $06, $00 ; 0x08
	db $10, $28, $08, $00, $10, $30, $0a, $00 ; 0x10
	db $10, $38, $0c, $00, $10, $40, $0e, $00 ; 0x18
	db $10, $48, $10, $00, $80 ; 0x20
CourtSelect4CursorSpriteTask_SpriteTemplate:
	; $5f38, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
CourtSelect4CursorPositions_3e:
	; $5f41, 8 bytes (bytes:8)
	db $38, $14, $38, $4c, $60, $14, $60, $48 ; 0x00
CourtSelect4CursorTiles_3e:
	; $5f49, 4 bytes (bytes:4)
	db $00, $10, $20, $30 ; 0x00
CourtSelect4LabelYOffsets_3e:
	; $5f4d, 4 bytes (bytes:4)
	db $17, $17, $17, $1b ; 0x00
RedrawCourtSelect4Menu:
	wram_bank WRAM_SCREEN ; $5f51
	ld b, $00 ; $5f57
	ld c, $00 ; $5f59
.tabLoop:
	call SetCourtSelect4TabAttrRect ; $5f5b
	ld a, b ; $5f5e
	inc a ; $5f5f
	ld b, a ; $5f60
	cp $04 ; $5f61
	jr nz, .tabLoop ; $5f63
	ld c, $02 ; $5f65
	call GetMenuCursorIndex_3e ; $5f67
	ld b, a ; $5f6a
	ld c, $01 ; $5f6b
	call SetCourtSelect4TabAttrRect ; $5f6d
	ld c, $02 ; $5f70
	call GetMenuCursorIndex_3e ; $5f72
	call SetCourtSelect4Palette ; $5f75
	ld c, $02 ; $5f78
	call GetMenuCursorIndex_3e ; $5f7a
	ld d, a ; $5f7d
	ld b, a ; $5f7e
	call IsCourtUnlocked ; $5f7f
	or a ; $5f82
	ld b, $ff ; $5f83
	jr z, .drawName ; $5f85
	ld b, d ; $5f87
.drawName:
	call DrawCourtNameTiles ; $5f88
	ld hl, wShadowAttrmap + 4 * TILEMAP_WIDTH ; $5f8b
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH + VRAM_BANK1 ; $5f8e
	ld c, $06 ; $5f91
	call QueueVRAMCopy ; $5f93
	ld hl, wShadowAttrmap + 9 * TILEMAP_WIDTH ; $5f96
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH + VRAM_BANK1 ; $5f99
	ld c, $06 ; $5f9c
	call QueueVRAMCopy ; $5f9e
	ld hl, wShadowTilemap + 16 * TILEMAP_WIDTH ; $5fa1
	ld de, vBGMap0 + 16 * TILEMAP_WIDTH ; $5fa4
	ld c, $02 ; $5fa7
	call QueueVRAMCopy ; $5fa9
	ret ; $5fac
SetCourtSelect4TabAttrRect:
	push af ; $5fad
	push bc ; $5fae
	push de ; $5faf
	push hl ; $5fb0
	ld a, c ; $5fb1
	or a ; $5fb2
	jr z, .inactiveAttr ; $5fb3
	ld h, $0c ; $5fb5
	jr .lookup ; $5fb7
.inactiveAttr:
	ld h, $0d ; $5fb9
.lookup:
	push hl ; $5fbb
	ld hl, CourtSelect4TabAttrAddrs_3e ; $5fbc
	ld a, b ; $5fbf
	add a ; $5fc0
	add l ; $5fc1
	ld l, a ; $5fc2
	jr nc, .readAddr ; $5fc3
	inc h ; $5fc5
.readAddr:
	ld a, [hl+] ; $5fc6
	ld d, [hl] ; $5fc7
	ld e, a ; $5fc8
	pop hl ; $5fc9
	ld b, $05 ; $5fca
	ld c, $03 ; $5fcc
	farcall FillTilemapRect ; $5fce
	pop hl ; $5fd1
	pop de ; $5fd2
	pop bc ; $5fd3
	pop af ; $5fd4
	ret ; $5fd5
CourtSelect4TabAttrAddrs_3e:
	; $5fd6, 8 bytes (bytes:8)
	db $84, $d4, $8b, $d4, $24, $d5, $2b, $d5 ; 0x00
SetCourtSelect4Palette:
	ld hl, CourtSelect4PalettePtrs ; $5fde
	add a ; $5fe1
	add l ; $5fe2
	ld l, a ; $5fe3
	jr nc, .read ; $5fe4
	inc h ; $5fe6
.read:
	ld a, [hl+] ; $5fe7
	ld h, [hl] ; $5fe8
	ld l, a ; $5fe9
	lb de, $04, $01 ; $5fea palette index, count
	call LoadPaletteShadow ; $5fed
	ret ; $5ff0
CourtSelect4PalettePtrs:
	; $5ff1, 18 bytes (records:2)
	dw CourtSelect4Palette0 ; record 0
	dw CourtSelect4Palette1 ; record 1
	dw CourtSelect4Palette2 ; record 2
	dw CourtSelect4Palette3 ; record 3
	dw CourtSelect4Palette0 ; record 4
	dw CourtSelect4Palette0 ; record 5
	dw CourtSelect4Palette0 ; record 6
	dw CourtSelect4Palette0 ; record 7
	dw CourtSelect4Palette0 ; record 8
CourtSelect4Palette0:
	; $6003, 8 bytes (bytes:8)
	db $40, $7d, $ff, $7f, $a0, $3c, $00, $00 ; 0x00
CourtSelect4Palette1:
	; $600b, 8 bytes (bytes:8)
	db $1f, $00, $ff, $7f, $12, $00, $00, $00 ; 0x00
CourtSelect4Palette2:
	; $6013, 8 bytes (bytes:8)
	db $e0, $01, $ff, $7f, $40, $01, $00, $00 ; 0x00
CourtSelect4Palette3:
	; $601b, 194 bytes (bytes:8)
	db $12, $48, $ff, $7f, $08, $00, $00, $00 ; 0x00
	db $f0, $96, $f5, $3e, $03, $e0, $96, $e0 ; 0x08
	db $70, $0e, $02, $cd, $c9, $43, $4f, $c5 ; 0x10
	db $cd, $45, $60, $c1, $c5, $cd, $6f, $60 ; 0x18
	db $c1, $cd, $93, $60, $f1, $e0, $96, $e0 ; 0x20
	db $70, $c9, $21, $ca, $60, $79, $85, $6f ; 0x28
	db $30, $01, $24, $7e, $21, $00, $d2, $85 ; 0x30
	db $6f, $30, $01, $24, $54, $5d, $21, $d3 ; 0x38
	db $60, $01, $05, $00, $cd, $db, $03, $21 ; 0x40
	db $d8, $60, $11, $01, $d2, $01, $05, $00 ; 0x48
	db $cd, $db, $03, $c9, $79, $21, $8a, $60 ; 0x50
	db $85, $6f, $30, $01, $24, $7e, $21, $a9 ; 0x58
	db $00, $85, $6f, $30, $01, $24, $11, $06 ; 0x60
	db $d2, $0e, $20, $df, $72, $05, $c9, $01 ; 0x68
	db $00, $02, $03, $02, $01, $03, $02, $00 ; 0x70
	db $21, $ca, $60, $79, $85, $6f, $30, $01 ; 0x78
	db $24, $7e, $c6, $05, $21, $00, $d2, $85 ; 0x80
	db $6f, $30, $01, $24, $54, $5d, $21, $c1 ; 0x88
	db $60, $79, $85, $6f, $30, $01, $24, $7e ; 0x90
	db $21, $a9, $00, $85, $6f, $30, $01, $24 ; 0x98
	db $0e, $20, $df, $72, $05, $c9, $06, $04 ; 0xa0
	db $04, $05, $06, $05, $04, $07, $06, $0a ; 0xa8
	db $0a, $0a, $0a, $0a, $0a, $0a, $09, $0a ; 0xb0
	db $15, $16, $17, $18, $19, $10, $11, $12 ; 0xb8
	db $13, $14 ; 0xc0
SetCourtSelectBGM:
	ld a, c ; $60dd
	ld hl, CourtSelectBgmIds_3e ; $60de
	add l ; $60e1
	ld l, a ; $60e2
	jr nc, .read ; $60e3
	inc h ; $60e5
.read:
	ld a, [hl] ; $60e6
	ld [wMatchBGM], a ; $60e7
	ret ; $60ea
CourtSelectBgmIds_3e:
	; $60eb, 9 bytes (bytes:9)
	db $06, $06, $06, $06, $11, $12, $13, $16, $14 ; 0x00
SetCourtSelectBGMLink:
	ld a, c ; $60f4
	ld hl, CourtSelectBgmIdsLink_3e ; $60f5
	add l ; $60f8
	ld l, a ; $60f9
	jr nc, .read ; $60fa
	inc h ; $60fc
.read:
	ld a, [hl] ; $60fd
	ld [wMatchBGM], a ; $60fe
	ret ; $6101
CourtSelectBgmIdsLink_3e:
	; $6102, 9 bytes (bytes:9)
	db $07, $07, $07, $07, $11, $12, $13, $16, $14 ; 0x00
LoadCourtSelectHeader:
	call LoadCourtSelectTitleGfx ; $610b
	call DrawCourtSelectTitleRow ; $610e
	call FlushCourtSelectTitleRow ; $6111
	call AdvanceFrame ; $6114
	ret ; $6117
DrawCourtSelectTitleRow:
	push_wram_bank WRAM_SCREEN ; $6118
	ld a, $12 ; $6121
	ld hl, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $6123
	ld c, $20 ; $6126
.loop:
	ld [hl], c ; $6128
	inc hl ; $6129
	dec a ; $612a
	jr nz, .loop ; $612b
	call DrawCourtSelectTitleLeft ; $612d
	call DrawCourtSelectTitleRight ; $6130
	pop_wram_bank ; $6133
	ret ; $6138
DrawCourtSelectTitleLeft:
	ld b, $30 ; $6139
	ld hl, wShadowTilemap + 15 * TILEMAP_WIDTH ; $613b
	ld c, $04 ; $613e
	farcall FillIncrementingBytes ; $6140
	ld hl, wShadowTilemap + 16 * TILEMAP_WIDTH ; $6143
	ld c, $04 ; $6146
	farcall FillIncrementingBytes ; $6148
	ld hl, wShadowTilemap + 17 * TILEMAP_WIDTH ; $614b
	ld c, $04 ; $614e
	farcall FillIncrementingBytes ; $6150
	ret ; $6153
DrawCourtSelectTitleRight:
	ld b, $40 ; $6154
	ld hl, wShadowTilemap + 16 * TILEMAP_WIDTH + 9 ; $6156
	ld c, $05 ; $6159
	farcall FillIncrementingBytes ; $615b
	ret ; $615e
FlushCourtSelectTitleRow:
	push_wram_bank WRAM_SCREEN ; $615f
	ld hl, wShadowTilemap + 15 * TILEMAP_WIDTH ; $6168
	ld de, vBGMap0 + 15 * TILEMAP_WIDTH ; $616b
	ld bc, $0006 ; $616e
	call QueueVRAMCopy ; $6171
	pop_wram_bank ; $6174
	ret ; $6179
LoadCourtSelectTitleGfx:
	push_wram_bank WRAM_STAGING ; $617a
	call LoadCourtSelectTitleTiles ; $6183
	call LoadCourtSelectTitleTiles2 ; $6186
	call LoadCourtSelectPanelTiles ; $6189
	pop_wram_bank ; $618c
	ret ; $6191
LoadCourtSelectTitleTiles:
	ld hl, CourtSelectTitleTiles ; $6192
	ld de, wDecompBuffer ; $6195
	call DecompressData ; $6198
	ld hl, wDecompBuffer ; $619b
	ld de, vTiles2 + $30 * TILE_SIZE ; $619e
	ld bc, $000c ; $61a1
	call QueueVRAMCopy ; $61a4
	ret ; $61a7
LoadCourtSelectTitleTiles2:
	ld hl, CourtSelectTitleTiles2Gfx ; $61a8
	ld de, wDecompBuffer + 16 * TILE_SIZE ; $61ab
	call DecompressData ; $61ae
	ld hl, wDecompBuffer + 16 * TILE_SIZE ; $61b1
	ld de, vTiles2 + $40 * TILE_SIZE ; $61b4
	ld bc, $0005 ; $61b7
	call QueueVRAMCopy ; $61ba
	ret ; $61bd
LoadCourtSelectPanelTiles:
	ld hl, CourtSelectPanelTiles ; $61be
	ld de, wDecompBuffer + 32 * TILE_SIZE ; $61c1
	call DecompressData ; $61c4
	ld hl, wDecompBuffer + 32 * TILE_SIZE ; $61c7
	ld de, vTiles1 ; $61ca
	ld bc, $0037 ; $61cd
	call QueueVRAMCopy ; $61d0
	ret ; $61d3
CourtSelectTitleTiles:
	INCBIN "data/bank_03e/lz_CourtSelectTitleTiles.bin" ; $61d4, 159 bytes
CourtSelectTitleTiles2Gfx:
	INCBIN "data/bank_03e/lz_CourtSelectTitleTiles2Gfx.bin" ; $6273, 83 bytes
CourtSelectPanelTiles:
	INCBIN "data/bank_03e/lz_CourtSelectPanelTiles.bin" ; $62c6, 457 bytes
DrawCourtNameTiles:
	push_wram_bank WRAM_SCREEN ; $648f
	push bc ; $6498
	call DrawCourtNameLeft ; $6499
	pop bc ; $649c
	call DrawCourtNameRight ; $649d
	pop_wram_bank ; $64a0
	ret ; $64a5
DrawCourtNameLeft:
	ld a, b ; $64a6
	cp $ff ; $64a7
	jr nz, .neff ; $64a9
	ld b, $ac ; $64ab
	jr .fillIncrementingBytes ; $64ad
.neff:
	ld hl, CourtNameLeftIndices_3e ; $64af
	ld a, b ; $64b2
	add l ; $64b3
	ld l, a ; $64b4
	jr nc, .read ; $64b5
	inc h ; $64b7
.read:
	ld a, [hl] ; $64b8
	ld b, $80 ; $64b9
	add b ; $64bb
	ld b, a ; $64bc
.fillIncrementingBytes:
	ld hl, wShadowTilemap + 16 * TILEMAP_WIDTH + 4 ; $64bd
	ld c, $05 ; $64c0
	farcall FillIncrementingBytes ; $64c2
	ret ; $64c5
CourtNameLeftIndices_3e:
	; $64c6, 9 bytes (bytes:9)
	db $0b, $00, $16, $21, $16, $0b, $21, $16, $00 ; 0x00
DrawCourtNameRight:
	ld a, b ; $64cf
	cp $ff ; $64d0
	jr nz, .neff ; $64d2
	ld b, $b1 ; $64d4
	jr .fillIncrementingBytes ; $64d6
.neff:
	ld hl, CourtNameRightIndices_3e ; $64d8
	ld a, b ; $64db
	add l ; $64dc
	ld l, a ; $64dd
	jr nc, .read ; $64de
	inc h ; $64e0
.read:
	ld a, [hl] ; $64e1
	ld b, $80 ; $64e2
	add b ; $64e4
	ld b, a ; $64e5
.fillIncrementingBytes:
	ld hl, wShadowTilemap + 16 * TILEMAP_WIDTH + 14 ; $64e6
	ld c, $06 ; $64e9
	farcall FillIncrementingBytes ; $64eb
	ret ; $64ee
CourtNameRightIndices_3e:
	; $64ef, 9 bytes (bytes:9)
	db $1b, $05, $05, $10, $1b, $10, $05, $26, $1b ; 0x00
