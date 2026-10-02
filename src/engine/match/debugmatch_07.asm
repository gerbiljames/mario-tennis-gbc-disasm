Unused_07_RunDebugTestMatch:
	ld a, GAMEMODE_EXHIBITION ; $5df9
	ld [wGameMode], a ; $5dfb
	ld a, STORYSLOT_NONE ; $5dfe
	ld [wCurrentStorySlot], a ; $5e00
	ld a, $01 ; $5e03
	ld [wKeepMatchStatsFlag], a ; $5e05
	ld a, $01 ; $5e08
	ld [wPlayer1SetsWon], a ; $5e0a
	ld [wPlayer1GamesWon], a ; $5e0d
	ld [wPlayer1PointsWon], a ; $5e10
	ld [wPlayer2SetsWon], a ; $5e13
	ld [wPlayer2GamesWon], a ; $5e16
	ld [wPlayer2PointsWon], a ; $5e19
	ld a, $02 ; $5e1c
	ld [wPlayer1GamesWon], a ; $5e1e
	ld a, $01 ; $5e21
	ld [wTotalGamesWonInMatch], a ; $5e23
	ld [wCharacter1ServiceAces], a ; $5e26
	ld [wCharacter1ReturnAces], a ; $5e29
	ld [wCharacter1SmashAces], a ; $5e2c
	ld [wCharacter1LobShotWinners], a ; $5e2f
	ld [wCharacter1DropShotWinners], a ; $5e32
	ld [wCharacter1Faults], a ; $5e35
	ld [wCharacter1DoubleFaults], a ; $5e38
	ld [wCharacter3ServiceAces], a ; $5e3b
	ld [wCharacter3ReturnAces], a ; $5e3e
	ld [wCharacter3SmashAces], a ; $5e41
	ld [wCharacter3LobShotWinners], a ; $5e44
	ld [wCharacter3DropShotWinners], a ; $5e47
	ld a, $62 ; $5e4a
	ld [wCharacter2ReturnAces], a ; $5e4c
	ld a, $01 ; $5e4f
	ld [wMatchIsDoubles], a ; $5e51
	ld a, $04 ; $5e54
	ld [wOnCourtCharCount], a ; $5e56
	ld a, COURT_CASTLE ; $5e59
	ld [wCurrentlyUsedCourt], a ; $5e5b
	ld a, $03 ; $5e5e
	ld [wMatchTypeNumberOfSets], a ; $5e60
	ld a, $02 ; $5e63
	ld [wMatchTypeNumberOfGames], a ; $5e65
	ld a, CHAR_MARIO ; $5e68
	ld [wMatchPlayerChar], a ; $5e6a
	ld b, a ; $5e6d
	ld c, $00 ; $5e6e
	farcall InitCa00RecordFromCharId ; $5e70
	ld a, CHAR_BOWSER ; $5e73
	ld [wMatchOpponentChar], a ; $5e75
	ld b, a ; $5e78
	ld c, $02 ; $5e79
	farcall InitCa00RecordFromCharId ; $5e7b
	ld a, CHAR_PEACH ; $5e7e
	ld b, a ; $5e80
	ld c, $01 ; $5e81
	farcall InitCa00RecordFromCharId ; $5e83
	ld a, CHAR_YOSHI ; $5e86
	ld b, a ; $5e88
	ld c, $03 ; $5e89
	farcall InitCa00RecordFromCharId ; $5e8b
	ld a, $00 ; $5e8e
	farcall SetStorySlotFlagB ; $5e90
	ld a, $01 ; $5e93
	farcall SetStorySlotFlagA ; $5e95
	ld a, $fe ; $5e98
	ld [wDebugMatchFlags], a ; $5e9a
	farcall RunMatch ; $5e9d
	ret ; $5ea0
Unused_07_RunTargetZoneTestMode:
	farcall InitMinigameMatchSettings ; $5ea1
	ld a, COURT_GRASS ; $5ea4
	ld [wCurrentlyUsedCourt], a ; $5ea6
	ld a, $02 ; $5ea9
	ld [wOnCourtCharCount], a ; $5eab
	ldh a, [hRomBank] ; $5eae
	ld de, ModeHookTable_07 ; $5eb0
	farcall SetModeHookTable ; $5eb3
	ld de, TargetZoneTestModeMinigamePointTable_07 ; $5eb6
	farcall SetMinigamePointTable ; $5eb9
	ld a, $01 ; $5ebc
	ld [wTargetZoneEnabled], a ; $5ebe
	ld a, CHAR_MARIO ; $5ec1
	ld [wMatchPlayerChar], a ; $5ec3
	ld a, CHAR_YOSHI ; $5ec6
	ld [wMatchOpponentChar], a ; $5ec8
	farcall RunN64ExhibData ; $5ecb
	farcall RunMinigameMatch ; $5ece
	ret ; $5ed1
Unused_07_StubNop_07_0:
	ret ; $5ed2
Unused_07_ResolveTargetModePoint:
	farcall UpdateScorePanelDisplay ; $5ed3
	farcall ResolvePointWinner ; $5ed6
	ld [wPointWinLoseFlag], a ; $5ed9
	farcall UpdatePointStats ; $5edc
	farcall AwardPoint ; $5edf
	ld a, [wPlayer1PointsWon] ; $5ee2
	ld b, $01 ; $5ee5
	farcall LoadPlayer1PointsDigitGfx ; $5ee7
	ld a, [wPlayer2PointsWon] ; $5eea
	ld b, $01 ; $5eed
	farcall LoadPlayer2PointsDigitGfx ; $5eef
	farcall StepMatchFrame ; $5ef2
	farcall StartPointEndReactions ; $5ef5
	farcall ResolvePointOutcome ; $5ef8
	ret ; $5efb
ModeHookTable_07:
	; $5efc, 16 bytes (mode_hooks)
	dw Unused_07_ModeHookNop ; record 0
	dw Unused_07_TargetZonePointStartHook ; record 1
	dw Unused_07_TargetZonePointEndHook ; record 2
	dw RetStub ; record 3
	dw Unused_07_TargetZoneBallHitHook ; record 4
	dw Unused_07_TargetZoneBounceHook ; record 5
	dw Unused_07_StubNop_07_1 ; record 6
	dw RetStub ; record 7
Unused_07_ModeHookNop:
	ret ; $5f0c
Unused_07_TargetZoneHitStopHook:
	test_flag $0c, 4 ; $5f0d
	ret z ; $5f10
	ld a, $01 ; $5f11
	ld [wMatchSimFrozen], a ; $5f13
	ld a, $14 ; $5f16
	farcall StepMatchFrames ; $5f18
	ld a, $00 ; $5f1b
	ld [wMatchSimFrozen], a ; $5f1d
	clear_flag $0c, 4 ; $5f20
	ret ; $5f23
Unused_07_StubNop_07_1:
	ret ; $5f24
Unused_07_TargetZoneBounceHook:
	farcall IsBallInTargetZone ; $5f25
	jr z, .done ; $5f28
	farcall AdvanceMatchRng ; $5f2a
	ld h, $00 ; $5f2d
	ld l, a ; $5f2f
	add hl, hl ; $5f30
	xor a ; $5f31
	sub l ; $5f32
	ld l, a ; $5f33
	sbc a ; $5f34
	sub h ; $5f35
	ld h, a ; $5f36
	ld e, l ; $5f37
	ld d, h ; $5f38
	farcall SetTargetZoneCorner1 ; $5f39
	farcall AdvanceMatchRng ; $5f3c
	ld h, $00 ; $5f3f
	ld l, a ; $5f41
	add hl, hl ; $5f42
	ld e, l ; $5f43
	ld d, h ; $5f44
	farcall SetTargetZoneCorner2 ; $5f45
.done:
	ret ; $5f48
Unused_07_TargetZoneBallHitHook:
	set_flag $0c, 4 ; $5f49
	ret ; $5f4c
Unused_07_TargetZonePointStartHook:
	ld hl, $fdc0 ; $5f4d
	ld de, $fd80 ; $5f50
	farcall SetBallGatePoint1 ; $5f53
	ld hl, $0240 ; $5f56
	ld de, $fd80 ; $5f59
	farcall SetBallGatePoint2 ; $5f5c
	ld hl, $ff60 ; $5f5f
	ld de, $fd60 ; $5f62
	farcall SetTargetZoneCorner1 ; $5f65
	ld hl, $0000 ; $5f68
	ld de, rJOYP ; $5f6b
	farcall SetTargetZoneCorner2 ; $5f6e
	call Unused_07_StubNop_07_0 ; $5f71
	ret ; $5f74
Unused_07_TargetZonePointEndHook:
	ld hl, $013f ; $5f75
	ld_cell de, $00, $0b ; $5f78
	ld_size bc, $13, $05 ; $5f7b
	farcall ShowMessageWindow ; $5f7e
	call Unused_07_ResolveTargetModePoint ; $5f81
	ld a, [wCharacter1ServiceAces] ; $5f84
	ld hl, wCharacter2ServiceAces ; $5f87
	cp [hl] ; $5f8a
	jr nz, .abortMatch ; $5f8b
	ret ; $5f8d
.abortMatch:
	ld a, MATCHABORT_ALL ; $5f8e
	ld [wMatchAbortFlag], a ; $5f90
	ret ; $5f93
MinigamePointTable_07_0:
	; $5f94, 32 bytes (court_positions)
; court_positions pos0, pos1, pos2, pos3, role0, role1, role2, role3
	court_positions $00, $09, $09, $09, $00, $09, $09, $09 ; point 0
	court_positions $01, $09, $09, $09, $00, $09, $09, $09 ; point 1
	court_positions $03, $09, $09, $09, $00, $09, $09, $09 ; point 2
	court_positions $02, $09, $09, $09, $00, $09, $09, $09 ; point 3
	; $5fb4, 1 bytes (fill)
	ds 1, $ff
MinigamePointTable_07_1:
	; $5fb5, 64 bytes (court_positions)
; court_positions pos0, pos1, pos2, pos3, role0, role1, role2, role3
	court_positions $00, $03, $09, $09, $00, $01, $09, $09 ; point 0
	court_positions $03, $00, $09, $09, $01, $00, $09, $09 ; point 1
	court_positions $01, $02, $09, $09, $00, $01, $09, $09 ; point 2
	court_positions $02, $01, $09, $09, $01, $00, $09, $09 ; point 3
	court_positions $03, $00, $09, $09, $00, $01, $09, $09 ; point 4
	court_positions $00, $03, $09, $09, $01, $00, $09, $09 ; point 5
	court_positions $02, $01, $09, $09, $00, $01, $09, $09 ; point 6
	court_positions $01, $02, $09, $09, $01, $00, $09, $09 ; point 7
	; $5ff5, 1 bytes (fill)
	ds 1, $ff
TargetZoneTestModeMinigamePointTable_07:
	; $5ff6, 64 bytes (court_positions)
; court_positions pos0, pos1, pos2, pos3, role0, role1, role2, role3
	court_positions $00, $03, $09, $09, $00, $01, $09, $09 ; point 0
	court_positions $01, $02, $09, $09, $01, $00, $09, $09 ; point 1
	court_positions $00, $03, $09, $09, $01, $00, $09, $09 ; point 2
	court_positions $01, $02, $09, $09, $00, $01, $09, $09 ; point 3
	court_positions $03, $00, $09, $09, $00, $01, $09, $09 ; point 4
	court_positions $02, $01, $09, $09, $01, $00, $09, $09 ; point 5
	court_positions $03, $00, $09, $09, $01, $00, $09, $09 ; point 6
	court_positions $02, $01, $09, $09, $00, $01, $09, $09 ; point 7
	; $6036, 8138 bytes fill to bank end (linker-padded)
