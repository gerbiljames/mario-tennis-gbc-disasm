LoadMatchResultPalettes:
	ld a, [wMatchWinLoseFlag] ; $4a0f
	cp WINLOSE_LOSE ; $4a12
	jr z, .eqff ; $4a14
	ld a, $02 ; $4a16
	ld [wAnimatedTileSet], a ; $4a18
	ld hl, MatchResultPalettes1 ; $4a1b
	ld_bg_pals de, 1, 1 ; $4a1e
	call LoadPaletteShadow ; $4a21
	ld hl, MatchResultPalettes0 ; $4a24
	ld_bg_pals de, 2, 1 ; $4a27
	call LoadPaletteShadow ; $4a2a
	ret ; $4a2d
.eqff:
	ld a, $03 ; $4a2e
	ld [wAnimatedTileSet], a ; $4a30
	ld hl, MatchResultPalettes1 ; $4a33
	ld_bg_pals de, 2, 1 ; $4a36
	call LoadPaletteShadow ; $4a39
	ld hl, MatchResultPalettes0 ; $4a3c
	ld_bg_pals de, 1, 1 ; $4a3f
	call LoadPaletteShadow ; $4a42
	ret ; $4a45
MatchResultPalettes0:
	INCLUDE "data/bank_016/MatchResultPalettes0.asm" ; $4a46, 8 bytes (palettes)
MatchResultPalettes1:
	INCLUDE "data/bank_016/MatchResultPalettes1.asm" ; $4a4e, 8 bytes (palettes)
AdjustResultTilemapForLoss:
	ld a, [wMatchWinLoseFlag] ; $4a56
	cp WINLOSE_LOSE ; $4a59
	jr nz, .done ; $4a5b
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH ; $4a5d
	ld de, wShadowTilemap + 9 * TILEMAP_WIDTH ; $4a60
	ld b, $20 ; $4a63
	ld c, $02 ; $4a65
	farcall CopyTilemapRect ; $4a67
	ld a, $06 ; $4a6a
	ld [wAnimatedTilePeriod], a ; $4a6c
.done:
	ret ; $4a6f
Unused_16_StubNop:
	ret ; $4a70
Unused_16_BuildMatchResultTilemap:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $4a71
	add a ; $4a74
	ld hl, MatchResultTilemapScripts_16 ; $4a75
	add l ; $4a78
	ld l, a ; $4a79
	jr nc, .read ; $4a7a
	inc h ; $4a7c
.read:
	ld a, [hl+] ; $4a7d
	ld h, [hl] ; $4a7e
	ld l, a ; $4a7f
.loop:
	ld a, [hl+] ; $4a80
	ld d, [hl] ; $4a81
	ld e, a ; $4a82
	ld a, d ; $4a83
	or e ; $4a84
	jr z, .checkCurrentMinigameStoryMatch ; $4a85
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
.checkCurrentMinigameStoryMatch:
	ld a, [wCurrentMinigameStoryMatch] ; $4a99
	cp MATCHLIST_DOUBLES ; $4a9c
	jr nz, .ne01 ; $4a9e
	ld hl, $d3c7 ; $4aa0
	ld de, $d200 ; $4aa3
	ld b, $06 ; $4aa6
	ld c, $02 ; $4aa8
	farcall CopyTilemapRect ; $4aaa
	jr .done ; $4aad
.ne01:
	ld hl, $d3c0 ; $4aaf
	ld de, $d200 ; $4ab2
	ld b, $07 ; $4ab5
	ld c, $02 ; $4ab7
	farcall CopyTilemapRect ; $4ab9
.done:
	ret ; $4abc
MatchResultTilemapScripts_16:
	; $4abd, 480 bytes (tilemap_scripts)
	dw .script0 ; 0
	dw .script1 ; 1
	dw .script2 ; 2
	dw .script3 ; 3
	dw .script4 ; 4
	dw .script5 ; 5
	dw .script6 ; 6
	dw .script7 ; 7
	dw .script8 ; 8
	dw .script9 ; 9
	dw .script10 ; 10
	dw .script11 ; 11
	dw .script12 ; 12
	dw .script13 ; 13
	dw .script14 ; 14
	dw .script15 ; 15
	dw .script16 ; 16
	dw .script17 ; 17
	dw .script18 ; 18
	dw .script19 ; 19
.script0:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2ca, 9
	tilemap_copy $d20a, $d3cd, 9
	tilemap_copy_end
.script1:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2ca, 9
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d393, 4
	tilemap_copy_end
.script2:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2ca, 9
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d38f, 4
	tilemap_copy_end
.script3:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2ca, 9
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d38b, 4
	tilemap_copy_end
.script4:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2ca, 9
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d388, 3
	tilemap_copy_end
.script5:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2d3, 8
	tilemap_copy $d20a, $d3cd, 9
	tilemap_copy_end
.script6:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2d3, 8
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d393, 4
	tilemap_copy_end
.script7:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2d3, 8
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d38f, 4
	tilemap_copy_end
.script8:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2d3, 8
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d38b, 4
	tilemap_copy_end
.script9:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2d3, 8
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d388, 3
	tilemap_copy_end
.script10:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00a, $d300, 10
	tilemap_copy $d20a, $d3cd, 9
	tilemap_copy_end
.script11:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00a, $d300, 10
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d393, 4
	tilemap_copy_end
.script12:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00a, $d300, 10
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d38f, 4
	tilemap_copy_end
.script13:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00a, $d300, 10
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d38b, 4
	tilemap_copy_end
.script14:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00a, $d300, 10
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d388, 3
	tilemap_copy_end
.script15:
	tilemap_copy $d000, $d280, 20
	tilemap_copy $d20a, $d3cd, 9
	tilemap_copy_end
.script16:
	tilemap_copy $d000, $d280, 20
	tilemap_copy $d20a, $d340, 7
	tilemap_copy_end
.script17:
	tilemap_copy $d000, $d280, 20
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d20a, $d347, 8
	tilemap_copy_end
.script18:
	tilemap_copy $d000, $d280, 20
	tilemap_copy $d209, $d34f, 10
	tilemap_copy_end
.script19:
	tilemap_copy $d000, $d280, 20
	tilemap_copy $d20c, $d359, 7
	tilemap_copy_end
AdvanceResultScreenTimer:
	ld a, [wMatchWinLoseFlag] ; $4c9d
	cp WINLOSE_LOSE ; $4ca0
	jr nz, .neff ; $4ca2
	ldh a, [hVBlankCounter] ; $4ca4
	and $01 ; $4ca6
	ret z ; $4ca8
.neff:
	ld a, [wRasterScrollX] ; $4ca9
	inc a ; $4cac
	ld [wRasterScrollX], a ; $4cad
	ret ; $4cb0
QueueResultScreenSprites:
	ld a, [wMatchWinLoseFlag] ; $4cb1
	cp WINLOSE_LOSE ; $4cb4
	jr z, .eqff ; $4cb6
	ld de, $0824 ; $4cb8
	call QueueResultPortraitTop ; $4cbb
	ld de, $502c ; $4cbe
	call QueueWinnerMarkerForPlayer ; $4cc1
	ld de, $5060 ; $4cc4
	call QueueResultPortraitBottom ; $4cc7
	ld de, $4e68 ; $4cca
	call QueueLoserMarkerForOpponent ; $4ccd
	ret ; $4cd0
.eqff:
	ld de, $5860 ; $4cd1
	call QueueResultPortraitTop ; $4cd4
	ld de, $5068 ; $4cd7
	call QueueLoserMarkerForPlayer ; $4cda
	ld de, $0024 ; $4cdd
	call QueueResultPortraitBottom ; $4ce0
	ld de, $482c ; $4ce3
	call QueueWinnerMarkerForOpponent ; $4ce6
	ret ; $4ce9
QueueResultPortraitTop:
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
	ld b, $0a ; $4cfb
.maskClear:
	ld hl, ResultSpriteTemplateLeft_16 ; $4cfd
	call QueueSpriteTemplate ; $4d00
	ret ; $4d03
ResultSpriteTemplateLeft_16:
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
QueueResultPortraitBottom:
	call GetResultSpriteWobbleOffset ; $4d45
	add d ; $4d48
	ld d, a ; $4d49
	ld c, $20 ; $4d4a
	ld b, $09 ; $4d4c
	ld hl, ResultSpriteTemplateRight_16 ; $4d4e
	call QueueSpriteTemplate ; $4d51
	ret ; $4d54
ResultSpriteTemplateRight_16:
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
QueueWinnerMarkerForPlayer:
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
	ld b, $0a ; $4da7
.queueSprite:
	call QueueSprite ; $4da9
	ret ; $4dac
QueueLoserMarkerForOpponent:
	call GetResultSpriteWobbleOffset ; $4dad
	add d ; $4db0
	ld d, a ; $4db1
	ld c, $42 ; $4db2
	ld b, $09 ; $4db4
	call QueueSprite ; $4db6
	ret ; $4db9
QueueWinnerMarkerForOpponent:
	call GetResultSpriteWobbleOffset ; $4dba
	add d ; $4dbd
	ld d, a ; $4dbe
	ld c, $40 ; $4dbf
	ld b, $09 ; $4dc1
	call QueueSprite ; $4dc3
	ret ; $4dc6
QueueLoserMarkerForPlayer:
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
	ld b, $0a ; $4dd8
.queueSprite:
	call QueueSprite ; $4dda
	ret ; $4ddd
GetResultSpriteWobbleOffset:
	ldh a, [hVBlankCounter] ; $4dde
	srl a ; $4de0
	and $0f ; $4de2
	ld hl, ResultSpriteWobbleOffsetTable ; $4de4
	add l ; $4de7
	ld l, a ; $4de8
	jr nc, .read ; $4de9
	inc h ; $4deb
.read:
	ld a, [hl] ; $4dec
	ret ; $4ded
ResultSpriteWobbleOffsetTable:
	; $4dee, 16 bytes (bytes:16)
	db $00, $01, $02, $03, $04, $05, $06, $06, $06, $05, $04, $03, $02, $01, $00, $00 ; 0x00
LoadResultScreenTileGraphics:
	ld de, wShadowAttrmap ; $4dfe
	ld b, $14 ; $4e01
	ld c, $02 ; $4e03
	ld h, $0b ; $4e05
	farcall FillTilemapRect ; $4e07
	ld de, wShadowAttrmap + 16 * TILEMAP_WIDTH ; $4e0a
	ld b, $14 ; $4e0d
	ld c, $02 ; $4e0f
	ld h, $0b ; $4e11
	farcall FillTilemapRect ; $4e13
	ld de, FLAG_DOUBLES ; $4e16
	call TestGameFlagByNumber ; $4e19
	jr nz, .decompressData ; $4e1c
	ld hl, MatchResultTitleGfx ; $4e1e
	ld de, vTiles2 ; $4e21
	call DecompressData ; $4e24
	jr .loadMatchResultGfxSet ; $4e27
.decompressData:
	ld hl, MatchResultTitleGfxAlt ; $4e29
	ld de, vTiles2 ; $4e2c
	call DecompressData ; $4e2f
.loadMatchResultGfxSet:
	ld a, [wResultScreenWon] ; $4e32
	or a ; $4e35
	jr z, LoadMatchResultGfxSet ; $4e36
	ld hl, MatchResultGfxA2 ; $4e38
	ld de, vTiles1 + $10 * TILE_SIZE ; $4e3b
	call DecompressData ; $4e3e
	ld hl, MatchResultGfxB4 ; $4e41
	ld de, vTiles1 + $24 * TILE_SIZE ; $4e44
	call DecompressData ; $4e47
	ld hl, MatchResultGfxC9 ; $4e4a
	ld de, vTiles2 + $14 * TILE_SIZE ; $4e4d
	call DecompressData ; $4e50
	ret ; $4e53
LoadMatchResultGfxSet:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $4e54
	call RemapDoublesMatchGfxIndex ; $4e57
	add a ; $4e5a
	ld hl, GfxSetPointerTable_16 ; $4e5b
	add l ; $4e5e
	ld l, a ; $4e5f
	jr nc, .read ; $4e60
	inc h ; $4e62
.read:
	ld a, [hl+] ; $4e63
	ld h, [hl] ; $4e64
	ld l, a ; $4e65
	push hl ; $4e66
	ld a, [hl+] ; $4e67
	ld h, [hl] ; $4e68
	ld l, a ; $4e69
	ld de, vTiles1 + $10 * TILE_SIZE ; $4e6a
	call DecompressData ; $4e6d
	pop hl ; $4e70
	inc hl ; $4e71
	inc hl ; $4e72
	push hl ; $4e73
	ld a, [hl+] ; $4e74
	ld h, [hl] ; $4e75
	ld l, a ; $4e76
	ld de, vTiles1 + $24 * TILE_SIZE ; $4e77
	call DecompressData ; $4e7a
	pop hl ; $4e7d
	inc hl ; $4e7e
	inc hl ; $4e7f
	ld a, [hl+] ; $4e80
	ld h, [hl] ; $4e81
	ld l, a ; $4e82
	ld de, vTiles2 + $14 * TILE_SIZE ; $4e83
	call DecompressData ; $4e86
	ret ; $4e89
