DrawMinigameScore:
	ld hl, wMinigamesCurrentScore ; $4bea
	ld a, [hl+] ; $4bed
	ld h, [hl] ; $4bee
	ld l, a ; $4bef
	ld b, $01 ; $4bf0
	ld a, $04 ; $4bf2
	farcall DrawNumberWithSprites ; $4bf4
	ret ; $4bf7
MinigameConfig_WallPractice2:
	; $4bf8, 16 bytes (bytes:16)
	db $00, $0b, $01, $07, $17, $1f, $00, $80, $1b, $4c, $b4, $40, $08, $4c, $00, $00 ; 0x00
InitMinigame_WallPractice2:
	ld a, $01 ; $4c08
	ld [wMinigameUsesWall], a ; $4c0a
	ld a, $01 ; $4c0d
	ld [wMinigameLevel], a ; $4c0f
	farcall InitMinigameTargets ; $4c12
	ld a, $01 ; $4c15
	farcall SpawnMinigameTargetFormation ; $4c17
	ret ; $4c1a
MinigameHooks_WallPractice2:
	; $4c1b, 16 bytes (mode_hooks)
	dw WallPractice2Hook_PerFrame ; record 0
	dw WallPractice2Hook_PointStart ; record 1
	dw WallPractice2Hook_PointEnd ; record 2
	dw RetStub ; record 3
	dw WallPractice2Hook_BallHit ; record 4
	dw WallPractice2Hook_Bounce ; record 5
	dw WallPractice2Hook_RallyTick ; record 6
	dw RetStub ; record 7
WallPractice2Hook_PerFrame:
	call UpdateMinigameHudAndBallTrail ; $4c2b
	ret ; $4c2e
WallPractice2Hook_PointStart:
	call StartMinigameSoloPoint ; $4c2f
	ret ; $4c32
WallPractice2Hook_PointEnd:
	call HandleMinigamePointEnd ; $4c33
	ret ; $4c36
WallPractice2Hook_RallyTick:
	call AwardMinigamePointAndReflectBall ; $4c37
	ret ; $4c3a
WallPractice2Hook_Bounce:
	call StubNop_0d_0 ; $4c3b
	ret ; $4c3e
WallPractice2Hook_BallHit:
	call HideLandingMarkerAndExtendSoloCourt ; $4c3f
	ret ; $4c42
MinigameConfig_WallPractice3:
	nop ; $4c43
	dec bc ; $4c44
	ld bc, $1807 ; $4c45
	rra ; $4c48
	nop ; $4c49
	add b ; $4c4a
	ld h, [hl] ; $4c4b
	ld c, h ; $4c4c
	or h ; $4c4d
	ld b, b ; $4c4e
	ld d, e ; $4c4f
	ld c, h ; $4c50
	nop ; $4c51
	nop ; $4c52
InitMinigame_WallPractice3:
	ld a, $01 ; $4c53
	ld [wMinigameUsesWall], a ; $4c55
	ld a, $02 ; $4c58
	ld [wMinigameLevel], a ; $4c5a
	farcall InitMinigameTargets ; $4c5d
	ld a, $02 ; $4c60
	farcall SpawnMinigameTargetFormation ; $4c62
	ret ; $4c65
MinigameHooks_WallPractice3:
	; $4c66, 16 bytes (mode_hooks)
	dw WallPractice3Hook_PerFrame ; record 0
	dw WallPractice3Hook_PointStart ; record 1
	dw WallPractice3Hook_PointEnd ; record 2
	dw RetStub ; record 3
	dw WallPractice3Hook_BallHit ; record 4
	dw WallPractice3Hook_Bounce ; record 5
	dw WallPractice3Hook_RallyTick ; record 6
	dw RetStub ; record 7
WallPractice3Hook_PerFrame:
	call UpdateMinigameHudAndBallTrail ; $4c76
	ret ; $4c79
WallPractice3Hook_PointStart:
	call StartMinigameSoloPoint ; $4c7a
	ret ; $4c7d
WallPractice3Hook_PointEnd:
	call HandleMinigamePointEnd ; $4c7e
	ret ; $4c81
WallPractice3Hook_RallyTick:
	call AwardMinigamePointAndReflectBall ; $4c82
	ret ; $4c85
WallPractice3Hook_Bounce:
	call StubNop_0d_0 ; $4c86
	ret ; $4c89
WallPractice3Hook_BallHit:
	call HideLandingMarkerAndExtendSoloCourt ; $4c8a
	ret ; $4c8d
MinigameConfig_WallPractice4:
	nop ; $4c8e
	dec bc ; $4c8f
	ld bc, $1907 ; $4c90
	rra ; $4c93
	nop ; $4c94
	add b ; $4c95
	or c ; $4c96
	ld c, h ; $4c97
	or h ; $4c98
	ld b, b ; $4c99
	sbc [hl] ; $4c9a
	ld c, h ; $4c9b
	nop ; $4c9c
	nop ; $4c9d
InitMinigame_WallPractice4:
	ld a, $01 ; $4c9e
	ld [wMinigameUsesWall], a ; $4ca0
	ld a, $03 ; $4ca3
	ld [wMinigameLevel], a ; $4ca5
	farcall InitMinigameTargets ; $4ca8
	ld a, $03 ; $4cab
	farcall SpawnMinigameTargetFormation ; $4cad
	ret ; $4cb0
MinigameHooks_WallPractice4:
	; $4cb1, 16 bytes (mode_hooks)
	dw WallPractice4Hook_PerFrame ; record 0
	dw WallPractice4Hook_PointStart ; record 1
	dw WallPractice4Hook_PointEnd ; record 2
	dw RetStub ; record 3
	dw WallPractice4Hook_BallHit ; record 4
	dw WallPractice4Hook_Bounce ; record 5
	dw WallPractice4Hook_RallyTick ; record 6
	dw RetStub ; record 7
WallPractice4Hook_PerFrame:
	call UpdateMinigameHudAndBallTrail ; $4cc1
	ret ; $4cc4
WallPractice4Hook_PointStart:
	call StartMinigameSoloPoint ; $4cc5
	ret ; $4cc8
WallPractice4Hook_PointEnd:
	call HandleMinigamePointEnd ; $4cc9
	ret ; $4ccc
WallPractice4Hook_RallyTick:
	call AwardMinigamePointAndReflectBall ; $4ccd
	ret ; $4cd0
WallPractice4Hook_Bounce:
	call StubNop_0d_0 ; $4cd1
	ret ; $4cd4
WallPractice4Hook_BallHit:
	call HideLandingMarkerAndExtendSoloCourt ; $4cd5
	ret ; $4cd8
MinigameConfig_TennisMachineHighScore:
	; $4cd9, 16 bytes (bytes:16)
	db $15, $0a, $02, $06, $1a, $1e, $00, $80, $f9, $4c, $bd, $40, $e9, $4c, $00, $00 ; 0x00
InitMinigame_TennisMachineHighScore:
	ld a, $01 ; $4ce9
	ld [wMinigameUsesTennisMachine], a ; $4ceb
	ld a, $01 ; $4cee
	ld [wMinigameHighScoreMode], a ; $4cf0
	ld a, $04 ; $4cf3
	ld [wMinigameLevel], a ; $4cf5
	ret ; $4cf8
MinigameHooks_TennisMachineHighScore:
	; $4cf9, 16 bytes (mode_hooks)
	dw TennisMachineHighScoreHook_PerFrame ; record 0
	dw TennisMachineHighScoreHook_PointStart ; record 1
	dw TennisMachineHighScoreHook_PointEnd ; record 2
	dw TennisMachineHighScoreHook_MinigameStart ; record 3
	dw TennisMachineHighScoreHook_BallHit ; record 4
	dw TennisMachineHighScoreHook_Bounce ; record 5
	dw TennisMachineHighScoreHook_RallyTick ; record 6
	dw RetStub ; record 7
TennisMachineHighScoreHook_MinigameStart:
	ld a, $04 ; $4d09
	ld [wMinigameServeSlot], a ; $4d0b
	call StartMinigameMatch ; $4d0e
	ret ; $4d11
TennisMachineHighScoreHook_PerFrame:
	call DrawMinigameScoreHud ; $4d12
	ret ; $4d15
; Instruction-identical to TennisMachine4Hook_PointStart (in this bank); a change here belongs in every copy.
	twin_named tennis_machine4_hook__point_start, TennisMachineHighScoreHook_PointStart ; $4d16
TennisMachineHighScoreHook_PointEnd:
	call AwardMinigamePointAndEnd ; $4d2b
	ret ; $4d2e
TennisMachineHighScoreHook_RallyTick:
	call KeepMinigameCameraFixed ; $4d2f
	ret ; $4d32
TennisMachineHighScoreHook_Bounce:
	call CheckMinigameStartBannerTrigger ; $4d33
	ret ; $4d36
TennisMachineHighScoreHook_BallHit:
	call FreezeMinigameOpponentOnReturn ; $4d37
	ret ; $4d3a
MinigameConfig_WallPracticeHighScore:
	nop ; $4d3b
	dec bc ; $4d3c
	ld bc, $1b07 ; $4d3d
	rra ; $4d40
	nop ; $4d41
	add b ; $4d42
	ld h, e ; $4d43
	ld c, l ; $4d44
	or h ; $4d45
	ld b, b ; $4d46
	ld c, e ; $4d47
	ld c, l ; $4d48
	nop ; $4d49
	nop ; $4d4a
InitMinigame_WallPracticeHighScore:
	ld a, $01 ; $4d4b
	ld [wMinigameHighScoreMode], a ; $4d4d
	ld a, $01 ; $4d50
	ld [wMinigameUsesWall], a ; $4d52
	ld a, $04 ; $4d55
	ld [wMinigameLevel], a ; $4d57
	farcall InitMinigameTargets ; $4d5a
	ld a, $04 ; $4d5d
	farcall SpawnMinigameTargetFormation ; $4d5f
	ret ; $4d62
MinigameHooks_WallPracticeHighScore:
	; $4d63, 16 bytes (mode_hooks)
	dw WallPracticeHighScoreHook_PerFrame ; record 0
	dw WallPracticeHighScoreHook_PointStart ; record 1
	dw WallPracticeHighScoreHook_PointEnd ; record 2
	dw RetStub ; record 3
	dw WallPracticeHighScoreHook_BallHit ; record 4
	dw WallPracticeHighScoreHook_Bounce ; record 5
	dw WallPracticeHighScoreHook_RallyTick ; record 6
	dw RetStub ; record 7
WallPracticeHighScoreHook_PerFrame:
	call UpdateMinigameHudAndBallTrail ; $4d73
	ret ; $4d76
WallPracticeHighScoreHook_PointStart:
	call StartMinigameSoloPoint ; $4d77
	ret ; $4d7a
WallPracticeHighScoreHook_PointEnd:
	call HandleMinigamePointEnd ; $4d7b
	ret ; $4d7e
WallPracticeHighScoreHook_RallyTick:
	call AwardMinigamePointAndReflectBall ; $4d7f
	ret ; $4d82
WallPracticeHighScoreHook_Bounce:
	call StubNop_0d_0 ; $4d83
	ret ; $4d86
WallPracticeHighScoreHook_BallHit:
	call HideLandingMarkerAndExtendSoloCourt ; $4d87
	ret ; $4d8a
MinigameConfig_TargetShot:
	dec d ; $4d8b
	rrca ; $4d8c
	ld [bc], a ; $4d8d
	ld [$191f], sp ; $4d8e
	nop ; $4d91
	add hl, de ; $4d92
	xor l ; $4d93
	ld c, l ; $4d94
	cp l ; $4d95
	ld b, b ; $4d96
	sbc e ; $4d97
	ld c, l ; $4d98
	nop ; $4d99
	nop ; $4d9a
InitMinigame_TargetShot:
	ld a, $01 ; $4d9b
	ld [wMinigameUsesTennisMachine], a ; $4d9d
	ld a, [wMinigameLevel] ; $4da0
	cp $02 ; $4da3
	jr nz, .done ; $4da5
	ld a, $01 ; $4da7
	ld [wMinigameHighScoreMode], a ; $4da9
.done:
	ret ; $4dac
MinigameHooks_TargetShot:
	; $4dad, 16 bytes (mode_hooks)
	dw TargetShotHook_PerFrame ; record 0
	dw TargetShotHook_PointStart ; record 1
	dw TargetShotHook_PointEnd ; record 2
	dw TargetShotHook_MinigameStart ; record 3
	dw TargetShotHook_BallHit ; record 4
	dw TargetShotHook_Bounce ; record 5
	dw TargetShotHook_RallyTick ; record 6
	dw RetStub ; record 7
TargetShotHook_MinigameStart:
	ld a, $01 ; $4dbd
	ld [wMinigameServeSlot], a ; $4dbf
	call StartMinigameMatch ; $4dc2
	ld a, $01 ; $4dc5
	ld [wTargetZoneEnabled], a ; $4dc7
	ret ; $4dca
TargetShotHook_PerFrame:
	call DrawMinigameScoreHud ; $4dcb
	call UpdateTargetShotScorePopup ; $4dce
	ret ; $4dd1
TargetShotHook_PointStart:
	call SelectRandomMinigameShot ; $4dd2
	farcall AdvanceMatchRng ; $4dd5
	and $01 ; $4dd8
	inc a ; $4dda
	ld hl, wMinigameServeSlot ; $4ddb
	add [hl] ; $4dde
	cp $03 ; $4ddf
	jr c, .store ; $4de1
	sub $03 ; $4de3
.store:
	ld [hl], a ; $4de5
	call LaunchMinigameServe ; $4de6
	ret ; $4de9
TargetShotHook_PointEnd:
	call EndMinigamePoint ; $4dea
	ret ; $4ded
TargetShotHook_RallyTick:
	call KeepMinigameCameraFixed ; $4dee
	ret ; $4df1
TargetShotHook_Bounce:
	ld a, [wPointOutcome] ; $4df2
	and a ; $4df5
	ret nz ; $4df6
	call CheckMinigameStartBannerTrigger ; $4df7
	call CheckBallLandedOut ; $4dfa
	ld a, [wPointOutcome] ; $4dfd
	cp POINTOUTCOME_WINNER ; $4e00
	ret nz ; $4e02
	call LookupMinigameShotResult ; $4e03
	ld d, $00 ; $4e06
	ld e, a ; $4e08
	ld hl, wScorePopupValue ; $4e09
	ld a, e ; $4e0c
	ld [hl+], a ; $4e0d
	ld [hl], d ; $4e0e
	call AddToMinigameScore ; $4e0f
	call StartScorePopup ; $4e12
	sound SFX_CHIME ; $4e15
	ret ; $4e17
TargetShotHook_BallHit:
	call FreezeMinigameOpponentOnReturn ; $4e18
	ret ; $4e1b
UpdateTargetShotScorePopup:
	call UpdateScorePopup ; $4e1c
	ret ; $4e1f
SelectRandomMinigameShot:
	push_wram_bank WRAM_COURT_PLANES ; $4e20
	ld a, [wMinigameLevel] ; $4e29
	add a ; $4e2c
	ld_hl_indexed TargetShotZonePoolsByLevel ; $4e2d
	ld a, [hl+] ; $4e34
	ld h, [hl] ; $4e35
	ld l, a ; $4e36
	farcall AdvanceMatchRng ; $4e37
	and $0f ; $4e3a
	add l ; $4e3c
	ld l, a ; $4e3d
	jr nc, .read ; $4e3e
	inc h ; $4e40
.read:
	ld a, [hl] ; $4e41
	ld [wMinigameShotRoll], a ; $4e42
	ld a, [wMinigameShotRoll] ; $4e45
	call LoadTargetZoneConfig ; $4e48
	ld a, [wMinigameShotRoll] ; $4e4b
	call LoadMatchUiCourtTilemap ; $4e4e
	call QueueMinigameHudVRAMCopy ; $4e51
	pop_wram_bank ; $4e54
	ret ; $4e59
TargetShotZonePoolsByLevel:
	; $4e5a, 6 bytes (records:2)
	dw TargetShotZonePool0 ; record 0
	dw TargetShotZonePool1 ; record 1
	dw TargetShotZonePool1 ; record 2
TargetShotZonePool0:
	; $4e60, 16 bytes (bytes:16)
	db $00, $00, $00, $00, $01, $01, $01, $01, $05, $05, $05, $06, $06, $06, $04, $04 ; 0x00
TargetShotZonePool1:
	; $4e70, 16 bytes (bytes:16)
	db $00, $00, $00, $00, $01, $01, $01, $01, $02, $02, $02, $03, $03, $03, $04, $04 ; 0x00
CheckBallLandedOut:
	ld a, [wLastShotCharIndex] ; $4e80
	and $01 ; $4e83
	ret nz ; $4e85
	farcall IsBallInTargetZone ; $4e86
	and a ; $4e89
	ret nz ; $4e8a
	ld a, POINTOUTCOME_OUT ; $4e8b
	ld [wPointOutcome], a ; $4e8d
	ld a, $ff ; $4e90
	ld [wPointOutcomeSide], a ; $4e92
	ret ; $4e95
LookupMinigameShotResult:
	ld hl, TargetShotScoreRules ; $4e96
.loop:
	ld a, [hl+] ; $4e99
	cp $ff ; $4e9a
	jr z, .eqff2 ; $4e9c
	ld e, a ; $4e9e
	ld a, [hl+] ; $4e9f
	ld d, a ; $4ea0
	ld a, [hl+] ; $4ea1
	ld c, a ; $4ea2
	ld a, [hl+] ; $4ea3
	ld b, a ; $4ea4
	ld a, [wMinigameShotRoll] ; $4ea5
	cp e ; $4ea8
	jr nz, .loop ; $4ea9
	ld a, [wLastShotButtons] ; $4eab
	cp d ; $4eae
	jr nz, .loop ; $4eaf
	ld a, c ; $4eb1
	cp $ff ; $4eb2
	jr z, .eqff ; $4eb4
	ld a, [wCurrentShotType] ; $4eb6
	cp c ; $4eb9
	jr nz, .loop ; $4eba
.eqff:
	ld a, b ; $4ebc
	ret ; $4ebd
.eqff2:
	ld a, $01 ; $4ebe
	ret ; $4ec0
TargetShotScoreRules:
	; $4ec1, 69 bytes (score_rule)
; score_rule roll, buttons, shot, points
	score_rule 0, $11, SHOTTYPE_POWER_TOPSPIN, 3
	score_rule 0, $11, SHOTTYPE_REACH_POWER_TOPSPIN, 3
	score_rule 0, $11, $ff, 3
	score_rule 1, $22, SHOTTYPE_POWER_SLICE, 3
	score_rule 1, $22, SHOTTYPE_REACH_POWER_SLICE, 3
	score_rule 1, $22, $ff, 3
	score_rule 2, $21, SHOTTYPE_DROP, 5
	score_rule 2, $21, $ff, 5
	score_rule 3, $12, SHOTTYPE_LOB, 5
	score_rule 3, $12, $ff, 5
	score_rule 4, $30, SHOTTYPE_SMASH, 5
	score_rule 4, $30, SHOTTYPE_NEUTRAL, 3
	score_rule 4, $30, $ff, 3
	score_rule 5, $21, SHOTTYPE_DROP, 5
	score_rule 5, $21, $ff, 5
	score_rule 6, $12, SHOTTYPE_LOB, 5
	score_rule 6, $12, $ff, 5
	db $ff ; end
TargetShotZoneOverlayTiles:
	; $4f06, 250 bytes (bytes:10)
	db $14, $14, $14, $14, $14, $15, $14, $14, $14, $14 ; 0x00
	db $28, $29, $29, $28, $14, $14, $14, $14, $14, $14 ; 0x0a
	db $36, $37, $38, $36, $14, $14, $14, $14, $14, $14 ; 0x14
	db $45, $46, $47, $45, $42, $41, $42, $42, $42, $42 ; 0x1e
	db $51, $52, $52, $51, $00, $4d, $00, $00, $00, $00 ; 0x28
	db $14, $14, $14, $14, $14, $15, $14, $14, $14, $14 ; 0x32
	db $14, $14, $14, $14, $14, $14, $28, $29, $29, $28 ; 0x3c
	db $14, $14, $14, $14, $14, $14, $2a, $2b, $48, $49 ; 0x46
	db $42, $42, $42, $42, $42, $41, $39, $3a, $53, $54 ; 0x50
	db $00, $00, $00, $00, $00, $4d, $51, $52, $52, $51 ; 0x5a
	db $14, $14, $14, $14, $14, $15, $14, $14, $14, $14 ; 0x64
	db $14, $14, $14, $14, $14, $14, $14, $14, $14, $14 ; 0x6e
	db $14, $14, $14, $14, $14, $14, $14, $14, $14, $14 ; 0x78
	db $7e, $7f, $95, $96, $97, $98, $99, $9a, $7f, $7e ; 0x82
	db $8a, $8b, $a3, $a4, $a5, $a6, $a7, $a8, $8b, $8a ; 0x8c
	db $80, $81, $60, $61, $62, $63, $64, $65, $81, $80 ; 0x96
	db $28, $8c, $6f, $70, $71, $72, $73, $74, $8c, $28 ; 0xa0
	db $14, $14, $14, $14, $14, $14, $14, $14, $14, $14 ; 0xaa
	db $42, $42, $42, $42, $42, $41, $42, $42, $42, $42 ; 0xb4
	db $00, $00, $00, $00, $00, $4d, $00, $00, $00, $00 ; 0xbe
	db $14, $14, $14, $14, $14, $15, $14, $14, $14, $14 ; 0xc8
	db $14, $14, $af, $b0, $b1, $b1, $b0, $af, $14, $14 ; 0xd2
	db $80, $b7, $b8, $b9, $ba, $bb, $bc, $bd, $b7, $80 ; 0xdc
	db $8a, $c5, $c6, $c7, $c8, $c9, $ca, $cb, $c5, $8a ; 0xe6
	db $00, $00, $d4, $d5, $52, $52, $d5, $d4, $00, $00 ; 0xf0
TargetShotZoneOverlayAttrs:
	; $5000, 250 bytes (bytes:10)
	db $2f, $2f, $2f, $2f, $2f, $0f, $2f, $2f, $2f, $2f ; 0x00
	db $0e, $0e, $2e, $2e, $2f, $2f, $2f, $2f, $2f, $2f ; 0x0a
	db $0e, $0e, $0e, $2e, $2f, $2f, $2f, $2f, $2f, $2f ; 0x14
	db $0e, $0e, $0e, $2e, $0f, $0f, $0f, $0f, $0f, $0f ; 0x1e
	db $0e, $0e, $2e, $2e, $2f, $0f, $2f, $2f, $2f, $2f ; 0x28
	db $2f, $2f, $2f, $2f, $2f, $0f, $2f, $2f, $2f, $2f ; 0x32
	db $2f, $2f, $2f, $2f, $2f, $2f, $0e, $0e, $2e, $2e ; 0x3c
	db $2f, $2f, $2f, $2f, $2f, $2f, $0e, $0e, $0e, $0e ; 0x46
	db $0f, $0f, $0f, $0f, $0f, $0f, $0e, $0e, $0e, $0e ; 0x50
	db $2f, $2f, $2f, $2f, $2f, $0f, $0e, $0e, $2e, $2e ; 0x5a
	db $2f, $2f, $2f, $2f, $2f, $0f, $2f, $2f, $2f, $2f ; 0x64
	db $2f, $2f, $2f, $2f, $2f, $2f, $2f, $2f, $2f, $2f ; 0x6e
	db $2f, $2f, $2f, $2f, $2f, $2f, $2f, $2f, $2f, $2f ; 0x78
	db $0e, $0e, $0e, $0e, $0e, $0e, $0e, $0e, $2e, $2e ; 0x82
	db $0e, $0e, $0e, $0e, $0e, $0e, $0e, $0e, $2e, $2e ; 0x8c
	db $0e, $0e, $0e, $0e, $0e, $0e, $0e, $0e, $2e, $2e ; 0x96
	db $4e, $0e, $0e, $0e, $0e, $0e, $0e, $0e, $2e, $6e ; 0xa0
	db $2f, $2f, $2f, $2f, $2f, $2f, $2f, $2f, $2f, $2f ; 0xaa
	db $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f ; 0xb4
	db $2f, $2f, $2f, $2f, $2f, $0f, $2f, $2f, $2f, $2f ; 0xbe
	db $2f, $2f, $2f, $2f, $2f, $0f, $2f, $2f, $2f, $2f ; 0xc8
	db $2f, $2f, $0e, $0e, $0e, $2e, $2e, $2e, $2f, $2f ; 0xd2
	db $0e, $0e, $0e, $0e, $0e, $0e, $0e, $0e, $2e, $2e ; 0xdc
	db $0e, $0e, $0e, $0e, $0e, $0e, $0e, $0e, $2e, $2e ; 0xe6
	db $2f, $2f, $0e, $0e, $0e, $2e, $2e, $2e, $2f, $0f ; 0xf0
