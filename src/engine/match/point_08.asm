ResetPointState:
	xor a ; $4cb9
	ld [wRallyNetFrames], a ; $4cba
	ld [wBallBounceCount], a ; $4cbd
	ld [wRallyLength], a ; $4cc0
	ld [wBallHitEvent], a ; $4cc3
	ld [wBallTouchCharFlag], a ; $4cc6
	ld [wBallHasBouncedFlag], a ; $4cc9
	ld [wServiceAceFlag], a ; $4ccc
	ld [wReturnAceFlag], a ; $4ccf
	ld [wLandingMarkerActive], a ; $4cd2
	ld [wPointWinnerShotType], a ; $4cd5
	ld [wMatchAbortFlag], a ; $4cd8
	ld [wPointOutcomeSide], a ; $4cdb
	ld [wPointOutcome], a ; $4cde
	ldh [hLinkPayloadKind], a ; $4ce1
	ld [wPauseDisabled], a ; $4ce3
	ld a, $01 ; $4ce6
	ld [wOffscreenArrowsEnabled], a ; $4ce8
	call ResetBallState ; $4ceb
	ld a, [wMinigameUsesTennisMachine] ; $4cee
	and a ; $4cf1
	ret nz ; $4cf2
	call ResetCameraForServe ; $4cf3
	ld de, $fe50 ; $4cf6
	ld hl, wCourtLimitX ; $4cf9
	ld a, e ; $4cfc
	ld [hl+], a ; $4cfd
	ld [hl], d ; $4cfe
	ld de, $fd60 ; $4cff
	ld hl, wCourtLimitDepth ; $4d02
	ld a, e ; $4d05
	ld [hl+], a ; $4d06
	ld [hl], d ; $4d07
	ld hl, ResetCharForPoint ; $4d08
	call ForEachCharBank ; $4d0b
	ret ; $4d0e
PlayPoint:
	call ResetPointState ; $4d0f
	ld hl, wCourtViewLocked ; $4d12
	res 1, [hl] ; $4d15
	farcall LoadServeGfx ; $4d17
	call StepMatchFrame ; $4d1a
	call AnnouncePointSituation ; $4d1d
	ld hl, SetCharStateFromServeRole ; $4d20
	call ForEachCharBank ; $4d23
.rallyLoop:
	call StepMatchFrame ; $4d26
	ld a, [wMatchAbortFlag] ; $4d29
	and MATCHABORT_POINT ; $4d2c
	jr nz, .aborted ; $4d2e
	ld a, [wPointOutcome] ; $4d30
	and a ; $4d33
	jr z, .rallyLoop ; $4d34
	ld a, [wPointOutcome] ; $4d36
	cp POINTOUTCOME_BALL_HIT_PLAYER ; $4d39
	jr nz, .pointOver ; $4d3b
	ld a, 40 ; $4d3d
	call StepMatchFrames ; $4d3f
.pointOver:
	call EndPointBallEffects ; $4d42
	farcall UpdateScorePanelDisplay ; $4d45
	call ScorePoint ; $4d48
	call StepMatchFrame ; $4d4b
	farcall UpdatePointDigitsDisplay ; $4d4e
	call StepMatchFrame ; $4d51
	call StartPointEndReactions ; $4d54
	call ResolvePointOutcome ; $4d57
	ret ; $4d5a
.aborted:
	ld hl, wMatchAbortFlag ; $4d5b
	ld a, [hl] ; $4d5e
	and $fe ; $4d5f
	ld [hl], a ; $4d61
	ret ; $4d62
SetPointSituationBgm:
	ld d, $0f ; $4d63
	ld a, [wMatchPointFlag] ; $4d65
	and a ; $4d68
	jr nz, .play ; $4d69
	ld d, $0f ; $4d6b
	ld a, [wSetPointFlag] ; $4d6d
	and a ; $4d70
	jr nz, .play ; $4d71
	ld d, $10 ; $4d73
	ld a, [wGamePointFlag] ; $4d75
	and a ; $4d78
	jr nz, .play ; $4d79
	ld d, $0e ; $4d7b
	ld a, [wTiebreakerIndicator] ; $4d7d
	and a ; $4d80
	jr nz, .play ; $4d81
	ld a, [wMatchBGM] ; $4d83
	ld d, a ; $4d86
.play:
	ld a, d ; $4d87
	call PlaySoundManaged ; $4d88
	ret ; $4d8b
AnnouncePointSituation:
	call EvaluatePointSituation ; $4d8c
	call SetPointSituationBgm ; $4d8f
	ld d, $0a ; $4d92
	ld a, [wMatchPointFlag] ; $4d94
	and a ; $4d97
	jr nz, .showBanner ; $4d98
	ld d, $09 ; $4d9a
	ld a, [wSetPointFlag] ; $4d9c
	and a ; $4d9f
	jr nz, .showBanner ; $4da0
	ld a, [wGamePointFlag] ; $4da2
	and a ; $4da5
	jr z, .done ; $4da6
	ld a, [wGamePointFlag] ; $4da8
	inc a ; $4dab
	srl a ; $4dac
	ld b, a ; $4dae
	ld a, [wCurrentServingPlayer] ; $4daf
	xor b ; $4db2
	and $01 ; $4db3
	ld d, $08 ; $4db5
	jr nz, .showBanner ; $4db7
	ld d, $07 ; $4db9
.showBanner:
	ld a, d ; $4dbb
	farcall ShowCourtBanner ; $4dbc
	ld a, [wGamePointFlag] ; $4dbf
	inc a ; $4dc2
	srl a ; $4dc3
	ld b, a ; $4dc5
	wram_bank WRAM_CHAR0 ; $4dc6
	ld a, [wCharCourtPos] ; $4dcc
	rrca ; $4dcf
	xor b ; $4dd0
	and $01 ; $4dd1
	ld de, $3460 ; $4dd3
	jr nz, .placeObj ; $4dd6
	ld de, $3420 ; $4dd8
.placeObj:
	ld bc, wObjSlot3 ; $4ddb
	farcall SetObjPosition ; $4dde
	ld a, 10 ; $4de1
	call StepMatchFrames ; $4de3
	ld a, $1e ; $4de6
	call StepMatchFramesSkippable ; $4de8
	farcall HideCourtBanner ; $4deb
	ld a, 10 ; $4dee
	call StepMatchFrames ; $4df0
.done:
	ret ; $4df3
ResolvePointOutcome:
	ld hl, wMatchCameraY ; $4df4
	ld a, [hl+] ; $4df7
	ld d, [hl] ; $4df8
	ld e, a ; $4df9
	ld hl, wMatchCameraX ; $4dfa
	ld a, [hl+] ; $4dfd
	ld h, [hl] ; $4dfe
	ld l, a ; $4dff
	call SetCameraTarget ; $4e00
	call StepMatchFrame ; $4e03
	ld hl, ResolvePointResultSequence ; $4e06
	push hl ; $4e09
	ld a, [wPointOutcome] ; $4e0a
	rst Rst00 ; $4e0d
	dw RetStub ; $4e0e jumptable
	dw DelayAfterPointResolution.case4 ; $4e10 jumptable
	dw DelayAfterPointResolution.case4 ; $4e12 jumptable
	dw DelayAfterPointResolution.case4 ; $4e14 jumptable
	dw DelayAfterPointResolution.case4 ; $4e16 jumptable
	dw DelayAfterPointResolution.case4 ; $4e18 jumptable
	dw DelayAfterPointResolution.case3 ; $4e1a jumptable
	dw DelayAfterPointResolution.case1 ; $4e1c jumptable
	dw DelayAfterPointResolution.case2 ; $4e1e jumptable
	dw RetStub ; $4e20 jumptable
ResolvePointResultSequence:
	ld hl, DelayAfterPointResolution ; $4e22
	push hl ; $4e25
	ld a, [wMatchWinLoseFlag] ; $4e26
	and a ; $4e29
	jp nz, DelayAfterPointResolution.case7 ; $4e2a
	ld a, [wSetWinLoseFlag] ; $4e2d
	and a ; $4e30
	jp nz, DelayAfterPointResolution.case10 ; $4e31
	ld a, [wGameWinLoseFlag] ; $4e34
	and a ; $4e37
	jp nz, DelayAfterPointResolution.case11 ; $4e38
	jp DelayAfterPointResolution.case5 ; $4e3b
DelayAfterPointResolution:
	ld a, $46 ; $4e3e
	call StepMatchFramesSkippable ; $4e40
	ld a, 10 ; $4e43
	call StepMatchFrames ; $4e45
	ret ; $4e48
.case1:
	ld hl, $0174 ; $4e49
	ld_cell de, $05, $04 ; $4e4c
	ld_size bc, $0a, $07 ; $4e4f
	farcall ShowMessageWindow ; $4e52
	ld a, 10 ; $4e55
	call StepMatchFrames ; $4e57
	ret ; $4e5a
.case2:
	ld hl, $0175 ; $4e5b
	ld_cell de, $02, $04 ; $4e5e
	ld_size bc, $0f, $07 ; $4e61
	farcall ShowMessageWindow ; $4e64
	ld a, 10 ; $4e67
	call StepMatchFrames ; $4e69
	ret ; $4e6c
.case3:
	ld a, [wPointWinnerShotType] ; $4e6d
	and a ; $4e70
	ret z ; $4e71
	ld a, [wPointWinnerShotType] ; $4e72
	add $17 ; $4e75
	farcall ShowCourtBanner ; $4e77
	ld a, 10 ; $4e7a
	call StepMatchFrames ; $4e7c
	ld a, $1e ; $4e7f
	call StepMatchFramesSkippable ; $4e81
	farcall HideCourtBanner ; $4e84
	ld a, 10 ; $4e87
	call StepMatchFrames ; $4e89
	ret ; $4e8c
.case4:
	ld a, [wPointOutcome] ; $4e8d
	add $00 ; $4e90
	farcall ShowCourtBanner ; $4e92
	ld a, 30 ; $4e95
	call StepMatchFrames ; $4e97
	farcall HideCourtBanner ; $4e9a
	ld a, 10 ; $4e9d
	call StepMatchFrames ; $4e9f
	ret ; $4ea2
.case5:
	ld a, [wPointWinLoseFlag] ; $4ea3
	and a ; $4ea6
	ret z ; $4ea7
	farcall SpawnGameScoreDisplayObjs ; $4ea8
	ld a, 10 ; $4eab
	call StepMatchFrames ; $4ead
	ld a, $0a ; $4eb0
	call StepMatchFramesSkippable ; $4eb2
	ld a, [wDeuceIndicator] ; $4eb5
	and a ; $4eb8
	jr z, .case6 ; $4eb9
	sound SFX_DEUCE ; $4ebb
	call StepMatchFrame ; $4ebd
.case6:
	farcall UpdateScorePanelDisplay ; $4ec0
	ld a, 10 ; $4ec3
	call StepMatchFrames ; $4ec5
	ld a, $1e ; $4ec8
	call StepMatchFramesSkippable ; $4eca
	farcall DismissGameScoreDisplayObjs ; $4ecd
	ret ; $4ed0
.case7:
	ld a, [wGameMode] ; $4ed1
	cp GAMEMODE_MARIO_MINIGAME ; $4ed4
	jr nz, .case9 ; $4ed6
	ld a, [wMatchWinLoseFlag] ; $4ed8
	add a ; $4edb
	jr nc, .case8 ; $4edc
	ld d, $17 ; $4ede
	farcall ShowMinigamePointResult ; $4ee0
	ret ; $4ee3
.case8:
	ld a, [wMinigameLevel] ; $4ee4
	add $12 ; $4ee7
	ld d, a ; $4ee9
	farcall ShowMinigamePointResult ; $4eea
	ret ; $4eed
.case9:
	ld a, $0d ; $4eee
	farcall ShowCourtBanner ; $4ef0
	ld a, 10 ; $4ef3
	call StepMatchFrames ; $4ef5
	ld a, [wGameWinLoseFlag] ; $4ef8
	farcall SpawnWinLoseResultObj ; $4efb
	ld a, 10 ; $4efe
	call StepMatchFrames ; $4f00
	ld a, $2d ; $4f03
	call StepMatchFramesSkippable ; $4f05
	farcall DismissWinLoseResultObj ; $4f08
	farcall HideCourtBanner ; $4f0b
	ret ; $4f0e
.case10:
	ld a, [wPlayer1SetsWon] ; $4f0f
	ld b, $01 ; $4f12
	farcall LoadPlayer1ScoreDigitGfx ; $4f14
	ld a, [wPlayer2SetsWon] ; $4f17
	ld b, $01 ; $4f1a
	farcall LoadPlayer2ScoreDigitGfx ; $4f1c
	ld d, $0c ; $4f1f
	jr .done ; $4f21
.case11:
	ld a, [wPlayer1GamesWon] ; $4f23
	ld b, $01 ; $4f26
	farcall LoadPlayer1ScoreDigitGfx ; $4f28
	ld a, [wPlayer2GamesWon] ; $4f2b
	ld b, $01 ; $4f2e
	farcall LoadPlayer2ScoreDigitGfx ; $4f30
	ld d, $0b ; $4f33
	jr .done ; $4f35
.done:
	call StepMatchFrame ; $4f37
	ld a, d ; $4f3a
	farcall ShowCourtBanner ; $4f3b
	ld a, 10 ; $4f3e
	call StepMatchFrames ; $4f40
	ld a, [wGameWinLoseFlag] ; $4f43
	farcall SpawnWinLoseResultObj ; $4f46
	ld a, 10 ; $4f49
	call StepMatchFrames ; $4f4b
	ld a, $28 ; $4f4e
	call StepMatchFramesSkippable ; $4f50
	farcall DismissWinLoseResultObj ; $4f53
	ld a, 10 ; $4f56
	call StepMatchFrames ; $4f58
	farcall SpawnGameResultObj ; $4f5b
	ld a, 10 ; $4f5e
	call StepMatchFrames ; $4f60
	ld a, $28 ; $4f63
	call StepMatchFramesSkippable ; $4f65
	farcall DismissGameResultObj ; $4f68
	farcall HideCourtBanner ; $4f6b
	ret ; $4f6e
ResetCharForPoint:
	ld a, CHARSTATE_INERT ; $4f6f
	call SetCharState ; $4f71
	call GetCharBaseCourtPosition ; $4f74
	call SetCharPosAndTarget ; $4f77
	ld d, CHARANIM_IDLE ; $4f7a
	call SetCharAnimation ; $4f7c
	ld hl, wCharFlags ; $4f7f
	res CHARB_RECOIL, [hl] ; $4f82
	res CHARB_DIVING, [hl] ; $4f84
	ld hl, wCharVelX ; $4f86
	xor a ; $4f89
	ld [hl+], a ; $4f8a
	ld [hl+], a ; $4f8b
	ld [hl+], a ; $4f8c
	ld [hl+], a ; $4f8d
	ld [hl+], a ; $4f8e
	ld [hl+], a ; $4f8f
	ret ; $4f90
SetCharStateFromServeRole:
	ld a, [wCharServeRole] ; $4f91
	ld_hl_indexed ServeRoleCharStateTable_08 ; $4f94
	ld a, [hl] ; $4f9b
	call SetCharState ; $4f9c
	ret ; $4f9f
ServeRoleCharStateTable_08:
	; $4fa0, 4 bytes (bytes:4)
	db $03, $05, $04, $05 ; 0x00
EndPointBallEffects:
	xor a ; $4fa4
	ld [wBallTrailEnabled], a ; $4fa5
	xor a ; $4fa8
	call SetBallTrailColor ; $4fa9
	xor a ; $4fac
	ld [wLandingMarkerActive], a ; $4fad
	ld hl, wMatchAbortFlag ; $4fb0
	ld a, [hl] ; $4fb3
	and $fe ; $4fb4
	ld [hl], a ; $4fb6
	ret ; $4fb7
StartPointEndReactions:
	ld hl, CharPointEndReaction ; $4fb8
	call ForEachCharBank ; $4fbb
	call SpreadTeammateTargets ; $4fbe
	ld a, 10 ; $4fc1
	call StepMatchFrames ; $4fc3
	ret ; $4fc6
CharPointEndReaction:
	ld a, [wPointWinLoseFlag] ; $4fc7
	ld hl, wCharIndex ; $4fca
	bit 0, [hl] ; $4fcd
	jr z, .storeResult ; $4fcf
	cpl ; $4fd1
	inc a ; $4fd2
.storeResult:
	ld [wCharPointResult], a ; $4fd3
	ld a, CHARSTATE_POINT_END ; $4fd6
	call SetCharState ; $4fd8
	ld hl, wCharPosDepth + 1 ; $4fdb
	ld a, [hl+] ; $4fde
	ld d, [hl] ; $4fdf
	ld e, a ; $4fe0
	ld hl, wCharPosX + 1 ; $4fe1
	ld a, [hl+] ; $4fe4
	ld h, [hl] ; $4fe5
	ld l, a ; $4fe6
	call SetCharTarget ; $4fe7
	xor a ; $4fea
	ld hl, wCharVelX ; $4feb
	ld [hl+], a ; $4fee
	ld [hl+], a ; $4fef
	ld [hl+], a ; $4ff0
	ld [hl+], a ; $4ff1
	ld [hl+], a ; $4ff2
	ld [hl+], a ; $4ff3
	ret ; $4ff4
SpreadTeammateTargets:
	ld a, [wOnCourtCharCountMinus1] ; $4ff5
	rst Rst00 ; $4ff8
	dw RetStub ; $4ff9 jumptable
	dw RetStub ; $4ffb jumptable
	dw SpreadFarTeamPair ; $4ffd jumptable
	dw SpreadBothTeamPairs ; $4fff jumptable
SpreadBothTeamPairs:
	wram_bank WRAM_CHAR0 ; $5001
	ld hl, wCharPosDepth + 1 ; $5007
	ld a, [hl+] ; $500a
	ld d, [hl] ; $500b
	ld e, a ; $500c
	wram_bank WRAM_CHAR2 ; $500d
	ld hl, wCharPosDepth + 1 ; $5013
	ld a, [hl+] ; $5016
	ld h, [hl] ; $5017
	ld l, a ; $5018
	call ComputePairSpread ; $5019
	wram_bank WRAM_CHAR0 ; $501c
	ld hl, wCharWalkTargetDepth ; $5022
	ld a, e ; $5025
	ld [hl+], a ; $5026
	ld [hl], d ; $5027
	wram_bank WRAM_CHAR2 ; $5028
	ld hl, wCharWalkTargetDepth ; $502e
	ld a, c ; $5031
	ld [hl+], a ; $5032
	ld [hl], b ; $5033
SpreadFarTeamPair:
	wram_bank WRAM_CHAR1 ; $5034
	ld hl, wCharPosDepth + 1 ; $503a
	ld a, [hl+] ; $503d
	ld d, [hl] ; $503e
	ld e, a ; $503f
	wram_bank WRAM_CHAR3 ; $5040
	ld hl, wCharPosDepth + 1 ; $5046
	ld a, [hl+] ; $5049
	ld h, [hl] ; $504a
	ld l, a ; $504b
	call ComputePairSpread ; $504c
	wram_bank WRAM_CHAR1 ; $504f
	ld hl, wCharWalkTargetDepth ; $5055
	ld a, e ; $5058
	ld [hl+], a ; $5059
	ld [hl], d ; $505a
	wram_bank WRAM_CHAR3 ; $505b
	ld hl, wCharWalkTargetDepth ; $5061
	ld a, c ; $5064
	ld [hl+], a ; $5065
	ld [hl], b ; $5066
	wram_bank WRAM_CHAR0 ; $5067
	ret ; $506d
