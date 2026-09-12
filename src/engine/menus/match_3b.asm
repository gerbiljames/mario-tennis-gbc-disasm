BuildSaveSlotSummaries:
	push_wram_bank WRAM_SCREEN ; $5aac
	ld hl, wShadowTilemap + 24 * TILEMAP_WIDTH ; $5ab5
	ld bc, $0003 ; $5ab8
	call ClearMemory16 ; $5abb
	ld bc, wShadowTilemap + 24 * TILEMAP_WIDTH ; $5abe
	ld a, $80 ; $5ac1
.loop:
	push af ; $5ac3
	push af ; $5ac4
	wram_bank WRAM_COURT_PLANES ; $5ac5
	pop af ; $5acb
	farcall LoadCharacterRecordToBuffer ; $5acc
	farcall CheckCharacterUnlocked ; $5acf
	ld hl, $0000 ; $5ad2
	add hl, bc ; $5ad5
	wram_bank WRAM_COURT_PLANES ; $5ad6
	ld a, [wCharRecordScratch + 11] ; $5adc
	push af ; $5adf
	wram_bank WRAM_SCREEN ; $5ae0
	pop af ; $5ae6
	cp $04 ; $5ae7
	jr c, .checkStoryModeMainCharacterOverworldSprite ; $5ae9
	ld [hl], a ; $5aeb
	inc hl ; $5aec
	ld a, $03 ; $5aed
	ld [hl-], a ; $5aef
	ld hl, $0010 ; $5af0
	add hl, bc ; $5af3
	ld b, h ; $5af4
	ld c, l ; $5af5
	jr .restore ; $5af6
.checkStoryModeMainCharacterOverworldSprite:
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $5af8
	ld [hl], a ; $5afb
	ld hl, $0001 ; $5afc
	add hl, bc ; $5aff
	ld a, [wStoryModeMainCharacterOverworldSpriteColor] ; $5b00
	ld [hl], a ; $5b03
	ld hl, $0002 ; $5b04
	add hl, bc ; $5b07
	ld a, [wStoryMainCharExpTier] ; $5b08
	ld [hl], a ; $5b0b
	push bc ; $5b0c
	ld a, $03 ; $5b0d
	add c ; $5b0f
	ld e, a ; $5b10
	ld d, b ; $5b11
	ld hl, wStoryModeNameOfMainCharacter ; $5b12
	ld bc, $000b ; $5b15
	call CopyMemoryBC ; $5b18
	pop bc ; $5b1b
	ld hl, $000f ; $5b1c
	add hl, bc ; $5b1f
	ld a, [wSavedGameTimer + 3] ; $5b20
	ld [hl], a ; $5b23
	ld hl, $000e ; $5b24
	add hl, bc ; $5b27
	ld a, [wCharDataSyncValues] ; $5b28
	ld [hl], a ; $5b2b
	ld hl, $0010 ; $5b2c
	add hl, bc ; $5b2f
	ld b, h ; $5b30
	ld c, l ; $5b31
.restore:
	pop af ; $5b32
	inc a ; $5b33
	cp $83 ; $5b34
	jr nz, .loop ; $5b36
	pop_wram_bank ; $5b38
	ret ; $5b3d
DrawMainMenuCaption:
	push_wram_bank WRAM_SCREEN ; $5b3e
	ld c, $03 ; $5b47
	call GetMenuCursorIndex_3b ; $5b49
	ld b, a ; $5b4c
	cp $06 ; $5b4d
	jp nc, .step3 ; $5b4f
	cp $03 ; $5b52
	jp c, .step3 ; $5b54
	sub $03 ; $5b57
	add a ; $5b59
	add a ; $5b5a
	add a ; $5b5b
	add a ; $5b5c
	ld bc, wShadowTilemap + 24 * TILEMAP_WIDTH ; $5b5d
	add c ; $5b60
	ld c, a ; $5b61
	jr nc, .gotPtr ; $5b62
	inc b ; $5b64
.gotPtr:
	ld hl, $0000 ; $5b65
	add hl, bc ; $5b68
	ld a, [hl] ; $5b69
	cp $3f ; $5b6a
	jr z, .eq3f ; $5b6c
	ld hl, $0003 ; $5b6e
	add hl, bc ; $5b71
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $5b72
	call DrawNameWithDiacritics_3b ; $5b75
	ld a, $4c ; $5b78
	ld [wShadowTilemap + 16 * TILEMAP_WIDTH + 9], a ; $5b7a
	ld a, $56 ; $5b7d
	ld [wShadowTilemap + 16 * TILEMAP_WIDTH + 10], a ; $5b7f
	push af ; $5b82
	push bc ; $5b83
	push de ; $5b84
	push hl ; $5b85
	ld hl, $0002 ; $5b86
	add hl, bc ; $5b89
	ld a, [hl] ; $5b8a
	ld h, $00 ; $5b8b
	ld l, a ; $5b8d
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 12 ; $5b8e
	ld bc, wShadowTilemap + 25 * TILEMAP_WIDTH + 16 ; $5b91
	call PrintNumberRightAligned ; $5b94
	pop hl ; $5b97
	pop de ; $5b98
	pop bc ; $5b99
	pop af ; $5b9a
	push af ; $5b9b
	push bc ; $5b9c
	push de ; $5b9d
	push hl ; $5b9e
	ld hl, $000f ; $5b9f
	add hl, bc ; $5ba2
	ld a, [hl] ; $5ba3
	ld h, $00 ; $5ba4
	ld l, a ; $5ba6
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 15 ; $5ba7
	ld bc, wShadowTilemap + 25 * TILEMAP_WIDTH + 16 ; $5baa
	call Print2DigitNumberRightAligned ; $5bad
	pop hl ; $5bb0
	pop de ; $5bb1
	pop bc ; $5bb2
	pop af ; $5bb3
	ld hl, $000e ; $5bb4
	add hl, bc ; $5bb7
	ld a, [hl] ; $5bb8
	ld h, $00 ; $5bb9
	ld l, a ; $5bbb
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 18 ; $5bbc
	ld bc, wShadowTilemap + 25 * TILEMAP_WIDTH + 16 ; $5bbf
	call Print2DigitNumberRightAligned ; $5bc2
	pop_wram_bank ; $5bc5
	ld a, $3a ; $5bca
	ld [wShadowTilemap + 16 * TILEMAP_WIDTH + 16], a ; $5bcc
	ret ; $5bcf
.eq3f:
	ld hl, Text_30_124 ; $5bd0
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $5bd3
	ld c, $20 ; $5bd6
	farcall RenderTextToBuffer64 ; $5bd8
	jr .restore ; $5bdb
.step3:
	ld b, a ; $5bdd
	ld a, b ; $5bde
	add a ; $5bdf
	ld hl, MainMenuCaptionTable ; $5be0
	add l ; $5be3
	ld l, a ; $5be4
	jr nc, .read ; $5be5
	inc h ; $5be7
.read:
	ld a, [hl+] ; $5be8
	ld d, [hl] ; $5be9
	ld e, a ; $5bea
	ld a, b ; $5beb
	ld hl, MainMenuCaptionTable1 ; $5bec
	add a ; $5bef
	add l ; $5bf0
	ld l, a ; $5bf1
	jr nc, .readB ; $5bf2
	inc h ; $5bf4
.readB:
	ld a, [hl+] ; $5bf5
	ld h, [hl] ; $5bf6
	ld l, a ; $5bf7
	ld c, $20 ; $5bf8
	farcall RenderTextToBuffer64 ; $5bfa
.restore:
	pop_wram_bank ; $5bfd
	ret ; $5c02
MainMenuCaptionTable:
	; $5c03, 18 bytes (ram_ptrs:3)
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 0
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 1
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 2
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 3
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 4
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 5
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 6
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 7
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 8
MainMenuCaptionTable1:
	; $5c15, 18 bytes (records:2)
	dw $007d ; record 0
	dw $007e ; record 1
	dw $007f ; record 2
	dw $007c ; record 3
	dw $007c ; record 4
	dw $007c ; record 5
	dw $0080 ; record 6
	dw $0081 ; record 7
	dw $0082 ; record 8
Print2DigitNumberRightAligned:
	ld a, $02 ; $5c27
	jr PrintNumberRightAligned.format ; $5c29
PrintNumberRightAligned:
	ld a, $00 ; $5c2b
.format:
	push af ; $5c2d
	push bc ; $5c2e
	push de ; $5c2f
	push hl ; $5c30
	ld d, b ; $5c31
	ld e, c ; $5c32
	call FormatDecimalNumber ; $5c33
	pop hl ; $5c36
	pop de ; $5c37
	pop bc ; $5c38
	pop af ; $5c39
	ld h, b ; $5c3a
	ld l, c ; $5c3b
	ld c, $ff ; $5c3c
.lenLoop:
	inc c ; $5c3e
	ld a, [hl+] ; $5c3f
	or a ; $5c40
	jr nz, .lenLoop ; $5c41
	dec hl ; $5c43
	dec hl ; $5c44
.copyLoop:
	ld a, [hl-] ; $5c45
	cp $20 ; $5c46
	jr nz, .store ; $5c48
	ld a, $30 ; $5c4a
.store:
	ld [de], a ; $5c4c
	dec de ; $5c4d
	dec c ; $5c4e
	jr nz, .copyLoop ; $5c4f
	ret ; $5c51
StubNop_3b_3:
	ret ; $5c52
TryMainMenuLinkHandshake:
	di ; $5c53
	xor a ; $5c54
	ldh [rIF], a ; $5c55
	ldh a, [rIE] ; $5c57
	and $09 ; $5c59
	ldh [rIE], a ; $5c5b
	ei ; $5c5d
	ld a, [wMenuCursorX] ; $5c5e
	cp $02 ; $5c61
	jr nz, .ne02 ; $5c63
	ld a, [wMenuCursorY] ; $5c65
	cp $00 ; $5c68
	jr z, .eq00 ; $5c6a
.ne02:
	scf ; $5c6c
	ccf ; $5c6d
	jr .done ; $5c6e
.eq00:
	di ; $5c70
	ldh a, [hLinkRxByte] ; $5c71
	ei ; $5c73
	cp $c1 ; $5c74
	jr z, .waitFramesCmd ; $5c76
.loop:
	farcall ShowLinkMessageScreen ; $5c78
	farcall TryEstablishLink ; $5c7b
	push af ; $5c7e
	jr nc, .beginFadeOut ; $5c7f
	or a ; $5c81
	jr nz, .nonZero ; $5c82
	ldh a, [hWramBank] ; $5c84
	push af ; $5c86
	ld c, $00 ; $5c87
	farcall ShowLinkStatusMessage ; $5c89
	pop_wram_bank ; $5c8c
	jr .animateLinkStatusPalette ; $5c91
.nonZero:
	ldh a, [hWramBank] ; $5c93
	push af ; $5c95
	ld c, $01 ; $5c96
	farcall ShowLinkStatusMessage ; $5c98
	pop_wram_bank ; $5c9b
.animateLinkStatusPalette:
	ld de, $01f4 ; $5ca0
.loopB:
	farcall AnimateLinkStatusPalette ; $5ca3
	farcall UpdateAnimatedTiles ; $5ca6
	call AdvanceFrame ; $5ca9
	ldh a, [hInputPressed] ; $5cac
	bit PADB_A, a ; $5cae
	jr nz, .beginFadeOut ; $5cb0
	bit 1, a ; $5cb2
	jr nz, .beginFadeOut ; $5cb4
	dec de ; $5cb6
	ld a, d ; $5cb7
	or e ; $5cb8
	jr nz, .loopB ; $5cb9
.beginFadeOut:
	ld c, $40 ; $5cbb
	call BeginFadeOut ; $5cbd
	call WaitFadeEnd ; $5cc0
	call DisableLCDSafely ; $5cc3
	farcall ResetScreenAndTextWindows ; $5cc6
	call EnableLCD ; $5cc9
	script_fade_in $40 ; $5ccc
	call WaitFadeEnd ; $5cd1
	pop af ; $5cd4
	jr .done ; $5cd5
.waitFramesCmd:
	wait_frames $06 ; $5cd7
	farcall TryEstablishLink ; $5cdb
	jr c, .loop ; $5cde
.done:
	ret ; $5ce0
RestoreScreenAfterLinkAttempt:
	call DisableLCDSafely ; $5ce1
	farcall LoadMenuFontGfx ; $5ce4
	farcall ResetScreenAndTextWindows ; $5ce7
	call EnableLCD ; $5cea
	script_fade_in $10 ; $5ced
	ret ; $5cf2
RunMatchFormatSelect:
	ld hl, rIE ; $5cf3
	res 2, [hl] ; $5cf6
	sound BGM_MENU ; $5cf8
	call LoadMatchFormatGfx ; $5cfa
	wram_bank WRAM_SCREEN ; $5cfd
	ld a, [wMenuSlideDirection] ; $5d03
	ld b, a ; $5d06
	call MatchFormatSlideIn ; $5d07
	farcall InitMenuBgScroll ; $5d0a
	ld b, $01 ; $5d0d
	ld c, $01 ; $5d0f
	farcall LoadMenuSpritePalettePair ; $5d11
	call InitMatchFormatOptions ; $5d14
	ld a, $01 ; $5d17
	ld hl, MatchFormatCursorSpriteTask ; $5d19
	call RegisterFrameTask ; $5d1c
	call DrawMatchFormatCaption ; $5d1f
	wram_bank WRAM_SCREEN ; $5d22
.loop:
	call AdvanceFrame ; $5d28
	ldh a, [hInputPressed] ; $5d2b
	ld [wMenuInputPressed], a ; $5d2d
	call HandleMatchFormatInput ; $5d30
	ld b, $01 ; $5d33
	ld c, $03 ; $5d35
	call MoveMenuCursorGrid_3b ; $5d37
	or a ; $5d3a
	jr z, .checkMenuInputPressed ; $5d3b
	sound SFX_MENU_MOVE ; $5d3d
	call DrawMatchFormatCaption ; $5d3f
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $5d42
	bit PADB_A, a ; $5d45
	jr nz, .playSfx ; $5d47
	bit 1, a ; $5d49
	jr nz, .playSfx2 ; $5d4b
	jr .loop ; $5d4d
.playSfx:
	sound SFX_MENU_SELECT ; $5d4f
	ld hl, rIE ; $5d51
	set 2, [hl] ; $5d54
	call ClearFrameTasks ; $5d56
	ld b, $01 ; $5d59
	call MatchFormatSlideOut ; $5d5b
	ld a, MENUSLIDE_FORWARD ; $5d5e
	ld [wMenuSlideDirection], a ; $5d60
	ld c, $03 ; $5d63
	call GetMenuCursorIndex_3b ; $5d65
	ret ; $5d68
.playSfx2:
	sound SFX_MENU_CANCEL ; $5d69
	ld hl, rIE ; $5d6b
	set 2, [hl] ; $5d6e
	call ClearFrameTasks ; $5d70
	ld b, $00 ; $5d73
	call MatchFormatSlideOut ; $5d75
	ld a, MENUSLIDE_BACK ; $5d78
	ld [wMenuSlideDirection], a ; $5d7a
	ld a, $ff ; $5d7d
	ret ; $5d7f
InitMatchFormatOptions:
	ld b, $01 ; $5d80
	ld c, $00 ; $5d82
	call SetMenuCursorFromIndex_3b ; $5d84
	ld a, [wMatchFormatDoubles] ; $5d87
	ld b, a ; $5d8a
	ld c, $01 ; $5d8b
	call FillMatchFormatOptionCell ; $5d8d
	ld b, $00 ; $5d90
	call FlushMatchFormatRowToVram ; $5d92
	ld a, [wMatchFormatGames] ; $5d95
	add $02 ; $5d98
	ld b, a ; $5d9a
	ld c, $01 ; $5d9b
	call FillMatchFormatOptionCell ; $5d9d
	ld b, $01 ; $5da0
	call FlushMatchFormatRowToVram ; $5da2
	ld a, [wMatchFormatSets] ; $5da5
	add $04 ; $5da8
	ld b, a ; $5daa
	ld c, $01 ; $5dab
	call FillMatchFormatOptionCell ; $5dad
	ld b, $02 ; $5db0
	call FlushMatchFormatRowToVram ; $5db2
	ld hl, MatchFormatOptionsPalettes0 ; $5db5
	ld d, $04 ; $5db8
	ld e, $01 ; $5dba
	call LoadPaletteShadow ; $5dbc
	ld hl, MatchFormatOptionsPalettes1 ; $5dbf
	ld d, $06 ; $5dc2
	ld e, $01 ; $5dc4
	call LoadPaletteShadow ; $5dc6
	ld hl, MatchFormatOptionsPalettes2 ; $5dc9
	ld d, $07 ; $5dcc
	ld e, $01 ; $5dce
	call LoadPaletteShadow ; $5dd0
	ret ; $5dd3
MatchFormatOptionsPalettes0:
	; $5dd4, 8 bytes (bytes:8)
	db $df, $02, $ff, $7f, $a0, $01, $00, $00 ; 0x00
MatchFormatOptionsPalettes1:
	; $5ddc, 8 bytes (bytes:8)
	db $df, $02, $ff, $7f, $1f, $01, $00, $00 ; 0x00
MatchFormatOptionsPalettes2:
	; $5de4, 8 bytes (bytes:8)
	db $1f, $03, $ff, $7f, $40, $51, $00, $00 ; 0x00
LoadMatchFormatGfx:
	push_wram_bank WRAM_STAGING ; $5dec
	ld c, $00 ; $5df5
.loop:
	ld a, c ; $5df7
	add a ; $5df8
	ld hl, MatchFormatTable0 ; $5df9
	add l ; $5dfc
	ld l, a ; $5dfd
	jr nc, .read ; $5dfe
	inc h ; $5e00
.read:
	ld a, [hl+] ; $5e01
	ld h, [hl] ; $5e02
	ld l, a ; $5e03
	push af ; $5e04
	push bc ; $5e05
	push de ; $5e06
	push hl ; $5e07
	ld de, wDecompBuffer ; $5e08
	call DecompressDataFromBank ; $5e0b
	pop hl ; $5e0e
	pop de ; $5e0f
	pop bc ; $5e10
	pop af ; $5e11
	ld hl, MatchFormatTable1 ; $5e12
	ld a, c ; $5e15
	add a ; $5e16
	add l ; $5e17
	ld l, a ; $5e18
	jr nc, .readB ; $5e19
	inc h ; $5e1b
.readB:
	ld a, [hl+] ; $5e1c
	ld d, [hl] ; $5e1d
	ld e, a ; $5e1e
	ld hl, wDecompBuffer ; $5e1f
	push af ; $5e22
	push bc ; $5e23
	push de ; $5e24
	push hl ; $5e25
	ld bc, $0010 ; $5e26
	call QueueVRAMCopy ; $5e29
	pop hl ; $5e2c
	pop de ; $5e2d
	pop bc ; $5e2e
	pop af ; $5e2f
	ld a, c ; $5e30
	inc a ; $5e31
	ld c, a ; $5e32
	call AdvanceFrame ; $5e33
	ld a, c ; $5e36
	cp $07 ; $5e37
	jr nz, .loop ; $5e39
	ld b, TILEBLOCK_SharedMenuGfx35 ; $5e3b
	ld c, SharedMenuGfx35_SIZE / 16 ; $5e3d
	ld de, vTiles0 + VRAM_BANK1 ; $5e3f
	farcall LoadCompressedTileBlock ; $5e42
	call AdvanceFrame ; $5e45
	ld b, TILEBLOCK_SharedMenuGfx36 ; $5e48
	ld c, SharedMenuGfx36_SIZE / 16 ; $5e4a
	ld de, vTiles0 + $10 * TILE_SIZE + VRAM_BANK1 ; $5e4c
	farcall LoadCompressedTileBlock ; $5e4f
	call AdvanceFrame ; $5e52
	ld b, TILEBLOCK_SharedMenuGfx37 ; $5e55
	ld c, SharedMenuGfx37_SIZE / 16 ; $5e57
	ld de, vTiles0 + $20 * TILE_SIZE + VRAM_BANK1 ; $5e59
	farcall LoadCompressedTileBlock ; $5e5c
	call AdvanceFrame ; $5e5f
	ld b, TILEBLOCK_SharedMenuGfx38 ; $5e62
	ld c, SharedMenuGfx38_SIZE / 16 ; $5e64
	ld de, vTiles0 + $30 * TILE_SIZE + VRAM_BANK1 ; $5e66
	farcall LoadCompressedTileBlock ; $5e69
	call AdvanceFrame ; $5e6c
	ld b, TILEBLOCK_SharedMenuGfx39 ; $5e6f
	ld c, SharedMenuGfx39_SIZE / 16 ; $5e71
	ld de, vTiles0 + $40 * TILE_SIZE + VRAM_BANK1 ; $5e73
	farcall LoadCompressedTileBlock ; $5e76
	call AdvanceFrame ; $5e79
	ld b, TILEBLOCK_SharedMenuGfx40 ; $5e7c
	ld c, SharedMenuGfx40_SIZE / 16 ; $5e7e
	ld de, vTiles0 + $50 * TILE_SIZE + VRAM_BANK1 ; $5e80
	farcall LoadCompressedTileBlock ; $5e83
	call AdvanceFrame ; $5e86
	ld b, TILEBLOCK_SharedMenuGfx41 ; $5e89
	ld c, SharedMenuGfx41_SIZE / 16 ; $5e8b
	ld de, vTiles0 + $60 * TILE_SIZE + VRAM_BANK1 ; $5e8d
	farcall LoadCompressedTileBlock ; $5e90
	call AdvanceFrame ; $5e93
	ld b, TILEBLOCK_SharedMenuGfx27 ; $5e96
	ld c, SharedMenuGfx27_SIZE / 16 ; $5e98
	ld de, vTiles0 + $70 * TILE_SIZE + VRAM_BANK1 ; $5e9a
	farcall LoadCompressedTileBlock ; $5e9d
	call AdvanceFrame ; $5ea0
	ld b, TILEBLOCK_SharedMenuGfx63 ; $5ea3
	ld c, SharedMenuGfx63_SIZE / 16 ; $5ea5
	ld de, vTiles0 ; $5ea7
	farcall LoadCompressedTileBlock ; $5eaa
	call AdvanceFrame ; $5ead
	ld b, $08 ; $5eb0
	ld c, $10 ; $5eb2
	farcall LoadIndexedPalette ; $5eb4
	pop_wram_bank ; $5eb7
	ret ; $5ebc
MatchFormatTable0:
	; $5ebd, 14 bytes (bytes:2)
	db $62, $3c ; 0x00
	db $64, $3c ; 0x02
	db $66, $3c ; 0x04
	db $68, $3c ; 0x06
	db $6a, $3c ; 0x08
	db $6c, $3c ; 0x0a
	db $6e, $3c ; 0x0c
MatchFormatTable1:
	; $5ecb, 14 bytes (bytes:2)
	db $00, $a8 ; 0x00
	db $00, $a9 ; 0x02
	db $00, $aa ; 0x04
	db $00, $ab ; 0x06
	db $00, $ac ; 0x08
	db $00, $ad ; 0x0a
	db $00, $ae ; 0x0c
MatchFormatSlideIn:
	ld a, b ; $5ed9
	or a ; $5eda
	jr z, .zero ; $5edb
	ld c, $00 ; $5edd
.loop:
	call AdvanceFrame ; $5edf
	ld b, $02 ; $5ee2
	farcall RestoreMenuBgAndDrawPanel ; $5ee4
	ld b, $00 ; $5ee7
	farcall FlushWram3MapRows ; $5ee9
	ld a, c ; $5eec
	inc a ; $5eed
	ld c, a ; $5eee
	cp $0e ; $5eef
	jr nz, .loop ; $5ef1
	ret ; $5ef3
.zero:
	ld c, $0a ; $5ef4
.loopB:
	call AdvanceFrame ; $5ef6
	ld b, $03 ; $5ef9
	farcall RestoreMenuBgAndDrawPanel ; $5efb
	ld b, $00 ; $5efe
	farcall FlushWram3MapRows ; $5f00
	ld a, c ; $5f03
	dec a ; $5f04
	ld c, a ; $5f05
	cp $ff ; $5f06
	jr nz, .loopB ; $5f08
	ret ; $5f0a
; Instruction-identical to CloseMatchRulesPanel (one copy per bank); a change here belongs in every copy.
	twin_named match_format_slide_out, MatchFormatSlideOut ; $5f0b
HandleMatchFormatInput:
	ld a, [wMenuInputPressed] ; $5f3c
	bit PADB_LEFT, a ; $5f3f
	jr nz, .playSfx ; $5f41
	bit 4, a ; $5f43
	jr nz, .playSfx2 ; $5f45
	ret ; $5f47
.playSfx:
	sound SFX_MENU_MOVE ; $5f48
	ld c, $01 ; $5f4a
	call GetMenuCursorIndex_3b ; $5f4c
	or a ; $5f4f
	jr nz, .compare ; $5f50
	ld a, [wMatchFormatDoubles] ; $5f52
	xor $01 ; $5f55
	ld [wMatchFormatDoubles], a ; $5f57
	ld b, $00 ; $5f5a
	call FlushMatchFormatRowToVram ; $5f5c
	call RedrawMatchFormatModeRow ; $5f5f
	call DrawMatchFormatCaption ; $5f62
	ret ; $5f65
.compare:
	cp $01 ; $5f66
	jr nz, .checkMatchFormatSets ; $5f68
	ld a, [wMatchFormatGames] ; $5f6a
	xor $01 ; $5f6d
	ld [wMatchFormatGames], a ; $5f6f
	ld b, $01 ; $5f72
	call FlushMatchFormatRowToVram ; $5f74
	call RedrawMatchFormatGamesRow ; $5f77
	call DrawMatchFormatCaption ; $5f7a
	ret ; $5f7d
.checkMatchFormatSets:
	ld a, [wMatchFormatSets] ; $5f7e
	dec a ; $5f81
	add a ; $5f82
	jr nc, .noCarry ; $5f83
	ld a, $03 ; $5f85
	dec a ; $5f87
	jr .store ; $5f88
.noCarry:
	rra ; $5f8a
	cp $03 ; $5f8b
	jr c, .store ; $5f8d
	xor a ; $5f8f
.store:
	ld [wMatchFormatSets], a ; $5f90
	ld b, $02 ; $5f93
	call FlushMatchFormatRowToVram ; $5f95
	call RedrawMatchFormatSetsRow ; $5f98
	call DrawMatchFormatCaption ; $5f9b
	ret ; $5f9e
.playSfx2:
	sound SFX_MENU_MOVE ; $5f9f
	ld c, $01 ; $5fa1
	call GetMenuCursorIndex_3b ; $5fa3
	or a ; $5fa6
	jr nz, .compare2 ; $5fa7
	ld a, [wMatchFormatDoubles] ; $5fa9
	xor $01 ; $5fac
	ld [wMatchFormatDoubles], a ; $5fae
	ld b, $00 ; $5fb1
	call FlushMatchFormatRowToVram ; $5fb3
	call RedrawMatchFormatModeRow ; $5fb6
	call DrawMatchFormatCaption ; $5fb9
	ret ; $5fbc
.compare2:
	cp $01 ; $5fbd
	jr nz, .checkMatchFormatSets2 ; $5fbf
	ld a, [wMatchFormatGames] ; $5fc1
	xor $01 ; $5fc4
	ld [wMatchFormatGames], a ; $5fc6
	ld b, $01 ; $5fc9
	call FlushMatchFormatRowToVram ; $5fcb
	call RedrawMatchFormatGamesRow ; $5fce
	call DrawMatchFormatCaption ; $5fd1
	ret ; $5fd4
.checkMatchFormatSets2:
	ld a, [wMatchFormatSets] ; $5fd5
	inc a ; $5fd8
	add a ; $5fd9
	jr nc, .noCarry2 ; $5fda
	ld a, $03 ; $5fdc
	dec a ; $5fde
	jr .store2 ; $5fdf
.noCarry2:
	rra ; $5fe1
	cp $03 ; $5fe2
	jr c, .store2 ; $5fe4
	xor a ; $5fe6
.store2:
	ld [wMatchFormatSets], a ; $5fe7
	ld b, $02 ; $5fea
	call FlushMatchFormatRowToVram ; $5fec
	call RedrawMatchFormatSetsRow ; $5fef
	call DrawMatchFormatCaption ; $5ff2
	ret ; $5ff5
RedrawMatchFormatModeRow:
	ld b, $00 ; $5ff6
	ld c, $00 ; $5ff8
	call FillMatchFormatOptionCell ; $5ffa
	ld b, $01 ; $5ffd
	ld c, $00 ; $5fff
	call FillMatchFormatOptionCell ; $6001
	ld a, [wMatchFormatDoubles] ; $6004
	ld b, a ; $6007
	ld c, $01 ; $6008
	call FillMatchFormatOptionCell ; $600a
	ret ; $600d
RedrawMatchFormatGamesRow:
	ld b, $02 ; $600e
	ld c, $00 ; $6010
	call FillMatchFormatOptionCell ; $6012
	ld b, $03 ; $6015
	ld c, $00 ; $6017
	call FillMatchFormatOptionCell ; $6019
	ld a, [wMatchFormatGames] ; $601c
	add $02 ; $601f
	ld b, a ; $6021
	ld c, $01 ; $6022
	call FillMatchFormatOptionCell ; $6024
	ret ; $6027
RedrawMatchFormatSetsRow:
	ld b, $04 ; $6028
	ld c, $00 ; $602a
	call FillMatchFormatOptionCell ; $602c
	ld b, $05 ; $602f
	ld c, $00 ; $6031
	call FillMatchFormatOptionCell ; $6033
	ld b, $06 ; $6036
	ld c, $00 ; $6038
	call FillMatchFormatOptionCell ; $603a
	ld a, [wMatchFormatSets] ; $603d
	add $04 ; $6040
	ld b, a ; $6042
	ld c, $01 ; $6043
	call FillMatchFormatOptionCell ; $6045
	ret ; $6048
FillMatchFormatOptionCell:
	push af ; $6049
	push bc ; $604a
	push de ; $604b
	push hl ; $604c
	push_wram_bank WRAM_SCREEN ; $604d
	ld hl, FillMatchFormatOptionCellTable ; $6056
	ld a, b ; $6059
	add a ; $605a
	add l ; $605b
	ld l, a ; $605c
	jr nc, .readAddr ; $605d
	inc h ; $605f
.readAddr:
	ld a, [hl+] ; $6060
	ld d, [hl] ; $6061
	ld e, a ; $6062
	ld h, $0d ; $6063
	ld a, c ; $6065
	or a ; $6066
	jr z, .fill ; $6067
	ld a, b ; $6069
	ld hl, MatchFormatOptionCellTable ; $606a
	add l ; $606d
	ld l, a ; $606e
	jr nc, .readWidth ; $606f
	inc h ; $6071
.readWidth:
	ld a, [hl] ; $6072
	ld h, a ; $6073
.fill:
	ld b, $05 ; $6074
	ld c, $03 ; $6076
	farcall FillTilemapRect ; $6078
	pop_wram_bank ; $607b
	pop hl ; $6080
	pop de ; $6081
	pop bc ; $6082
	pop af ; $6083
	ret ; $6084
FillMatchFormatOptionCellTable:
	; $6085, 14 bytes (ram_ptrs:3)
	dw wShadowAttrmap + 3 * TILEMAP_WIDTH + 3 ; record 0
	dw wShadowAttrmap + 3 * TILEMAP_WIDTH + 12 ; record 1
	dw wShadowAttrmap + 7 * TILEMAP_WIDTH + 3 ; record 2
	dw wShadowAttrmap + 7 * TILEMAP_WIDTH + 12 ; record 3
	dw wShadowAttrmap + 11 * TILEMAP_WIDTH + 1 ; record 4
	dw wShadowAttrmap + 11 * TILEMAP_WIDTH + 7 ; record 5
	dw wShadowAttrmap + 11 * TILEMAP_WIDTH + 13 ; record 6
MatchFormatOptionCellTable:
	; $6093, 7 bytes (bytes:8)
	db $0c, $0c, $0e, $0e, $0f, $0f, $0f ; 0x00
; Instruction-identical to FlushMatchRuleRowAttrs (one copy per bank); a change here belongs in every copy.
	twin_named flush_match_format_row_to_vram, FlushMatchFormatRowToVram ; $609a
MatchFormatCursorSpriteTask:
	farcall TickMenuBgScroll ; $60d0
	ld c, $01 ; $60d3
	call GetMenuCursorIndex_3b ; $60d5
	or a ; $60d8
	jr nz, .compare ; $60d9
	ld a, [wMatchFormatDoubles] ; $60db
	jr .step ; $60de
.compare:
	cp $01 ; $60e0
	jr nz, .checkMatchFormatSets ; $60e2
	ld a, [wMatchFormatGames] ; $60e4
	add $02 ; $60e7
	jr .step ; $60e9
.checkMatchFormatSets:
	ld a, [wMatchFormatSets] ; $60eb
	add $04 ; $60ee
.step:
	push af ; $60f0
	ld hl, MatchFormatCursorSpriteTaskTable1 ; $60f1
	add l ; $60f4
	ld l, a ; $60f5
	jr nc, .read ; $60f6
	inc h ; $60f8
.read:
	ld c, [hl] ; $60f9
	pop af ; $60fa
	ld hl, MatchFormatCursorSpriteTaskTable0 ; $60fb
	add a ; $60fe
	add l ; $60ff
	ld l, a ; $6100
	jr nc, .readB ; $6101
	inc h ; $6103
.readB:
	ld a, [hl+] ; $6104
	ld d, [hl] ; $6105
	ld e, a ; $6106
	farcall ApplySpriteBobOffset ; $6107
	ld b, $08 ; $610a
	ld hl, MatchFormatCursorSpriteTask_SpriteTemplate0 ; $610c
	push de ; $610f
	call QueueSpriteTemplate ; $6110
	pop de ; $6113
	ld hl, $17f8 ; $6114
	add hl, de ; $6117
	ld d, h ; $6118
	ld e, l ; $6119
	ld hl, MatchFormatCursorSpriteTask_SpriteTemplate1 ; $611a
	ld b, $08 ; $611d
	ld c, $70 ; $611f
	call QueueSpriteTemplate ; $6121
	ret ; $6124
MatchFormatCursorSpriteTask_SpriteTemplate0:
	; $6125, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
MatchFormatCursorSpriteTask_SpriteTemplate1:
	; $6146, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
MatchFormatCursorSpriteTaskTable0:
	; $614f, 14 bytes (bytes:14)
	db $2d, $0a, $2d, $54, $4f, $0c, $4f, $54, $6a, $00, $6a, $2c, $6a, $5d ; 0x00
MatchFormatCursorSpriteTaskTable1:
	; $615d, 7 bytes (bytes:7)
	db $00, $10, $20, $30, $40, $50, $60 ; 0x00
DrawMatchFormatCaption:
	wram_bank WRAM_SCREEN ; $6164
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH ; $616a
	ld b, $14 ; $616d
	ld c, $01 ; $616f
	ld h, $03 ; $6171
	farcall FillTilemapRect ; $6173
	ld a, $02 ; $6176
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH], a ; $6178
	ld a, $04 ; $617b
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH + 19], a ; $617d
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $6180
	ld b, $12 ; $6183
	ld c, $01 ; $6185
	ld h, $20 ; $6187
	farcall FillTilemapRect ; $6189
	call RenderMatchFormatOptionText ; $618c
	ld hl, wShadowTilemap + 15 * TILEMAP_WIDTH ; $618f
	ld de, vBGMap0 + 15 * TILEMAP_WIDTH ; $6192
	ld c, $04 ; $6195
	call QueueVRAMCopy ; $6197
	ret ; $619a
RenderMatchFormatOptionText:
	wram_bank WRAM_SCREEN ; $619b
	ld c, $01 ; $61a1
	call GetMenuCursorIndex_3b ; $61a3
	or a ; $61a6
	jr nz, .compare ; $61a7
	ld a, [wMatchFormatDoubles] ; $61a9
	ld hl, $0087 ; $61ac
	add l ; $61af
	ld l, a ; $61b0
	jr nc, .renderTextToBuffer64 ; $61b1
	inc h ; $61b3
.renderTextToBuffer64:
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $61b4
	ld c, $20 ; $61b7
	farcall RenderTextToBuffer64 ; $61b9
	ret ; $61bc
.compare:
	cp $01 ; $61bd
	jr nz, .checkMatchFormatSets ; $61bf
	ld a, [wMatchFormatGames] ; $61c1
	ld hl, $0089 ; $61c4
	add l ; $61c7
	ld l, a ; $61c8
	jr nc, .renderTextToBuffer642 ; $61c9
	inc h ; $61cb
.renderTextToBuffer642:
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $61cc
	ld c, $20 ; $61cf
	farcall RenderTextToBuffer64 ; $61d1
	ret ; $61d4
.checkMatchFormatSets:
	ld a, [wMatchFormatSets] ; $61d5
	ld hl, $008b ; $61d8
	add l ; $61db
	ld l, a ; $61dc
	jr nc, .renderTextToBuffer643 ; $61dd
	inc h ; $61df
.renderTextToBuffer643:
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $61e0
	ld c, $20 ; $61e3
	farcall RenderTextToBuffer64 ; $61e5
	ret ; $61e8
