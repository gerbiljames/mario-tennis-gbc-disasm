RecordReturnAceStat:
	ld a, [wReturnAceFlag] ; $5c6f
	and a ; $5c72
	ret z ; $5c73
	ld a, POINTWINNER_RETURN_ACE ; $5c74
	ld [wPointWinnerShotType], a ; $5c76
	ld hl, wCharacter1ReturnAces ; $5c79
	jp RecordDropShotWinnerStat.bumpStat ; $5c7c
RecordSmashAceStat:
	ld a, [wCurrentShotType] ; $5c7f
	cp SHOTTYPE_SMASH ; $5c82
	ret nz ; $5c84
	ld a, POINTWINNER_SMASH_ACE ; $5c85
	ld [wPointWinnerShotType], a ; $5c87
	ld hl, wCharacter1SmashAces ; $5c8a
	jp RecordDropShotWinnerStat.bumpStat ; $5c8d
RecordLobWinnerStat:
	ld a, [wCurrentShotType] ; $5c90
	cp SHOTTYPE_LOB ; $5c93
	ret nz ; $5c95
	ld a, POINTWINNER_LOB ; $5c96
	ld [wPointWinnerShotType], a ; $5c98
	ld hl, wCharacter1LobShotWinners ; $5c9b
	jp RecordDropShotWinnerStat.bumpStat ; $5c9e
RecordDropShotWinnerStat:
	ld a, [wCurrentShotType] ; $5ca1
	cp SHOTTYPE_DROP ; $5ca4
	ret nz ; $5ca6
	ld a, POINTWINNER_DROP_SHOT ; $5ca7
	ld [wPointWinnerShotType], a ; $5ca9
	ld hl, wCharacter1DropShotWinners ; $5cac
	jp .bumpStat ; $5caf
.bumpStat:
	ld a, [wLastShotCharIndex] ; $5cb2
	add a ; $5cb5
	add a ; $5cb6
	add a ; $5cb7
	add l ; $5cb8
	ld l, a ; $5cb9
	jr nc, .increment ; $5cba
	inc h ; $5cbc
.increment:
	ld a, [hl] ; $5cbd
	cp $63 ; $5cbe
	ret nc ; $5cc0
	inc [hl] ; $5cc1
	ret ; $5cc2
CheckMatchWon:
	ld a, [wMatchTypeNumberOfSets] ; $5cc3
	inc a ; $5cc6
	srl a ; $5cc7
	ld b, a ; $5cc9
	ld hl, wPlayer1SetsWon ; $5cca
	ld a, [hl+] ; $5ccd
	sub [hl] ; $5cce
	jr z, .undecided ; $5ccf
	bit 7, a ; $5cd1
	jr nz, .checkPlayer2 ; $5cd3
	ld a, [wPlayer1SetsWon] ; $5cd5
	cp b ; $5cd8
	jr c, .undecided ; $5cd9
	ld a, $01 ; $5cdb
	ret ; $5cdd
.checkPlayer2:
	ld a, [wPlayer2SetsWon] ; $5cde
	cp b ; $5ce1
	jr c, .undecided ; $5ce2
	ld a, $ff ; $5ce4
	ret ; $5ce6
.undecided:
	xor a ; $5ce7
	ret ; $5ce8
CheckSetWon:
	ld a, [wMatchTypeNumberOfGames] ; $5ce9
	cp $02 ; $5cec
	jp z, .checkTiebreak ; $5cee
	ld a, [wPlayer1GamesWon] ; $5cf1
	ld d, a ; $5cf4
	cp $07 ; $5cf5
	jr nz, .readPlayer2 ; $5cf7
	inc d ; $5cf9
.readPlayer2:
	ld a, [wPlayer2GamesWon] ; $5cfa
	ld e, a ; $5cfd
	cp $07 ; $5cfe
	jr nz, .winByTwo ; $5d00
	inc e ; $5d02
.winByTwo:
	ld b, $06 ; $5d03
	ld c, $06 ; $5d05
	call EvalWinByTwo ; $5d07
	cp $80 ; $5d0a
	ret nz ; $5d0c
	ld a, $01 ; $5d0d
	ld [wTiebreakerIndicator], a ; $5d0f
	xor a ; $5d12
	ret ; $5d13
.checkTiebreak:
	ld a, [wPlayer1GamesWon] ; $5d14
	ld d, a ; $5d17
	cp $03 ; $5d18
	jr nz, .setWon ; $5d1a
	inc d ; $5d1c
.setWon:
	ld a, [wPlayer2GamesWon] ; $5d1d
	ld e, a ; $5d20
	cp $03 ; $5d21
	jr nz, .done ; $5d23
	inc e ; $5d25
.done:
	ld b, $02 ; $5d26
	ld c, $02 ; $5d28
	call EvalWinByTwo ; $5d2a
	cp $80 ; $5d2d
	ret nz ; $5d2f
	ld a, $01 ; $5d30
	ld [wTiebreakerIndicator], a ; $5d32
	xor a ; $5d35
	ret ; $5d36
CheckGameWon:
	xor a ; $5d37
	ld [wDeuceIndicator], a ; $5d38
	ld b, $03 ; $5d3b
	ld c, $04 ; $5d3d
	ld a, [wPlayer1PointsWon] ; $5d3f
	ld d, a ; $5d42
	ld a, [wPlayer2PointsWon] ; $5d43
	ld e, a ; $5d46
	call EvalWinByTwo ; $5d47
	cp $80 ; $5d4a
	ret nz ; $5d4c
	ld a, $01 ; $5d4d
	ld [wDeuceIndicator], a ; $5d4f
	xor a ; $5d52
	ret ; $5d53
CheckTiebreakGameWon:
	xor a ; $5d54
	ld [wDeuceIndicator], a ; $5d55
	ld b, $06 ; $5d58
	ld c, $07 ; $5d5a
	ld a, [wPlayer1PointsWon] ; $5d5c
	ld d, a ; $5d5f
	ld a, [wPlayer2PointsWon] ; $5d60
	ld e, a ; $5d63
	call EvalWinByTwo ; $5d64
	cp $80 ; $5d67
	ret nz ; $5d69
	ld a, $01 ; $5d6a
	ld [wDeuceIndicator], a ; $5d6c
	xor a ; $5d6f
	ret ; $5d70
EvalWinByTwo:
	ld a, d ; $5d71
	sub e ; $5d72
	jr z, .checkTie ; $5d73
	bit 7, a ; $5d75
	jr nz, .negativeLead ; $5d77
	cp $02 ; $5d79
	jr c, .undecided ; $5d7b
	ld a, d ; $5d7d
	cp c ; $5d7e
	jr c, .undecided ; $5d7f
	ld a, $01 ; $5d81
	ret ; $5d83
.negativeLead:
	cpl ; $5d84
	inc a ; $5d85
	cp $02 ; $5d86
	jr c, .undecided ; $5d88
	ld a, e ; $5d8a
	cp c ; $5d8b
	jr c, .undecided ; $5d8c
	ld a, $ff ; $5d8e
	ret ; $5d90
.checkTie:
	ld a, e ; $5d91
	cp b ; $5d92
	jr nz, .undecided ; $5d93
	ld a, $80 ; $5d95
	ret ; $5d97
.undecided:
	xor a ; $5d98
	ret ; $5d99
ResolvePointWinner:
	ld a, [wPointOutcome] ; $5d9a
	cp POINTOUTCOME_FAULT ; $5d9d
	jr z, .noWinner ; $5d9f
	cp POINTOUTCOME_LET ; $5da1
	jr z, .noWinner ; $5da3
	cp POINTOUTCOME_BALL_HIT_PLAYER ; $5da5
	jr z, .fromToucher ; $5da7
	ld a, [wLastShotCharIndex] ; $5da9
	and $01 ; $5dac
	jr z, .sameSide ; $5dae
	ld a, [wPointOutcomeSide] ; $5db0
	cpl ; $5db3
	inc a ; $5db4
	ret ; $5db5
.sameSide:
	ld a, [wPointOutcomeSide] ; $5db6
	ret ; $5db9
.noWinner:
	xor a ; $5dba
	ret ; $5dbb
.fromToucher:
	ld a, [wBallTouchCharIndex] ; $5dbc
	and $01 ; $5dbf
	add a ; $5dc1
	dec a ; $5dc2
	ret ; $5dc3
CourtSceneDataTable:
	; $5dc4, 100 bytes (court_scene)
; court_scene friction, bounce, scene, unused
	court_scene $cd, $cd, SCENE_HARD_COURT, $21 ; $00 COURT_HARD
	court_scene $b3, $99, SCENE_CLAY_COURT, $22 ; $01 COURT_CLAY
	court_scene $e6, $99, SCENE_GRASS_COURT, $23 ; $02 COURT_GRASS (exhibition)
	court_scene $f0, $b3, SCENE_COMPOSITION_COURT, $20 ; $03 COURT_COMPOSITION
	court_scene $e6, $cd, SCENE_STAR_COURT, $11 ; $04 COURT_STAR
	court_scene $cd, $b3, SCENE_CASTLE_COURT, $12 ; $05 COURT_CASTLE
	court_scene $f0, $99, SCENE_TROPICS_COURT, $13 ; $06 COURT_TROPICS
	court_scene $e6, $e6, SCENE_JUNGLE_COURT, $16 ; $07 COURT_JUNGLE
	court_scene $b3, $cd, SCENE_WAREHOUSE_COURT, $14 ; $08 COURT_WAREHOUSE
	court_scene $cd, $b3, SCENE_TRAINING_COURT, $25 ; $09 COURT_TRAINING_PRACTICE
	court_scene $cd, $b3, SCENE_MACHINE_COURT, $1e ; $0a COURT_TENNIS_MACHINE
	court_scene $cd, $b3, SCENE_WALL_PRACTICE, $1f ; $0b COURT_WALL_PRACTICE
	court_scene $e6, $99, SCENE_CENTER_COURT, $28 ; $0c COURT_CENTER
	court_scene $e6, $99, SCENE_GRASS_COURT, $27 ; $0d COURT_GRASS_ISLAND_OPEN
	court_scene $cd, $b3, SCENE_MINIGAME_COURT, $29 ; $0e COURT_UNUSED_0E
	court_scene $cd, $b3, SCENE_TARGET_SHOT_COURT, $17 ; $0f Target Shot
	court_scene $e6, $cd, SCENE_STAR_COURT, $18 ; $10 Shooting Star
	court_scene $cd, $b3, SCENE_MINIGAME_COURT, $16 ; $11 Banana Bunch
	court_scene $e6, $cd, SCENE_STAR_COURT, $11 ; $12 Boo Blast
	court_scene $cd, $b3, SCENE_MINIGAME_COURT, $12 ; $13 Perfect Shot
	court_scene $b3, $cd, SCENE_WAREHOUSE_COURT, $14 ; $14 Treasure Box
	court_scene $b3, $cd, SCENE_WAREHOUSE_COURT, $19 ; $15 Medallion Match
	court_scene $cd, $b3, SCENE_MINIGAME_COURT, $13 ; $16 Fruit Fantasy
	court_scene $b3, $cd, SCENE_WAREHOUSE_COURT, $15 ; $17 Two-On-One
	court_scene $cd, $b3, SCENE_TRAINING_COURT, $24 ; $18 Training Court (match)
LoadCourtSceneData:
	ldh a, [hWramBank] ; $5e28
	push af ; $5e2a
	xor a ; $5e2b
	ldh [hScrollX], a ; $5e2c
	xor a ; $5e2e
	ldh [hScrollY], a ; $5e2f
	ld a, [wCurrentlyUsedCourt] ; $5e31
	add a ; $5e34
	add a ; $5e35
	ld_hl_indexed CourtSceneDataTable ; $5e36
	ld a, [hl+] ; $5e3d
	ld [wCourtSurfaceFriction], a ; $5e3e
	ld a, [hl+] ; $5e41
	ld [wCourtSurfaceBounce], a ; $5e42
	ld a, [hl+] ; $5e45
	farcall LoadCourtSceneGraphics ; $5e46
	call SnapshotCourtTilemaps ; $5e49
	pop_wram_bank ; $5e4c
	ret ; $5e51
SnapshotCourtTilemaps:
	wram_bank WRAM_COURT_PLANES ; $5e52
	ld hl, wCourtTilemapSaved ; $5e58
	ld de, wCourtTilemap ; $5e5b
	ld c, wCourtTilemap_SIZE / 16 ; $5e5e
	call CopyMemoryFast ; $5e60
	ld hl, wCourtAttrmapSaved ; $5e63
	ld de, wCourtAttrmap ; $5e66
	ld c, wCourtAttrmap_SIZE / 16 ; $5e69
	call CopyMemoryFast ; $5e6b
	ret ; $5e6e
UploadCourtTilemap:
	wram_bank WRAM_COURT_PLANES ; $5e6f
	ld hl, wCourtTilemap ; $5e75
	ld de, vBGMap0 ; $5e78
	ld c, $40 ; $5e7b
	call QueueVRAMCopy ; $5e7d
	ret ; $5e80
UploadCourtAttrmap:
	wram_bank WRAM_COURT_PLANES ; $5e81
	ld hl, wCourtAttrmap ; $5e87
	ld de, vBGMap0 + VRAM_BANK1 ; $5e8a
	ld c, $40 ; $5e8d
	call QueueVRAMCopy ; $5e8f
	ret ; $5e92
RefreshCourtScoreboard:
	ld a, [wCourtViewLocked] ; $5e93
	and $01 ; $5e96
	ret nz ; $5e98
	ld a, [wCourtViewFlipped] ; $5e99
	and a ; $5e9c
	jr nz, RefreshCourtScoreboardFlipped ; $5e9d
	ld hl, wScoreboardColumnTiles + 20 ; $5e9f
	ld de, wCourtTilemapSaved + 12 * TILEMAP_WIDTH + 26 ; $5ea2
	call CopyScoreboardTileColumn ; $5ea5
	ld hl, wScoreboardColumnAttrs + 20 ; $5ea8
	ld de, wCourtAttrmapSaved + 12 * TILEMAP_WIDTH + 26 ; $5eab
	call CopyScoreboardTileColumn ; $5eae
	ld hl, wScoreboardColumnTiles + 10 ; $5eb1
	ld de, wCourtTilemapSaved + 12 * TILEMAP_WIDTH + 4 ; $5eb4
	call CopyScoreboardTileColumn ; $5eb7
	ld hl, wScoreboardColumnAttrs + 10 ; $5eba
	ld de, wCourtAttrmapSaved + 12 * TILEMAP_WIDTH + 4 ; $5ebd
	call CopyScoreboardTileColumn ; $5ec0
	call SnapshotCourtTilemaps ; $5ec3
	ret ; $5ec6
RefreshCourtScoreboardFlipped:
	ld hl, wScoreboardColumnTiles ; $5ec7
	ld de, wCourtTilemapSaved + 12 * TILEMAP_WIDTH + 4 ; $5eca
	call CopyScoreboardTileColumn ; $5ecd
	ld hl, wScoreboardColumnAttrs ; $5ed0
	ld de, wCourtAttrmapSaved + 12 * TILEMAP_WIDTH + 4 ; $5ed3
	call CopyScoreboardTileColumn ; $5ed6
	ld hl, wScoreboardColumnTiles + 30 ; $5ed9
	ld de, wCourtTilemapSaved + 12 * TILEMAP_WIDTH + 26 ; $5edc
	call CopyScoreboardTileColumn ; $5edf
	ld hl, wScoreboardColumnAttrs + 30 ; $5ee2
	ld de, wCourtAttrmapSaved + 12 * TILEMAP_WIDTH + 26 ; $5ee5
	call CopyScoreboardTileColumn ; $5ee8
	call SnapshotCourtTilemaps ; $5eeb
	ret ; $5eee
CopyScoreboardTileColumn:
	wram_bank WRAM_ACTORS ; $5eef
	push de ; $5ef5
	ld de, wTextBuffer ; $5ef6
	ld c, $02 ; $5ef9
	call CopyMemoryFast ; $5efb
	pop de ; $5efe
	wram_bank WRAM_COURT_PLANES ; $5eff
	ld hl, wTextBuffer ; $5f05
	ld a, [hl+] ; $5f08
	ld [de], a ; $5f09
	inc de ; $5f0a
	ld a, [hl+] ; $5f0b
	ld [de], a ; $5f0c
	inc de ; $5f0d
	ld a, $1e ; $5f0e
	add e ; $5f10
	ld e, a ; $5f11
	jr nc, .row1 ; $5f12
	inc d ; $5f14
.row1:
	ld a, [hl+] ; $5f15
	ld [de], a ; $5f16
	inc de ; $5f17
	ld a, [hl+] ; $5f18
	ld [de], a ; $5f19
	inc de ; $5f1a
	ld a, $1e ; $5f1b
	add e ; $5f1d
	ld e, a ; $5f1e
	jr nc, .row2 ; $5f1f
	inc d ; $5f21
.row2:
	ld a, [hl+] ; $5f22
	ld [de], a ; $5f23
	inc de ; $5f24
	ld a, [hl+] ; $5f25
	ld [de], a ; $5f26
	inc de ; $5f27
	ld a, $1e ; $5f28
	add e ; $5f2a
	ld e, a ; $5f2b
	jr nc, .row3 ; $5f2c
	inc d ; $5f2e
.row3:
	ld a, [hl+] ; $5f2f
	ld [de], a ; $5f30
	inc de ; $5f31
	ld a, [hl+] ; $5f32
	ld [de], a ; $5f33
	inc de ; $5f34
	ld a, $1e ; $5f35
	add e ; $5f37
	ld e, a ; $5f38
	jr nc, .row4 ; $5f39
	inc d ; $5f3b
.row4:
	ld a, [hl+] ; $5f3c
	ld [de], a ; $5f3d
	inc de ; $5f3e
	ld a, [hl+] ; $5f3f
	ld [de], a ; $5f40
	inc de ; $5f41
	ret ; $5f42
RefreshCourtAfterEndChange:
	ld a, [wCourtViewFlipChanged] ; $5f43
	and a ; $5f46
	ret z ; $5f47
	ld a, [wMatchSimFrozen] ; $5f48
	push af ; $5f4b
	ld a, [wMatchDrawFrozen] ; $5f4c
	push af ; $5f4f
	ld a, $ff ; $5f50
	ld [wMatchSimFrozen], a ; $5f52
	ld [wMatchDrawFrozen], a ; $5f55
	call StepMatchFrame ; $5f58
	call RefreshCourtScoreboard ; $5f5b
	call StepMatchFrame ; $5f5e
	wram_bank WRAM_COURT_PLANES ; $5f61
	ld hl, wCourtTilemap + 12 * TILEMAP_WIDTH ; $5f67
	ld de, vBGMap0 + 12 * TILEMAP_WIDTH ; $5f6a
	ld c, $0a ; $5f6d
	call QueueVRAMCopy ; $5f6f
	ld hl, wCourtAttrmap + 12 * TILEMAP_WIDTH ; $5f72
	ld de, vBGMap0 + 12 * TILEMAP_WIDTH + VRAM_BANK1 ; $5f75
	ld c, $0a ; $5f78
	call QueueVRAMCopy ; $5f7a
	pop af ; $5f7d
	ld [wMatchDrawFrozen], a ; $5f7e
	pop af ; $5f81
	ld [wMatchSimFrozen], a ; $5f82
	wram_bank WRAM_ACTORS ; $5f85
	ret ; $5f8b
RunChangeoverSequence:
	ld a, $01 ; $5f8c
	ld [wPauseDisabled], a ; $5f8e
	ld a, [wChangeoverSkipBanner] ; $5f91
	and a ; $5f94
	jr nz, .walkLoop ; $5f95
	ld a, [wChangeEndsPending] ; $5f97
	and a ; $5f9a
	jr z, .done ; $5f9b
	call StepMatchFrame ; $5f9d
	ld a, $00 ; $5fa0
	farcall ShowCourtBanner ; $5fa2
	call StepMatchFrame ; $5fa5
.walkLoop:
	call StepMatchFrame ; $5fa8
	call WalkCharsToNewEnds ; $5fab
	farcall HideCourtBanner ; $5fae
	call StepMatchFrame ; $5fb1
.done:
	xor a ; $5fb4
	ld [wChangeoverSkipBanner], a ; $5fb5
	ld [wChangeEndsPending], a ; $5fb8
	ret ; $5fbb
WalkCharsToNewEnds:
	xor a ; $5fbc
	ld [wOffscreenArrowsEnabled], a ; $5fbd
	call ResetBallState ; $5fc0
	call GetServeCameraTarget ; $5fc3
	call SnapCameraTo ; $5fc6
	ld hl, StartCharChangeoverWalk ; $5fc9
	call ForEachCharBank ; $5fcc
.waitLoop:
	call StepMatchFrame ; $5fcf
	call ReadMatchInputPressed ; $5fd2
	and $0b ; $5fd5
	jr nz, .settle ; $5fd7
	call CheckAllCharsPhaseDone ; $5fd9
	jr z, .waitLoop ; $5fdc
.settle:
	ld hl, PlaceCharAtBasePosition ; $5fde
	call ForEachCharBank ; $5fe1
	ret ; $5fe4
