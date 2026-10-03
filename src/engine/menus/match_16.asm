RemapDoublesMatchGfxIndex:
	push af ; $4e8a
	ld de, FLAG_DOUBLES ; $4e8b
	call TestGameFlagByNumber ; $4e8e
	jr z, .restore ; $4e91
	cp $11 ; $4e93
	jr nz, .restore ; $4e95
	ld a, $10 ; $4e97
	pop hl ; $4e99
	ret ; $4e9a
.restore:
	pop af ; $4e9b
	ret ; $4e9c
GfxSetPointerTable_16:
	; $4e9d, 176 bytes (gfx_ptr_table)
	dw .rec0 ; 0
	dw .rec1 ; 1
	dw .rec2 ; 2
	dw .rec3 ; 3
	dw .rec4 ; 4
	dw .rec5 ; 5
	dw .rec6 ; 6
	dw .rec7 ; 7
	dw .rec8 ; 8
	dw .rec9 ; 9
	dw .rec10 ; 10
	dw .rec11 ; 11
	dw .rec12 ; 12
	dw .rec13 ; 13
	dw .rec14 ; 14
	dw .rec15 ; 15
	dw .rec16 ; 16
	dw .rec17 ; 17
	dw .rec18 ; 18
	dw .rec19 ; 19
	dw .rec20 ; 20
	dw .rec20 ; 21
	dw .rec20 ; 22
	dw .rec20 ; 23
	dw .rec20 ; 24
.rec0:
	gfx_set MatchResultGfxA1, MatchResultGfxB3, MatchResultGfxC8
.rec1:
	gfx_set MatchResultGfxA1, MatchResultGfxB3, MatchResultGfxC7
.rec2:
	gfx_set MatchResultGfxA1, MatchResultGfxB3, MatchResultGfxC6
.rec3:
	gfx_set MatchResultGfxA1, MatchResultGfxB3, MatchResultGfxC5
.rec4:
	gfx_set MatchResultGfxA1, MatchResultGfxB3, MatchResultGfxC4
.rec5:
	gfx_set MatchResultGfxA1, MatchResultGfxB2, MatchResultGfxC8
.rec6:
	gfx_set MatchResultGfxA1, MatchResultGfxB2, MatchResultGfxC7
.rec7:
	gfx_set MatchResultGfxA1, MatchResultGfxB2, MatchResultGfxC6
.rec8:
	gfx_set MatchResultGfxA1, MatchResultGfxB2, MatchResultGfxC5
.rec9:
	gfx_set MatchResultGfxA1, MatchResultGfxB2, MatchResultGfxC4
.rec10:
	gfx_set MatchResultGfxA1, MatchResultGfxB1, MatchResultGfxC8
.rec11:
	gfx_set MatchResultGfxA1, MatchResultGfxB1, MatchResultGfxC7
.rec12:
	gfx_set MatchResultGfxA1, MatchResultGfxB1, MatchResultGfxC6
.rec13:
	gfx_set MatchResultGfxA1, MatchResultGfxB1, MatchResultGfxC5
.rec14:
	gfx_set MatchResultGfxA1, MatchResultGfxB1, MatchResultGfxC4
.rec15:
	gfx_set MatchResultGfxA0, MatchResultGfxB0, MatchResultGfxC8
.rec16:
	gfx_set MatchResultGfxA0, MatchResultGfxB0, MatchResultGfxC2
.rec17:
	gfx_set MatchResultGfxA0, MatchResultGfxB0, MatchResultGfxC3
.rec18:
	gfx_set MatchResultGfxA0, MatchResultGfxB0, MatchResultGfxC1
.rec19:
	gfx_set MatchResultGfxA0, MatchResultGfxB0, MatchResultGfxC0
.rec20:
	gfx_set MatchResultGfxA2, MatchResultGfxB4, MatchResultGfxC9
MatchResultGfxA0:
	INCBIN "data/bank_016/lz_MatchResultGfxA0.bin" ; $4f4d, 199 bytes
MatchResultGfxB0:
	INCBIN "data/bank_016/lz_MatchResultGfxB0.bin" ; $5014, 127 bytes
MatchResultGfxA1:
	INCBIN "data/bank_016/lz_MatchResultGfxA1.bin" ; $5093, 205 bytes
MatchResultGfxB1:
	INCBIN "data/bank_016/lz_MatchResultGfxB1.bin" ; $5160, 178 bytes
MatchResultGfxB2:
	INCBIN "data/bank_016/lz_MatchResultGfxB2.bin" ; $5212, 171 bytes
MatchResultGfxB3:
	INCBIN "data/bank_016/lz_MatchResultGfxB3.bin" ; $52bd, 154 bytes
MatchResultGfxA2:
	INCBIN "data/bank_016/lz_MatchResultGfxA2.bin" ; $5357, 106 bytes
MatchResultGfxB4:
	INCBIN "data/bank_016/lz_MatchResultGfxB4.bin" ; $53c1, 109 bytes
MatchResultTitleGfx:
	INCBIN "data/bank_016/lz_MatchResultTitleGfx.bin" ; $542e, 143 bytes
MatchResultTitleGfxAlt:
	INCBIN "data/bank_016/lz_MatchResultTitleGfxAlt.bin" ; $54bd, 132 bytes
MatchResultGfxC0:
	INCBIN "data/bank_016/lz_MatchResultGfxC0.bin" ; $5541, 93 bytes
MatchResultGfxC1:
	INCBIN "data/bank_016/lz_MatchResultGfxC1.bin" ; $559e, 164 bytes
MatchResultGfxC2:
	INCBIN "data/bank_016/lz_MatchResultGfxC2.bin" ; $5642, 176 bytes
MatchResultGfxC3:
	INCBIN "data/bank_016/lz_MatchResultGfxC3.bin" ; $56f2, 186 bytes
MatchResultGfxC4:
	INCBIN "data/bank_016/lz_MatchResultGfxC4.bin" ; $57ac, 161 bytes
MatchResultGfxC5:
	INCBIN "data/bank_016/lz_MatchResultGfxC5.bin" ; $584d, 173 bytes
MatchResultGfxC6:
	INCBIN "data/bank_016/lz_MatchResultGfxC6.bin" ; $58fa, 172 bytes
MatchResultGfxC7:
	INCBIN "data/bank_016/lz_MatchResultGfxC7.bin" ; $59a6, 169 bytes
MatchResultGfxC8:
	INCBIN "data/bank_016/lz_MatchResultGfxC8.bin" ; $5a4f, 192 bytes
MatchResultGfxCUnused:
	INCBIN "data/bank_016/lz_MatchResultGfxCUnused.bin" ; $5b0f, 230 bytes
MatchResultGfxC9:
	INCBIN "data/bank_016/lz_MatchResultGfxC9.bin" ; $5bf5, 28 bytes
ApplyLinkRoleToWinLoseFlag:
	ld a, [wGameMode] ; $5c11
	cp GAMEMODE_LINK_MATCH ; $5c14
	ret nz ; $5c16
	ld a, [wLinkMatchRole] ; $5c17
	cp LINKSTATE_MASTER ; $5c1a
	jr nz, .compare ; $5c1c
	ret ; $5c1e
.compare:
	cp $02 ; $5c1f
	jr nz, .done ; $5c21
	ld a, [wMatchWinLoseFlag] ; $5c23
	cp WINLOSE_LOSE ; $5c26
	jr z, .eqff ; $5c28
	ld a, WINLOSE_LOSE ; $5c2a
	jr .store ; $5c2c
.eqff:
	ld a, WINLOSE_WIN ; $5c2e
.store:
	ld [wMatchWinLoseFlag], a ; $5c30
	ret ; $5c33
.done:
	ret ; $5c34
RunMatchStatsScreen:
	call DisableLCDSafely ; $5c35
	farcall LoadMenuFontGfx ; $5c38
	wram_bank WRAM_SCREEN ; $5c3b
	ld a, $01 ; $5c41
	ld [wResultScreenMode], a ; $5c43
	call InitMatchStatsScreen ; $5c46
	call LoadMatchResultPalettes ; $5c49
	ld a, $01 ; $5c4c
	ld hl, UpdateResultScreenAnimatedTilesTask ; $5c4e
	call RegisterFrameTask ; $5c51
	call EnableLCD ; $5c54
	script_fade_in 16 ; $5c57
	call WaitFadeEnd ; $5c5c
.loop:
	call PrintMatchSetScores ; $5c5f
	ldh a, [hInputPressed] ; $5c62
	bit PADB_LEFT, a ; $5c64
	jr nz, .beginFadeOut ; $5c66
	bit 0, a ; $5c68
	jr nz, .beginFadeOut2 ; $5c6a
	bit 1, a ; $5c6c
	jr nz, .beginFadeOut2 ; $5c6e
	call AdvanceFrame ; $5c70
	jr .loop ; $5c73
.beginFadeOut:
	ld c, 64 ; $5c75
	call BeginFadeOut ; $5c77
	call WaitFadeEnd ; $5c7a
	xor a ; $5c7d
	ret ; $5c7e
.beginFadeOut2:
	ld c, 32 ; $5c7f
	call BeginFadeOut ; $5c81
	call WaitFadeEnd ; $5c84
	ld a, $ff ; $5c87
	ret ; $5c89
InitMatchStatsScreen:
	ld c, SCREENASSET_MatchStats3 ; $5c8a
	farcall LoadScreenAssetRecord ; $5c8c
	ld de, vTiles0 + VRAM_BANK1 ; $5c8f
	ld c, $00 ; $5c92
	ld b, $08 ; $5c94
	farcall InitNumberSpriteGfx ; $5c96
	ld a, $00 ; $5c99
	ld d, $04 ; $5c9b
	farcall LoadIndexedPalette_18 ; $5c9d
	ld a, $00 ; $5ca0
	ld d, $05 ; $5ca2
	farcall LoadIndexedPalette_18 ; $5ca4
	ld a, $00 ; $5ca7
	ld d, $06 ; $5ca9
	farcall LoadIndexedPalette_18 ; $5cab
	ld a, $00 ; $5cae
	ld d, $07 ; $5cb0
	farcall LoadIndexedPalette_18 ; $5cb2
	wram_bank WRAM_SCREEN ; $5cb5
	call CopyMatchStatsHeaderRects ; $5cbb
	call LoadResultScreenTileGraphics ; $5cbe
	ld de, wShadowAttrmap + 16 * TILEMAP_WIDTH ; $5cc1
	rect_size $14, $02 ; $5cc4
	ld h, $08 ; $5cc8
	farcall FillTilemapRect ; $5cca
	call SetMatchStatsPortraitPaletteAttrs ; $5ccd
	ld c, $01 ; $5cd0
	call LoadResultScreenPortraits ; $5cd2
	call PrintMatchStatistics ; $5cd5
	farcall QueueWram3MapToVRAM ; $5cd8
	ret ; $5cdb
SetMatchStatsPortraitPaletteAttrs:
	ld de, FLAG_DOUBLES ; $5cdc
	call TestGameFlagByNumber ; $5cdf
	jr z, .fillTilemapRect ; $5ce2
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 1 ; $5ce4
	rect_size $03, $03 ; $5ce7
	ld h, $0c ; $5ceb
	farcall FillTilemapRect ; $5ced
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 4 ; $5cf0
	rect_size $03, $03 ; $5cf3
	ld h, $0d ; $5cf7
	farcall FillTilemapRect ; $5cf9
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 13 ; $5cfc
	rect_size $03, $03 ; $5cff
	ld h, $0e ; $5d03
	farcall FillTilemapRect ; $5d05
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 16 ; $5d08
	rect_size $03, $03 ; $5d0b
	ld h, $0f ; $5d0f
	farcall FillTilemapRect ; $5d11
	jr .done ; $5d14
.fillTilemapRect:
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 2 ; $5d16
	rect_size $03, $03 ; $5d19
	ld h, $0c ; $5d1d
	farcall FillTilemapRect ; $5d1f
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 14 ; $5d22
	rect_size $03, $03 ; $5d25
	ld h, $0e ; $5d29
	farcall FillTilemapRect ; $5d2b
.done:
	ret ; $5d2e
PrintMatchStatistics:
	call ClearMatchStatsNumberArea ; $5d2f
	ld de, FLAG_DOUBLES ; $5d32
	call TestGameFlagByNumber ; $5d35
	jr z, .printSinglesMatchStats ; $5d38
	call PrintDoublesMatchStats ; $5d3a
	jr .done ; $5d3d
.printSinglesMatchStats:
	call PrintSinglesMatchStats ; $5d3f
.done:
	ret ; $5d42
PrintSinglesMatchStats:
	ld a, [wCharacter1ServiceAces] ; $5d43
	ld h, $00 ; $5d46
	ld l, a ; $5d48
	ld bc, wStatsPrintBuffer ; $5d49
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH + 3 ; $5d4c
	farcall PrintNumberRightAligned ; $5d4f
	ld a, [wCharacter1SmashAces] ; $5d52
	ld h, $00 ; $5d55
	ld l, a ; $5d57
	ld bc, wStatsPrintBuffer ; $5d58
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH + 3 ; $5d5b
	farcall PrintNumberRightAligned ; $5d5e
	ld a, [wCharacter1ReturnAces] ; $5d61
	ld h, $00 ; $5d64
	ld l, a ; $5d66
	ld bc, wStatsPrintBuffer ; $5d67
	ld de, wShadowTilemap + 13 * TILEMAP_WIDTH + 3 ; $5d6a
	farcall PrintNumberRightAligned ; $5d6d
	ld a, [wCharacter1LobShotWinners] ; $5d70
	ld h, $00 ; $5d73
	ld l, a ; $5d75
	ld bc, wStatsPrintBuffer ; $5d76
	ld de, wShadowTilemap + 14 * TILEMAP_WIDTH + 3 ; $5d79
	farcall PrintNumberRightAligned ; $5d7c
	ld a, [wCharacter1DropShotWinners] ; $5d7f
	ld h, $00 ; $5d82
	ld l, a ; $5d84
	ld bc, wStatsPrintBuffer ; $5d85
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH + 3 ; $5d88
	farcall PrintNumberRightAligned ; $5d8b
	ld a, [wCharacter1DoubleFaults] ; $5d8e
	ld h, $00 ; $5d91
	ld l, a ; $5d93
	ld bc, wStatsPrintBuffer ; $5d94
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 3 ; $5d97
	farcall PrintNumberRightAligned ; $5d9a
	ld a, [wCharacter2ServiceAces] ; $5d9d
	ld h, $00 ; $5da0
	ld l, a ; $5da2
	ld bc, wStatsPrintBuffer ; $5da3
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH + 16 ; $5da6
	farcall PrintNumberRightAligned ; $5da9
	ld a, [wCharacter2SmashAces] ; $5dac
	ld h, $00 ; $5daf
	ld l, a ; $5db1
	ld bc, wStatsPrintBuffer ; $5db2
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH + 16 ; $5db5
	farcall PrintNumberRightAligned ; $5db8
	ld a, [wCharacter2ReturnAces] ; $5dbb
	ld h, $00 ; $5dbe
	ld l, a ; $5dc0
	ld bc, wStatsPrintBuffer ; $5dc1
	ld de, wShadowTilemap + 13 * TILEMAP_WIDTH + 16 ; $5dc4
	farcall PrintNumberRightAligned ; $5dc7
	ld a, [wCharacter2LobShotWinners] ; $5dca
	ld h, $00 ; $5dcd
	ld l, a ; $5dcf
	ld bc, wStatsPrintBuffer ; $5dd0
	ld de, wShadowTilemap + 14 * TILEMAP_WIDTH + 16 ; $5dd3
	farcall PrintNumberRightAligned ; $5dd6
	ld a, [wCharacter2DropShotWinners] ; $5dd9
	ld h, $00 ; $5ddc
	ld l, a ; $5dde
	ld bc, wStatsPrintBuffer ; $5ddf
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH + 16 ; $5de2
	farcall PrintNumberRightAligned ; $5de5
	ld a, [wCharacter2DoubleFaults] ; $5de8
	ld h, $00 ; $5deb
	ld l, a ; $5ded
	ld bc, wStatsPrintBuffer ; $5dee
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 16 ; $5df1
	farcall PrintNumberRightAligned ; $5df4
	ret ; $5df7
PrintDoublesMatchStats:
	ld a, [wCharacter1ServiceAces] ; $5df8
	ld h, $00 ; $5dfb
	ld l, a ; $5dfd
	ld bc, wStatsPrintBuffer ; $5dfe
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH + 2 ; $5e01
	farcall PrintNumberRightAligned ; $5e04
	ld a, [wCharacter1SmashAces] ; $5e07
	ld h, $00 ; $5e0a
	ld l, a ; $5e0c
	ld bc, wStatsPrintBuffer ; $5e0d
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH + 2 ; $5e10
	farcall PrintNumberRightAligned ; $5e13
	ld a, [wCharacter1ReturnAces] ; $5e16
	ld h, $00 ; $5e19
	ld l, a ; $5e1b
	ld bc, wStatsPrintBuffer ; $5e1c
	ld de, wShadowTilemap + 13 * TILEMAP_WIDTH + 2 ; $5e1f
	farcall PrintNumberRightAligned ; $5e22
	ld a, [wCharacter1LobShotWinners] ; $5e25
	ld h, $00 ; $5e28
	ld l, a ; $5e2a
	ld bc, wStatsPrintBuffer ; $5e2b
	ld de, wShadowTilemap + 14 * TILEMAP_WIDTH + 2 ; $5e2e
	farcall PrintNumberRightAligned ; $5e31
	ld a, [wCharacter1DropShotWinners] ; $5e34
	ld h, $00 ; $5e37
	ld l, a ; $5e39
	ld bc, wStatsPrintBuffer ; $5e3a
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH + 2 ; $5e3d
	farcall PrintNumberRightAligned ; $5e40
	ld a, [wCharacter1DoubleFaults] ; $5e43
	ld h, $00 ; $5e46
	ld l, a ; $5e48
	ld bc, wStatsPrintBuffer ; $5e49
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 2 ; $5e4c
	farcall PrintNumberRightAligned ; $5e4f
	ld a, [wCharacter3ServiceAces] ; $5e52
	ld h, $00 ; $5e55
	ld l, a ; $5e57
	ld bc, wStatsPrintBuffer ; $5e58
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH + 5 ; $5e5b
	farcall PrintNumberRightAligned ; $5e5e
	ld a, [wCharacter3SmashAces] ; $5e61
	ld h, $00 ; $5e64
	ld l, a ; $5e66
	ld bc, wStatsPrintBuffer ; $5e67
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH + 5 ; $5e6a
	farcall PrintNumberRightAligned ; $5e6d
	ld a, [wCharacter3ReturnAces] ; $5e70
	ld h, $00 ; $5e73
	ld l, a ; $5e75
	ld bc, wStatsPrintBuffer ; $5e76
	ld de, wShadowTilemap + 13 * TILEMAP_WIDTH + 5 ; $5e79
	farcall PrintNumberRightAligned ; $5e7c
	ld a, [wCharacter3LobShotWinners] ; $5e7f
	ld h, $00 ; $5e82
	ld l, a ; $5e84
	ld bc, wStatsPrintBuffer ; $5e85
	ld de, wShadowTilemap + 14 * TILEMAP_WIDTH + 5 ; $5e88
	farcall PrintNumberRightAligned ; $5e8b
	ld a, [wCharacter3DropShotWinners] ; $5e8e
	ld h, $00 ; $5e91
	ld l, a ; $5e93
	ld bc, wStatsPrintBuffer ; $5e94
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH + 5 ; $5e97
	farcall PrintNumberRightAligned ; $5e9a
	ld a, [wCharacter3DoubleFaults] ; $5e9d
	ld h, $00 ; $5ea0
	ld l, a ; $5ea2
	ld bc, wStatsPrintBuffer ; $5ea3
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 5 ; $5ea6
	farcall PrintNumberRightAligned ; $5ea9
	ld a, [wCharacter2ServiceAces] ; $5eac
	ld h, $00 ; $5eaf
	ld l, a ; $5eb1
	ld bc, wStatsPrintBuffer ; $5eb2
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH + 15 ; $5eb5
	farcall PrintNumberRightAligned ; $5eb8
	ld a, [wCharacter2SmashAces] ; $5ebb
	ld h, $00 ; $5ebe
	ld l, a ; $5ec0
	ld bc, wStatsPrintBuffer ; $5ec1
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH + 15 ; $5ec4
	farcall PrintNumberRightAligned ; $5ec7
	ld a, [wCharacter2ReturnAces] ; $5eca
	ld h, $00 ; $5ecd
	ld l, a ; $5ecf
	ld bc, wStatsPrintBuffer ; $5ed0
	ld de, wShadowTilemap + 13 * TILEMAP_WIDTH + 15 ; $5ed3
	farcall PrintNumberRightAligned ; $5ed6
	ld a, [wCharacter2LobShotWinners] ; $5ed9
	ld h, $00 ; $5edc
	ld l, a ; $5ede
	ld bc, wStatsPrintBuffer ; $5edf
	ld de, wShadowTilemap + 14 * TILEMAP_WIDTH + 15 ; $5ee2
	farcall PrintNumberRightAligned ; $5ee5
	ld a, [wCharacter2DropShotWinners] ; $5ee8
	ld h, $00 ; $5eeb
	ld l, a ; $5eed
	ld bc, wStatsPrintBuffer ; $5eee
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH + 15 ; $5ef1
	farcall PrintNumberRightAligned ; $5ef4
	ld a, [wCharacter2DoubleFaults] ; $5ef7
	ld h, $00 ; $5efa
	ld l, a ; $5efc
	ld bc, wStatsPrintBuffer ; $5efd
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 15 ; $5f00
	farcall PrintNumberRightAligned ; $5f03
	ld a, [wCharacter4ServiceAces] ; $5f06
	ld h, $00 ; $5f09
	ld l, a ; $5f0b
	ld bc, wStatsPrintBuffer ; $5f0c
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH + 18 ; $5f0f
	farcall PrintNumberRightAligned ; $5f12
	ld a, [wCharacter4SmashAces] ; $5f15
	ld h, $00 ; $5f18
	ld l, a ; $5f1a
	ld bc, wStatsPrintBuffer ; $5f1b
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH + 18 ; $5f1e
	farcall PrintNumberRightAligned ; $5f21
	ld a, [wCharacter4ReturnAces] ; $5f24
	ld h, $00 ; $5f27
	ld l, a ; $5f29
	ld bc, wStatsPrintBuffer ; $5f2a
	ld de, wShadowTilemap + 13 * TILEMAP_WIDTH + 18 ; $5f2d
	farcall PrintNumberRightAligned ; $5f30
	ld a, [wCharacter4LobShotWinners] ; $5f33
	ld h, $00 ; $5f36
	ld l, a ; $5f38
	ld bc, wStatsPrintBuffer ; $5f39
	ld de, wShadowTilemap + 14 * TILEMAP_WIDTH + 18 ; $5f3c
	farcall PrintNumberRightAligned ; $5f3f
	ld a, [wCharacter4DropShotWinners] ; $5f42
	ld h, $00 ; $5f45
	ld l, a ; $5f47
	ld bc, wStatsPrintBuffer ; $5f48
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH + 18 ; $5f4b
	farcall PrintNumberRightAligned ; $5f4e
	ld a, [wCharacter4DoubleFaults] ; $5f51
	ld h, $00 ; $5f54
	ld l, a ; $5f56
	ld bc, wStatsPrintBuffer ; $5f57
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 18 ; $5f5a
	farcall PrintNumberRightAligned ; $5f5d
	ret ; $5f60
