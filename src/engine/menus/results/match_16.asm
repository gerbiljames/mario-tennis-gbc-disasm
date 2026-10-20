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
MatchResultBannerSetTable:
	; $4e9d, 176 bytes (gfx_ptr_table)
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
	dw .dreamMatches ; 20
	dw .dreamMatches ; 21
	dw .dreamMatches ; 22
	dw .dreamMatches ; 23
	dw .dreamMatches ; 24
.juniorPractice:
	gfx_set ResultTennisAcademyBannerGfx, ResultJuniorTeamBannerGfx, ResultPracticeMatchLabelGfx
.junior4:
	gfx_set ResultTennisAcademyBannerGfx, ResultJuniorTeamBannerGfx, ResultRanking4LabelGfx
.junior3:
	gfx_set ResultTennisAcademyBannerGfx, ResultJuniorTeamBannerGfx, ResultRanking3LabelGfx
.junior2:
	gfx_set ResultTennisAcademyBannerGfx, ResultJuniorTeamBannerGfx, ResultRanking2LabelGfx
.junior1:
	gfx_set ResultTennisAcademyBannerGfx, ResultJuniorTeamBannerGfx, ResultRanking1LabelGfx
.seniorPractice:
	gfx_set ResultTennisAcademyBannerGfx, ResultSeniorTeamBannerGfx, ResultPracticeMatchLabelGfx
.senior4:
	gfx_set ResultTennisAcademyBannerGfx, ResultSeniorTeamBannerGfx, ResultRanking4LabelGfx
.senior3:
	gfx_set ResultTennisAcademyBannerGfx, ResultSeniorTeamBannerGfx, ResultRanking3LabelGfx
.senior2:
	gfx_set ResultTennisAcademyBannerGfx, ResultSeniorTeamBannerGfx, ResultRanking2LabelGfx
.senior1:
	gfx_set ResultTennisAcademyBannerGfx, ResultSeniorTeamBannerGfx, ResultRanking1LabelGfx
.varsityPractice:
	gfx_set ResultTennisAcademyBannerGfx, ResultVarsityTeamBannerGfx, ResultPracticeMatchLabelGfx
.varsity4:
	gfx_set ResultTennisAcademyBannerGfx, ResultVarsityTeamBannerGfx, ResultRanking4LabelGfx
.varsity3:
	gfx_set ResultTennisAcademyBannerGfx, ResultVarsityTeamBannerGfx, ResultRanking3LabelGfx
.varsity2:
	gfx_set ResultTennisAcademyBannerGfx, ResultVarsityTeamBannerGfx, ResultRanking2LabelGfx
.varsity1:
	gfx_set ResultTennisAcademyBannerGfx, ResultVarsityTeamBannerGfx, ResultRanking1LabelGfx
.islandOpenPractice:
	gfx_set ResultIslandOpenBannerGfx, ResultTournamentBannerGfx, ResultPracticeMatchLabelGfx
.islandOpenRound1:
	gfx_set ResultIslandOpenBannerGfx, ResultTournamentBannerGfx, ResultFirstMatchLabelGfx
.islandOpenRound2:
	gfx_set ResultIslandOpenBannerGfx, ResultTournamentBannerGfx, ResultSecondMatchLabelGfx
.islandOpenSemifinal:
	gfx_set ResultIslandOpenBannerGfx, ResultTournamentBannerGfx, ResultSemifinalLabelGfx
.islandOpenFinal:
	gfx_set ResultIslandOpenBannerGfx, ResultTournamentBannerGfx, ResultFinalLabelGfx
.dreamMatches:
	gfx_set ResultExhibitionBannerHeadGfx, ResultExhibitionBannerTailGfx, ResultBlankLabelGfx
ResultIslandOpenBannerGfx:
	INCBIN "data/engine/menus/results/lz_ResultIslandOpenBannerGfx.bin" ; $4f4d, 199 bytes
ResultTournamentBannerGfx:
	INCBIN "data/engine/menus/results/lz_ResultTournamentBannerGfx.bin" ; $5014, 127 bytes
ResultTennisAcademyBannerGfx:
	INCBIN "data/engine/menus/results/lz_ResultTennisAcademyBannerGfx.bin" ; $5093, 205 bytes
ResultVarsityTeamBannerGfx:
	INCBIN "data/engine/menus/results/lz_ResultVarsityTeamBannerGfx.bin" ; $5160, 178 bytes
ResultSeniorTeamBannerGfx:
	INCBIN "data/engine/menus/results/lz_ResultSeniorTeamBannerGfx.bin" ; $5212, 171 bytes
ResultJuniorTeamBannerGfx:
	INCBIN "data/engine/menus/results/lz_ResultJuniorTeamBannerGfx.bin" ; $52bd, 154 bytes
ResultExhibitionBannerHeadGfx:
	INCBIN "data/engine/menus/results/lz_ResultExhibitionBannerHeadGfx.bin" ; $5357, 106 bytes
ResultExhibitionBannerTailGfx:
	INCBIN "data/engine/menus/results/lz_ResultExhibitionBannerTailGfx.bin" ; $53c1, 109 bytes
SinglesResultTitleGfx:
	INCBIN "data/engine/menus/results/lz_SinglesResultTitleGfx.bin" ; $542e, 143 bytes
DoublesResultTitleGfx:
	INCBIN "data/engine/menus/results/lz_DoublesResultTitleGfx.bin" ; $54bd, 132 bytes
ResultFinalLabelGfx:
	INCBIN "data/engine/menus/results/lz_ResultFinalLabelGfx.bin" ; $5541, 93 bytes
ResultSemifinalLabelGfx:
	INCBIN "data/engine/menus/results/lz_ResultSemifinalLabelGfx.bin" ; $559e, 164 bytes
ResultFirstMatchLabelGfx:
	INCBIN "data/engine/menus/results/lz_ResultFirstMatchLabelGfx.bin" ; $5642, 176 bytes
ResultSecondMatchLabelGfx:
	INCBIN "data/engine/menus/results/lz_ResultSecondMatchLabelGfx.bin" ; $56f2, 186 bytes
ResultRanking1LabelGfx:
	INCBIN "data/engine/menus/results/lz_ResultRanking1LabelGfx.bin" ; $57ac, 161 bytes
ResultRanking2LabelGfx:
	INCBIN "data/engine/menus/results/lz_ResultRanking2LabelGfx.bin" ; $584d, 173 bytes
ResultRanking3LabelGfx:
	INCBIN "data/engine/menus/results/lz_ResultRanking3LabelGfx.bin" ; $58fa, 172 bytes
ResultRanking4LabelGfx:
	INCBIN "data/engine/menus/results/lz_ResultRanking4LabelGfx.bin" ; $59a6, 169 bytes
ResultPracticeMatchLabelGfx:
	INCBIN "data/engine/menus/results/lz_ResultPracticeMatchLabelGfx.bin" ; $5a4f, 192 bytes
Unused_16_DoubleFaultsLabelGfx:
	INCBIN "data/engine/menus/results/lz_Unused_16_DoubleFaultsLabelGfx.bin" ; $5b0f, 230 bytes
ResultBlankLabelGfx:
	INCBIN "data/engine/menus/results/lz_ResultBlankLabelGfx.bin" ; $5bf5, 28 bytes
ApplyLinkRoleToWinLoseFlag:
	ld a, [wGameMode] ; $5c11
	cp GAMEMODE_LINK_MATCH ; $5c14
	ret nz ; $5c16
	ld a, [wLinkMatchRole] ; $5c17
	cp LINKSTATE_MASTER ; $5c1a
	jr nz, .compare ; $5c1c
	ret ; $5c1e
.compare:
	cp LINKSTATE_SLAVE ; $5c1f
	jr nz, .done ; $5c21
	ld a, [wMatchWinLoseFlag] ; $5c23
	cp WINLOSE_LOSE ; $5c26
	jr z, .toWin ; $5c28
	ld a, WINLOSE_LOSE ; $5c2a
	jr .store ; $5c2c
.toWin:
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
	frame_task UpdateResultScreenAnimatedTilesTask ; $5c4c
	call EnableLCD ; $5c54
	script_fade_in 16 ; $5c57
	call WaitFadeEnd ; $5c5c
.loop:
	call PrintMatchSetScores ; $5c5f
	ldh a, [hInputPressed] ; $5c62
	bit PADB_LEFT, a ; $5c64
	jr nz, .pressedLeft ; $5c66
	bit PADB_A, a ; $5c68
	jr nz, .pressedAOrB ; $5c6a
	bit PADB_B, a ; $5c6c
	jr nz, .pressedAOrB ; $5c6e
	call AdvanceFrame ; $5c70
	jr .loop ; $5c73
.pressedLeft:
	script_fade_out 64 ; $5c75
	call WaitFadeEnd ; $5c7a
	xor a ; $5c7d
	ret ; $5c7e
.pressedAOrB:
	script_fade_out 32 ; $5c7f
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
