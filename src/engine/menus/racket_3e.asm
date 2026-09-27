RunEraseDataConfirmMenu:
	ld hl, rIE ; $4c12
	res 2, [hl] ; $4c15
	wram_bank WRAM_SCREEN ; $4c17
	ld a, b ; $4c1d
	ld [wScreenScratch], a ; $4c1e
	call DisableLCDSafely ; $4c21
	call ClearFrameTasks ; $4c24
	call LoadEraseDataConfirmScreen ; $4c27
	xor a ; $4c2a
	ld [wAnimatedTileSet], a ; $4c2b
	ld a, $01 ; $4c2e
	ld hl, UpdateAnimatedTiles_3e ; $4c30
	call RegisterFrameTask ; $4c33
	ld a, $01 ; $4c36
	ld hl, EraseConfirmCursorSpriteTask ; $4c38
	call RegisterFrameTask ; $4c3b
	call AnimateEraseConfirmPalette ; $4c3e
	call EnableLCD ; $4c41
	script_fade_in $08 ; $4c44
	call WaitFadeEnd ; $4c49
	ld a, $01 ; $4c4c
	ld hl, AnimateEraseConfirmPalette ; $4c4e
	call RegisterFrameTask ; $4c51
	wram_bank WRAM_SCREEN ; $4c54
.loop:
	call AdvanceFrame ; $4c5a
	ldh a, [hInputPressed] ; $4c5d
	ld [wMenuInputPressed], a ; $4c5f
	bit PADB_A, a ; $4c62
	jr nz, .checkMenuCursorY2 ; $4c64
	bit 1, a ; $4c66
	jr nz, .playSfx ; $4c68
	bit 6, a ; $4c6a
	jr nz, .checkMenuCursorY ; $4c6c
	bit 7, a ; $4c6e
	jr nz, .checkMenuCursorY ; $4c70
	jr .loop ; $4c72
.checkMenuCursorY:
	ld a, [wMenuCursorY] ; $4c74
	xor $01 ; $4c77
	ld [wMenuCursorY], a ; $4c79
	sound SFX_MENU_MOVE ; $4c7c
	jr .loop ; $4c7e
.checkMenuCursorY2:
	ld a, [wMenuCursorY] ; $4c80
	or a ; $4c83
	jr nz, .playSfx ; $4c84
	sound SFX_MENU_DECIDE ; $4c86
	ld hl, rIE ; $4c88
	set 2, [hl] ; $4c8b
	call ClearFrameTasks ; $4c8d
	ld c, $10 ; $4c90
	call BeginFadeOut ; $4c92
	call WaitFadeEnd ; $4c95
	ld a, $01 ; $4c98
	ret ; $4c9a
.playSfx:
	sound SFX_MENU_CANCEL ; $4c9b
	ld hl, rIE ; $4c9d
	set 2, [hl] ; $4ca0
	call ClearFrameTasks ; $4ca2
	ld c, $10 ; $4ca5
	call BeginFadeOut ; $4ca7
	call WaitFadeEnd ; $4caa
	xor a ; $4cad
	ret ; $4cae
LoadEraseDataConfirmScreen:
	ld c, $01 ; $4caf
	ld b, $01 ; $4cb1
	call SetMenuCursorFromIndex_3e ; $4cb3
	ld hl, vTiles0 + VRAM_BANK1 ; $4cb6
	ld de, $0801 ; $4cb9
	farcall LoadMenuHandCursorGfx ; $4cbc
	ld a, $0a ; $4cbf
	ld [wDigitSpriteAttr], a ; $4cc1
	ld a, $10 ; $4cc4
	ld [wDigitSpriteTileBase], a ; $4cc6
	ld c, SCREENASSET_WarningScreen ; $4cc9
	farcall LoadScreenAssetRecord ; $4ccb
	wram_bank WRAM_SCREEN ; $4cce
	ld de, wShadowAttrmap + 5 * TILEMAP_WIDTH + 3 ; $4cd4
	ld b, $0e ; $4cd7
	ld c, $06 ; $4cd9
	ld h, $00 ; $4cdb
	farcall FillTilemapRect ; $4cdd
	ld de, wShadowTilemap + 5 * TILEMAP_WIDTH + 3 ; $4ce0
	ld b, $0e ; $4ce3
	ld c, $06 ; $4ce5
	ld h, $20 ; $4ce7
	farcall FillTilemapRect ; $4ce9
	farcall ResetTextWindowState ; $4cec
	ld b, TILEBLOCK_SharedMenuGfx17Alias17 ; $4cef
	ld c, SharedMenuGfx17_SIZE / 16 ; $4cf1
	ld de, vTiles2 ; $4cf3
	farcall LoadCompressedTileBlock ; $4cf6
	wram_bank WRAM_TEXT ; $4cf9
	ld a, $03 ; $4cff
	ld [wShadowTilemapBank], a ; $4d01
	ld a, $00 ; $4d04
	ld [wWindowTileAttr], a ; $4d06
	ld d, $00 ; $4d09
	ld e, $0d ; $4d0b
	ld b, $0f ; $4d0d
	ld c, $05 ; $4d0f
	farcall CreateWindowFromScreenRect ; $4d11
	farcall DrawTextWindowFrame ; $4d14
	farcall RedrawWindowRows ; $4d17
	ld d, $0f ; $4d1a
	ld e, $0d ; $4d1c
	ld b, $05 ; $4d1e
	ld c, $05 ; $4d20
	farcall CreateWindowFromScreenRect ; $4d22
	farcall DrawTextWindowFrame ; $4d25
	farcall RedrawWindowRows ; $4d28
	farcall InitMenuBgScroll ; $4d2b
	ld b, $01 ; $4d2e
	ld c, $01 ; $4d30
	farcall LoadMenuSpritePalettePair ; $4d32
	farcall PrepareGlyphBuffer ; $4d35
	wram_bank WRAM_SCREEN ; $4d38
	ld a, [wScreenScratch] ; $4d3e
	cp $02 ; $4d41
	jr nz, .compare ; $4d43
	ld hl, Text_30_221 ; $4d45
	ld de, wShadowTilemap + 6 * TILEMAP_WIDTH + 3 ; $4d48
	ld c, $0e ; $4d4b
	farcall RenderProportionalTextAt ; $4d4d
	ld hl, Text_30_222 ; $4d50
	ld de, wShadowTilemap + 8 * TILEMAP_WIDTH + 3 ; $4d53
	ld c, $0e ; $4d56
	farcall RenderProportionalTextAt ; $4d58
	ld hl, Text_30_223 ; $4d5b
	ld de, wShadowTilemap + 14 * TILEMAP_WIDTH + 2 ; $4d5e
	ld c, $0e ; $4d61
	farcall RenderProportionalTextAt ; $4d63
	ld hl, Text_30_220 ; $4d66
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 2 ; $4d69
	ld c, $0e ; $4d6c
	farcall RenderProportionalTextAt ; $4d6e
	ld b, TILEBLOCK_SharedMenuGfx65 ; $4d71
	ld c, SharedMenuGfx65_SIZE / 16 ; $4d73
	ld de, vTiles0 ; $4d75
	farcall LoadCompressedTileBlock ; $4d78
	jp .renderProportionalTextAt ; $4d7b
.compare:
	or a ; $4d7e
	jr z, .zero ; $4d7f
	ld hl, Text_30_216 ; $4d81
	ld de, wShadowTilemap + 6 * TILEMAP_WIDTH + 3 ; $4d84
	ld c, $0e ; $4d87
	farcall RenderProportionalTextAt ; $4d89
	ld hl, Text_30_217 ; $4d8c
	ld de, wShadowTilemap + 8 * TILEMAP_WIDTH + 3 ; $4d8f
	ld c, $0e ; $4d92
	farcall RenderProportionalTextAt ; $4d94
	ld hl, Text_30_219 ; $4d97
	ld de, wShadowTilemap + 14 * TILEMAP_WIDTH + 2 ; $4d9a
	ld c, $0e ; $4d9d
	farcall RenderProportionalTextAt ; $4d9f
	ld hl, Text_30_220 ; $4da2
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 2 ; $4da5
	ld c, $0e ; $4da8
	farcall RenderProportionalTextAt ; $4daa
	ld b, TILEBLOCK_EraseDataConfirmGfx0 ; $4dad
	ld c, EraseDataConfirmGfx0_SIZE / 16 ; $4daf
	ld de, vTiles0 ; $4db1
	farcall LoadCompressedTileBlock ; $4db4
	jr .renderProportionalTextAt ; $4db7
.zero:
	ld hl, Text_30_214 ; $4db9
	ld de, wShadowTilemap + 6 * TILEMAP_WIDTH + 3 ; $4dbc
	ld c, $0e ; $4dbf
	farcall RenderProportionalTextAt ; $4dc1
	ld hl, Text_30_215 ; $4dc4
	ld de, wShadowTilemap + 8 * TILEMAP_WIDTH + 3 ; $4dc7
	ld c, $0e ; $4dca
	farcall RenderProportionalTextAt ; $4dcc
	ld hl, Text_30_218 ; $4dcf
	ld de, wShadowTilemap + 14 * TILEMAP_WIDTH + 2 ; $4dd2
	ld c, $0e ; $4dd5
	farcall RenderProportionalTextAt ; $4dd7
	ld hl, Text_30_220 ; $4dda
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 2 ; $4ddd
	ld c, $0e ; $4de0
	farcall RenderProportionalTextAt ; $4de2
	ld b, TILEBLOCK_EraseDataConfirmGfx1 ; $4de5
	ld c, EraseDataConfirmGfx1_SIZE / 16 ; $4de7
	ld de, vTiles0 ; $4de9
	farcall LoadCompressedTileBlock ; $4dec
.renderProportionalTextAt:
	ld hl, Text_30_122 ; $4def
	ld de, wShadowTilemap + 14 * TILEMAP_WIDTH + 16 ; $4df2
	ld c, $04 ; $4df5
	farcall RenderProportionalTextAt ; $4df7
	ld hl, Text_30_123 ; $4dfa
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 16 ; $4dfd
	ld c, $04 ; $4e00
	farcall RenderProportionalTextAt ; $4e02
	farcall UploadGlyphBuffer ; $4e05
	farcall QueueWram3MapToVRAM ; $4e08
	ret ; $4e0b
EraseConfirmCursorSpriteTask:
	ld de, $7376 ; $4e0c
	ld a, [wMenuCursorY] ; $4e0f
	or a ; $4e12
	jr z, .queueEraseConfirmCursorSprites ; $4e13
	ld de, $7386 ; $4e15
.queueEraseConfirmCursorSprites:
	call QueueEraseConfirmCursorSprites ; $4e18
	ret ; $4e1b
QueueEraseConfirmCursorSprites:
	ld c, $00 ; $4e1c
	ld b, $08 ; $4e1e
	push de ; $4e20
	call QueueSprite ; $4e21
	pop de ; $4e24
	ld a, $08 ; $4e25
	add d ; $4e27
	ld d, a ; $4e28
	ld c, $02 ; $4e29
	ld b, $08 ; $4e2b
	call QueueSprite ; $4e2d
	farcall TickMenuBgScroll ; $4e30
	ret ; $4e33
AnimateEraseConfirmPalette:
	push_wram_bank WRAM_SCREEN ; $4e34
	ld hl, EraseConfirmPalette_3e ; $4e3d
	ld de, wEraseConfirmPalette ; $4e40
	ld bc, $0008 ; $4e43
	call CopyMemoryBC ; $4e46
	ldh a, [hVBlankCounter] ; $4e49
	and $3c ; $4e4b
	srl a ; $4e4d
	srl a ; $4e4f
	add a ; $4e51
	jr nc, .noCarry ; $4e52
	ld a, $0c ; $4e54
	dec a ; $4e56
	jr .step2 ; $4e57
.noCarry:
	rra ; $4e59
	cp $0c ; $4e5a
	jr c, .step2 ; $4e5c
	xor a ; $4e5e
.step2:
	add a ; $4e5f
	ld hl, EraseConfirmFlashColors_3e ; $4e60
	add l ; $4e63
	ld l, a ; $4e64
	jr nc, .read ; $4e65
	inc h ; $4e67
.read:
	ld a, [hl+] ; $4e68
	ld d, [hl] ; $4e69
	ld e, a ; $4e6a
	ld hl, wEraseConfirmPalette + 4 ; $4e6b
	ld [hl], e ; $4e6e
	inc hl ; $4e6f
	ld [hl], d ; $4e70
	ld hl, wEraseConfirmPalette ; $4e71
	lb de, $04, $01 ; $4e74 palette index, count
	call LoadPaletteShadow ; $4e77
	pop_wram_bank ; $4e7a
	ret ; $4e7f
EraseConfirmPalette_3e:
	; $4e80, 8 bytes (bytes:8)
	db $48, $00, $13, $3e, $ff, $7f, $bf, $01 ; 0x00
EraseConfirmFlashColors_3e:
	; $4e88, 24 bytes (bytes:16)
	db $1f, $00, $df, $00, $ff, $01, $bf, $02, $7f, $03, $ff, $03, $ff, $03, $9f, $03 ; 0x00
	db $bf, $02, $ff, $01, $df, $00, $1f, $00 ; 0x10
RunRacketShoesChoiceMenu:
	sound BGM_MENU ; $4ea0
	ld hl, rIE ; $4ea2
	res 2, [hl] ; $4ea5
	call LoadRacketShoesChoiceGraphics ; $4ea7
	wram_bank WRAM_SCREEN ; $4eaa
	ld a, [wMenuSlideDirection] ; $4eb0
	ld b, a ; $4eb3
	call OpenChoiceTabPanel ; $4eb4
	farcall InitMenuBgScroll ; $4eb7
	ld b, $01 ; $4eba
	ld c, $01 ; $4ebc
	farcall LoadMenuSpritePalettePair ; $4ebe
	ld a, [wRacketShoesTabIndex] ; $4ec1
	ld c, a ; $4ec4
	ld b, $02 ; $4ec5
	call SetMenuCursorFromIndex_3e ; $4ec7
	ld a, $01 ; $4eca
	ld hl, ChoiceTabCursorSpriteTask ; $4ecc
	call RegisterFrameTask ; $4ecf
	call RedrawRacketShoesChoiceMenu ; $4ed2
	wram_bank WRAM_SCREEN ; $4ed5
.loop:
	call AdvanceFrame ; $4edb
	ldh a, [hInputPressed] ; $4ede
	ld [wMenuInputPressed], a ; $4ee0
	ld b, $02 ; $4ee3
	ld c, $01 ; $4ee5
	call MoveMenuCursorGrid_3e ; $4ee7
	or a ; $4eea
	jr z, .checkMenuInputPressed ; $4eeb
	sound SFX_MENU_MOVE ; $4eed
	call RedrawRacketShoesChoiceMenu ; $4eef
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $4ef2
	bit PADB_A, a ; $4ef5
	jr nz, .playSfx ; $4ef7
	bit 1, a ; $4ef9
	jr nz, .playSfx2 ; $4efb
	jr .loop ; $4efd
.playSfx:
	sound SFX_MENU_SELECT ; $4eff
	call ClearFrameTasks ; $4f01
	ld hl, rIE ; $4f04
	set 2, [hl] ; $4f07
	ld b, $01 ; $4f09
	call CloseChoiceTabPanel ; $4f0b
	ld a, MENUSLIDE_FORWARD ; $4f0e
	ld [wMenuSlideDirection], a ; $4f10
	ld c, $02 ; $4f13
	call GetMenuCursorIndex_3e ; $4f15
	ld [wRacketShoesTabIndex], a ; $4f18
	ret ; $4f1b
.playSfx2:
	sound SFX_MENU_CANCEL ; $4f1c
	call ClearFrameTasks ; $4f1e
	ld hl, rIE ; $4f21
	set 2, [hl] ; $4f24
	ld b, $00 ; $4f26
	call CloseChoiceTabPanel ; $4f28
	ld a, MENUSLIDE_BACK ; $4f2b
	ld [wMenuSlideDirection], a ; $4f2d
	ld a, $ff ; $4f30
	ret ; $4f32
LoadRacketShoesChoiceGraphics:
	push_wram_bank WRAM_STAGING ; $4f33
	ld c, $00 ; $4f3c
.loop:
	ld a, c ; $4f3e
	add a ; $4f3f
	ld hl, RacketShoesChoiceGfxParams_3e ; $4f40
	add l ; $4f43
	ld l, a ; $4f44
	jr nc, .read ; $4f45
	inc h ; $4f47
.read:
	ld a, [hl+] ; $4f48
	ld h, [hl] ; $4f49
	ld l, a ; $4f4a
	push af ; $4f4b
	push bc ; $4f4c
	push de ; $4f4d
	push hl ; $4f4e
	ld de, wDecompBuffer ; $4f4f
	call DecompressDataFromBank ; $4f52
	pop hl ; $4f55
	pop de ; $4f56
	pop bc ; $4f57
	pop af ; $4f58
	ld hl, RacketShoesChoiceGfxDests_3e ; $4f59
	ld a, c ; $4f5c
	add a ; $4f5d
	add l ; $4f5e
	ld l, a ; $4f5f
	jr nc, .readB ; $4f60
	inc h ; $4f62
.readB:
	ld a, [hl+] ; $4f63
	ld d, [hl] ; $4f64
	ld e, a ; $4f65
	ld hl, wDecompBuffer ; $4f66
	push af ; $4f69
	push bc ; $4f6a
	push de ; $4f6b
	push hl ; $4f6c
	ld bc, $0010 ; $4f6d
	call QueueVRAMCopy ; $4f70
	pop hl ; $4f73
	pop de ; $4f74
	pop bc ; $4f75
	pop af ; $4f76
	ld a, c ; $4f77
	inc a ; $4f78
	ld c, a ; $4f79
	call AdvanceFrame ; $4f7a
	ld a, c ; $4f7d
	cp $02 ; $4f7e
	jr nz, .loop ; $4f80
	ld b, TILEBLOCK_RacketShoesChoiceGfx0 ; $4f82
	ld c, RacketShoesChoiceGfx0_SIZE / 16 ; $4f84
	ld de, vTiles0 + VRAM_BANK1 ; $4f86
	farcall LoadCompressedTileBlock ; $4f89
	call AdvanceFrame ; $4f8c
	ld b, TILEBLOCK_RacketShoesChoiceGfx1 ; $4f8f
	ld c, RacketShoesChoiceGfx1_SIZE / 16 ; $4f91
	ld de, vTiles0 + $10 * TILE_SIZE + VRAM_BANK1 ; $4f93
	farcall LoadCompressedTileBlock ; $4f96
	call AdvanceFrame ; $4f99
	ld b, TILEBLOCK_SharedMenuGfx27 ; $4f9c
	ld c, SharedMenuGfx27_SIZE / 16 ; $4f9e
	ld de, vTiles0 + $70 * TILE_SIZE + VRAM_BANK1 ; $4fa0
	farcall LoadCompressedTileBlock ; $4fa3
	call AdvanceFrame ; $4fa6
	ld b, TILEBLOCK_RacketShoesChoiceGfx2 ; $4fa9
	ld c, RacketShoesChoiceGfx2_SIZE / 16 ; $4fab
	ld de, vTiles0 ; $4fad
	farcall LoadCompressedTileBlock ; $4fb0
	call AdvanceFrame ; $4fb3
	ld b, $08 ; $4fb6
	ld c, $10 ; $4fb8
	farcall LoadIndexedPalette ; $4fba
	pop_wram_bank ; $4fbd
	ret ; $4fc2
RacketShoesChoiceGfxParams_3e:
	; $4fc3, 3 slot words
	dslot DataPtr_MatchStatsLabelTiles0 ; record 0
	dslot DataPtr_MatchStatsLabelTiles1 ; record 1
	dslot DataPtr_N64ItemLabelTiles2 ; record 2
RacketShoesChoiceGfxDests_3e:
	; $4fc9, 6 bytes (bytes:6)
	db $00, $a8, $00, $a9, $00, $aa ; 0x00
RedrawRacketShoesChoiceMenu:
	wram_bank WRAM_SCREEN ; $4fcf
	ld b, $00 ; $4fd5
	ld c, $00 ; $4fd7
.loop:
	call SetChoiceTabAttrRect ; $4fd9
	ld a, b ; $4fdc
	inc a ; $4fdd
	ld b, a ; $4fde
	cp $03 ; $4fdf
	jr nz, .loop ; $4fe1
	ld c, $02 ; $4fe3
	call GetMenuCursorIndex_3e ; $4fe5
	ld b, a ; $4fe8
	ld c, $01 ; $4fe9
	call SetChoiceTabAttrRect ; $4feb
	ld c, $02 ; $4fee
	call GetMenuCursorIndex_3e ; $4ff0
	call SetRacketShoesChoicePalette ; $4ff3
	wram_bank WRAM_SCREEN ; $4ff6
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH ; $4ffc
	ld b, $14 ; $4fff
	ld c, $01 ; $5001
	ld h, $03 ; $5003
	farcall FillTilemapRect ; $5005
	ld a, $02 ; $5008
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH], a ; $500a
	ld a, $04 ; $500d
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH + 19], a ; $500f
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $5012
	ld b, $12 ; $5015
	ld c, $01 ; $5017
	ld h, $20 ; $5019
	farcall FillTilemapRect ; $501b
	call DrawRacketShoesChoiceCaption ; $501e
	ld hl, wShadowAttrmap + 7 * TILEMAP_WIDTH ; $5021
	ld de, vBGMap0 + 7 * TILEMAP_WIDTH + VRAM_BANK1 ; $5024
	ld c, $06 ; $5027
	call QueueVRAMCopy ; $5029
	ld hl, wShadowTilemap + 15 * TILEMAP_WIDTH ; $502c
	ld de, vBGMap0 + 15 * TILEMAP_WIDTH ; $502f
	ld c, $04 ; $5032
	call QueueVRAMCopy ; $5034
	ret ; $5037
SetRacketShoesChoicePalette:
	ld hl, RacketShoesChoicePalettePtrs ; $5038
	add a ; $503b
	add l ; $503c
	ld l, a ; $503d
	jr nc, .read ; $503e
	inc h ; $5040
.read:
	ld a, [hl+] ; $5041
	ld h, [hl] ; $5042
	ld l, a ; $5043
	lb de, $04, $01 ; $5044 palette index, count
	call LoadPaletteShadow ; $5047
	ret ; $504a
RacketShoesChoicePalettePtrs:
	; $504b, 18 bytes (records:2)
	dw RacketShoesChoicePalette0 ; record 0
	dw RacketShoesChoicePalette1 ; record 1
	dw RacketShoesChoicePalette0 ; record 2
	dw RacketShoesChoicePalette0 ; record 3
	dw RacketShoesChoicePalette0 ; record 4
	dw RacketShoesChoicePalette0 ; record 5
	dw RacketShoesChoicePalette0 ; record 6
	dw RacketShoesChoicePalette0 ; record 7
	dw RacketShoesChoicePalette0 ; record 8
RacketShoesChoicePalette0:
	; $505d, 8 bytes (bytes:8)
	db $df, $02, $ff, $7f, $a0, $01, $00, $00 ; 0x00
RacketShoesChoicePalette1:
	; $5065, 8 bytes (bytes:8)
	db $0a, $03, $ff, $7f, $40, $51, $00, $00 ; 0x00
DrawRacketShoesChoiceCaption:
	push_wram_bank WRAM_SCREEN ; $506d
	ld c, $02 ; $5076
	call GetMenuCursorIndex_3e ; $5078
	ld b, a ; $507b
	ld hl, $00e0 ; $507c
	add l ; $507f
	ld l, a ; $5080
	jr nc, .renderTextToBuffer64 ; $5081
	inc h ; $5083
.renderTextToBuffer64:
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $5084
	ld c, $20 ; $5087
	farcall RenderTextToBuffer64 ; $5089
	pop_wram_bank ; $508c
	ret ; $5091
