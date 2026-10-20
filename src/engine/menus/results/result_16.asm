LoadMatchResultPalettes:
	ld a, [wMatchWinLoseFlag] ; $4a0f
	cp WINLOSE_LOSE ; $4a12
	jr z, .lost ; $4a14
	ld a, $02 ; $4a16
	ld [wAnimatedTileSet], a ; $4a18
	ld hl, MatchResultWinnerPalette ; $4a1b
	ld_bg_pals de, 1, 1 ; $4a1e
	call LoadPaletteShadow ; $4a21
	ld hl, MatchResultLoserPalette ; $4a24
	ld_bg_pals de, 2, 1 ; $4a27
	call LoadPaletteShadow ; $4a2a
	ret ; $4a2d
.lost:
	ld a, $03 ; $4a2e
	ld [wAnimatedTileSet], a ; $4a30
	ld hl, MatchResultWinnerPalette ; $4a33
	ld_bg_pals de, 2, 1 ; $4a36
	call LoadPaletteShadow ; $4a39
	ld hl, MatchResultLoserPalette ; $4a3c
	ld_bg_pals de, 1, 1 ; $4a3f
	call LoadPaletteShadow ; $4a42
	ret ; $4a45
MatchResultLoserPalette:
	INCLUDE "data/engine/menus/results/MatchResultLoserPalette.asm" ; $4a46, 8 bytes (palettes)
MatchResultWinnerPalette:
	INCLUDE "data/engine/menus/results/MatchResultWinnerPalette.asm" ; $4a4e, 8 bytes (palettes)
AdjustResultTilemapForLoss:
	ld a, [wMatchWinLoseFlag] ; $4a56
	cp WINLOSE_LOSE ; $4a59
	jr nz, .done ; $4a5b
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH ; $4a5d
	ld de, wShadowTilemap + 9 * TILEMAP_WIDTH ; $4a60
	rect_size $20, $02 ; $4a63
	farcall CopyTilemapRect ; $4a67
	ld a, $06 ; $4a6a
	ld [wAnimatedTilePeriod], a ; $4a6c
.done:
	ret ; $4a6f
Unused_16_StubNop:
	ret ; $4a70
Unused_16_BuildMatchResultTilemap:
	ld a, [wCurrentMatchIndex] ; $4a71
	add a ; $4a74
	ld hl, MatchResultTilemapScripts_16 ; $4a75
	add_hl_a ; $4a78
	ld a, [hl+] ; $4a7d
	ld h, [hl] ; $4a7e
	ld l, a ; $4a7f
.loop:
	ld a, [hl+] ; $4a80
	ld d, [hl] ; $4a81
	ld e, a ; $4a82
	ld a, d ; $4a83
	or e ; $4a84
	jr z, .checkCurrentMatchList ; $4a85
	inc hl ; $4a87
	ld a, [hl+] ; $4a88
	ld b, [hl] ; $4a89
	ld c, a ; $4a8a
	inc hl ; $4a8b
	ld a, [hl+] ; $4a8c
	push hl ; $4a8d
	ld h, b ; $4a8e
	ld l, c ; $4a8f
	ld b, a ; $4a90
	ld c, $02 ; $4a91
	farcall CopyTilemapRect ; $4a93
	pop hl ; $4a96
	jr .loop ; $4a97
.checkCurrentMatchList:
	ld a, [wCurrentMatchList] ; $4a99
	cp MATCHLIST_DOUBLES ; $4a9c
	jr nz, .singles ; $4a9e
	ld hl, wShadowTilemap + 30 * TILEMAP_WIDTH + 7 ; $4aa0
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH ; $4aa3
	rect_size $06, $02 ; $4aa6
	farcall CopyTilemapRect ; $4aaa
	jr .done ; $4aad
.singles:
	ld hl, wShadowTilemap + 30 * TILEMAP_WIDTH ; $4aaf
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH ; $4ab2
	rect_size $07, $02 ; $4ab5
	farcall CopyTilemapRect ; $4ab9
.done:
	ret ; $4abc
MatchResultTilemapScripts_16:
	; $4abd, 480 bytes (tilemap_scripts)
	dw .juniorPractice ; 0
	dw .junior4 ; 1
	dw .junior3 ; 2
	dw .junior2 ; 3
	dw .junior1 ; 4
	dw .seniorPractice ; 5
	dw .senior4 ; 6
	dw .senior3 ; 7
	dw .senior2 ; 8
	dw .senior1 ; 9
	dw .varsityPractice ; 10
	dw .varsity4 ; 11
	dw .varsity3 ; 12
	dw .varsity2 ; 13
	dw .varsity1 ; 14
	dw .islandOpenPractice ; 15
	dw .islandOpenRound1 ; 16
	dw .islandOpenRound2 ; 17
	dw .islandOpenSemifinal ; 18
	dw .islandOpenFinal ; 19
.juniorPractice:
	result_copy 0, 0, 0, 22, 10
	result_copy 11, 0, 10, 22, 9
	result_copy 10, 16, 13, 30, 9
	tilemap_copy_end
.junior4:
	result_copy 0, 0, 0, 22, 10
	result_copy 11, 0, 10, 22, 9
	result_copy 9, 16, 0, 28, 7
	result_copy 16, 16, 19, 28, 4
	tilemap_copy_end
.junior3:
	result_copy 0, 0, 0, 22, 10
	result_copy 11, 0, 10, 22, 9
	result_copy 9, 16, 0, 28, 7
	result_copy 16, 16, 15, 28, 4
	tilemap_copy_end
.junior2:
	result_copy 0, 0, 0, 22, 10
	result_copy 11, 0, 10, 22, 9
	result_copy 9, 16, 0, 28, 7
	result_copy 16, 16, 11, 28, 4
	tilemap_copy_end
.junior1:
	result_copy 0, 0, 0, 22, 10
	result_copy 11, 0, 10, 22, 9
	result_copy 9, 16, 0, 28, 7
	result_copy 16, 16, 8, 28, 3
	tilemap_copy_end
.seniorPractice:
	result_copy 0, 0, 0, 22, 10
	result_copy 11, 0, 19, 22, 8
	result_copy 10, 16, 13, 30, 9
	tilemap_copy_end
.senior4:
	result_copy 0, 0, 0, 22, 10
	result_copy 11, 0, 19, 22, 8
	result_copy 9, 16, 0, 28, 7
	result_copy 16, 16, 19, 28, 4
	tilemap_copy_end
.senior3:
	result_copy 0, 0, 0, 22, 10
	result_copy 11, 0, 19, 22, 8
	result_copy 9, 16, 0, 28, 7
	result_copy 16, 16, 15, 28, 4
	tilemap_copy_end
.senior2:
	result_copy 0, 0, 0, 22, 10
	result_copy 11, 0, 19, 22, 8
	result_copy 9, 16, 0, 28, 7
	result_copy 16, 16, 11, 28, 4
	tilemap_copy_end
.senior1:
	result_copy 0, 0, 0, 22, 10
	result_copy 11, 0, 19, 22, 8
	result_copy 9, 16, 0, 28, 7
	result_copy 16, 16, 8, 28, 3
	tilemap_copy_end
.varsityPractice:
	result_copy 0, 0, 0, 22, 10
	result_copy 10, 0, 0, 24, 10
	result_copy 10, 16, 13, 30, 9
	tilemap_copy_end
.varsity4:
	result_copy 0, 0, 0, 22, 10
	result_copy 10, 0, 0, 24, 10
	result_copy 9, 16, 0, 28, 7
	result_copy 16, 16, 19, 28, 4
	tilemap_copy_end
.varsity3:
	result_copy 0, 0, 0, 22, 10
	result_copy 10, 0, 0, 24, 10
	result_copy 9, 16, 0, 28, 7
	result_copy 16, 16, 15, 28, 4
	tilemap_copy_end
.varsity2:
	result_copy 0, 0, 0, 22, 10
	result_copy 10, 0, 0, 24, 10
	result_copy 9, 16, 0, 28, 7
	result_copy 16, 16, 11, 28, 4
	tilemap_copy_end
.varsity1:
	result_copy 0, 0, 0, 22, 10
	result_copy 10, 0, 0, 24, 10
	result_copy 9, 16, 0, 28, 7
	result_copy 16, 16, 8, 28, 3
	tilemap_copy_end
.islandOpenPractice:
	result_copy 0, 0, 0, 20, 20
	result_copy 10, 16, 13, 30, 9
	tilemap_copy_end
.islandOpenRound1:
	result_copy 0, 0, 0, 20, 20
	result_copy 10, 16, 0, 26, 7
	tilemap_copy_end
.islandOpenRound2:
	result_copy 0, 0, 0, 20, 20
	result_copy 9, 16, 0, 28, 7
	result_copy 10, 16, 7, 26, 8
	tilemap_copy_end
.islandOpenSemifinal:
	result_copy 0, 0, 0, 20, 20
	result_copy 9, 16, 15, 26, 10
	tilemap_copy_end
.islandOpenFinal:
	result_copy 0, 0, 0, 20, 20
	result_copy 12, 16, 25, 26, 7
	tilemap_copy_end
AdvanceResultScreenTimer:
	ld a, [wMatchWinLoseFlag] ; $4c9d
	cp WINLOSE_LOSE ; $4ca0
	jr nz, .scroll ; $4ca2
	ldh a, [hVBlankCounter] ; $4ca4
	and $01 ; $4ca6
	ret z ; $4ca8
.scroll:
	ld a, [wRasterScrollX] ; $4ca9
	inc a ; $4cac
	ld [wRasterScrollX], a ; $4cad
	ret ; $4cb0
QueueResultScreenSprites:
	ld a, [wMatchWinLoseFlag] ; $4cb1
	cp WINLOSE_LOSE ; $4cb4
	jr z, .lost ; $4cb6
	ld de, $0824 ; $4cb8
	call QueueWinTextSprite ; $4cbb
	ld de, $502c ; $4cbe
	call QueueWinArrowRight ; $4cc1
	ld de, $5060 ; $4cc4
	call QueueLoseTextSprite ; $4cc7
	ld de, $4e68 ; $4cca
	call QueueLoseArrowLeft ; $4ccd
	ret ; $4cd0
.lost:
	ld de, $5860 ; $4cd1
	call QueueWinTextSprite ; $4cd4
	ld de, $5068 ; $4cd7
	call QueueWinArrowLeft ; $4cda
	ld de, $0024 ; $4cdd
	call QueueLoseTextSprite ; $4ce0
	ld de, $482c ; $4ce3
	call QueueLoseArrowRight ; $4ce6
	ret ; $4ce9
QueueWinTextSprite:
	call GetResultSpriteWobbleOffset ; $4cea
	ld b, a ; $4ced
	ld a, d ; $4cee
	sub b ; $4cef
	ld d, a ; $4cf0
	ld c, $00 ; $4cf1
	ld b, $08 ; $4cf3
	ldh a, [hVBlankCounter] ; $4cf5
	and $10 ; $4cf7
	jr z, .maskClear ; $4cf9
	ld b, OAM_BANK1 | 2 ; $4cfb
.maskClear:
	ld hl, WinTextSpriteTemplate_16 ; $4cfd
	call QueueSpriteTemplate ; $4d00
	ret ; $4d03
WinTextSpriteTemplate_16:
	; $4d04, 65 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite $10, $28, $10, $00
	oam_sprite $20, $28, $12, $00
	oam_sprite $10, $30, $14, $00
	oam_sprite $20, $30, $16, $00
	oam_sprite $10, $38, $18, $00
	oam_sprite $20, $38, $1a, $00
	oam_sprite $10, $40, $1c, $00
	oam_sprite $20, $40, $1e, $00
	oam_sprite_end
QueueLoseTextSprite:
	call GetResultSpriteWobbleOffset ; $4d45
	add d ; $4d48
	ld d, a ; $4d49
	sprite_tile_attr $20, OAM_BANK1 | 1 ; $4d4a
	ld hl, LoseTextSpriteTemplate_16 ; $4d4e
	call QueueSpriteTemplate ; $4d51
	ret ; $4d54
LoseTextSpriteTemplate_16:
	; $4d55, 65 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite $10, $28, $10, $00
	oam_sprite $20, $28, $12, $00
	oam_sprite $10, $30, $14, $00
	oam_sprite $20, $30, $16, $00
	oam_sprite $10, $38, $18, $00
	oam_sprite $20, $38, $1a, $00
	oam_sprite $10, $40, $1c, $00
	oam_sprite $20, $40, $1e, $00
	oam_sprite_end
QueueWinArrowRight:
	call GetResultSpriteWobbleOffset ; $4d96
	ld b, a ; $4d99
	ld a, d ; $4d9a
	sub b ; $4d9b
	ld d, a ; $4d9c
	ld c, $40 ; $4d9d
	ld b, $08 ; $4d9f
	ldh a, [hVBlankCounter] ; $4da1
	and $10 ; $4da3
	jr z, .queueSprite ; $4da5
	ld b, OAM_BANK1 | 2 ; $4da7
.queueSprite:
	call QueueSprite ; $4da9
	ret ; $4dac
QueueLoseArrowLeft:
	call GetResultSpriteWobbleOffset ; $4dad
	add d ; $4db0
	ld d, a ; $4db1
	sprite_tile_attr $42, OAM_BANK1 | 1 ; $4db2
	call QueueSprite ; $4db6
	ret ; $4db9
QueueLoseArrowRight:
	call GetResultSpriteWobbleOffset ; $4dba
	add d ; $4dbd
	ld d, a ; $4dbe
	sprite_tile_attr $40, OAM_BANK1 | 1 ; $4dbf
	call QueueSprite ; $4dc3
	ret ; $4dc6
QueueWinArrowLeft:
	call GetResultSpriteWobbleOffset ; $4dc7
	ld b, a ; $4dca
	ld a, d ; $4dcb
	sub b ; $4dcc
	ld d, a ; $4dcd
	ld c, $42 ; $4dce
	ld b, $08 ; $4dd0
	ldh a, [hVBlankCounter] ; $4dd2
	and $10 ; $4dd4
	jr z, .queueSprite ; $4dd6
	ld b, OAM_BANK1 | 2 ; $4dd8
.queueSprite:
	call QueueSprite ; $4dda
	ret ; $4ddd
GetResultSpriteWobbleOffset:
	ldh a, [hVBlankCounter] ; $4dde
	srl a ; $4de0
	and $0f ; $4de2
	ld hl, ResultSpriteWobbleOffsetTable ; $4de4
	add_hl_a ; $4de7
	ld a, [hl] ; $4dec
	ret ; $4ded
ResultSpriteWobbleOffsetTable:
	; $4dee, 16 bytes (bytes:16)
	db $00, $01, $02, $03, $04, $05, $06, $06, $06, $05, $04, $03, $02, $01, $00, $00 ; 0x00
LoadResultScreenTileGraphics:
	ld de, wShadowAttrmap ; $4dfe
	rect_size $14, $02 ; $4e01
	ld h, $0b ; $4e05
	farcall FillTilemapRect ; $4e07
	ld de, wShadowAttrmap + 16 * TILEMAP_WIDTH ; $4e0a
	rect_size $14, $02 ; $4e0d
	ld h, $0b ; $4e11
	farcall FillTilemapRect ; $4e13
	ld de, FLAG_DOUBLES ; $4e16
	call TestGameFlagByNumber ; $4e19
	jr nz, .doubles ; $4e1c
	ld hl, SinglesResultTitleGfx ; $4e1e
	ld de, vTiles2 ; $4e21
	call DecompressData ; $4e24
	jr .loadMatchResultGfxSet ; $4e27
.doubles:
	ld hl, DoublesResultTitleGfx ; $4e29
	ld de, vTiles2 ; $4e2c
	call DecompressData ; $4e2f
.loadMatchResultGfxSet:
	ld a, [wResultScreenIsVersus] ; $4e32
	or a ; $4e35
	jr z, LoadMatchResultGfxSet ; $4e36
	ld hl, ResultExhibitionBannerHeadGfx ; $4e38
	ld de, vTiles1 tile $10 ; $4e3b
	call DecompressData ; $4e3e
	ld hl, ResultExhibitionBannerTailGfx ; $4e41
	ld de, vTiles1 tile $24 ; $4e44
	call DecompressData ; $4e47
	ld hl, ResultBlankLabelGfx ; $4e4a
	ld de, vTiles2 tile $14 ; $4e4d
	call DecompressData ; $4e50
	ret ; $4e53
LoadMatchResultGfxSet:
	ld a, [wCurrentMatchIndex] ; $4e54
	call RemapDoublesMatchGfxIndex ; $4e57
	add a ; $4e5a
	ld hl, MatchResultBannerSetTable ; $4e5b
	add_hl_a ; $4e5e
	ld a, [hl+] ; $4e63
	ld h, [hl] ; $4e64
	ld l, a ; $4e65
	push hl ; $4e66
	ld a, [hl+] ; $4e67
	ld h, [hl] ; $4e68
	ld l, a ; $4e69
	ld de, vTiles1 tile $10 ; $4e6a
	call DecompressData ; $4e6d
	pop hl ; $4e70
	inc hl ; $4e71
	inc hl ; $4e72
	push hl ; $4e73
	ld a, [hl+] ; $4e74
	ld h, [hl] ; $4e75
	ld l, a ; $4e76
	ld de, vTiles1 tile $24 ; $4e77
	call DecompressData ; $4e7a
	pop hl ; $4e7d
	inc hl ; $4e7e
	inc hl ; $4e7f
	ld a, [hl+] ; $4e80
	ld h, [hl] ; $4e81
	ld l, a ; $4e82
	ld de, vTiles2 tile $14 ; $4e83
	call DecompressData ; $4e86
	ret ; $4e89
