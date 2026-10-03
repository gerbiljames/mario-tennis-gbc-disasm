AwardTreasureBoxHitScore:
	ld a, $10 ; $5c2c
	ld [wMinigameSceneActor + 3], a ; $5c2e
	ld a, $01 ; $5c31
	ld [wMinigameHitScored], a ; $5c33
	ld a, [wMinigameHitStreak] ; $5c36
	ld_de_indexed TreasureBoxHitStreakSounds ; $5c39
	ld a, [de] ; $5c40
	call PlaySoundManaged ; $5c41
	ld a, [wMinigameSceneActor + 1] ; $5c44
	ld_hl_indexed TreasureBoxValuesByType ; $5c47
	ld l, [hl] ; $5c4e
	ld h, $00 ; $5c4f
	ld a, [wMinigameHitStreak] ; $5c51
	ld_de_indexed TreasureBoxHitStreakMultipliers ; $5c54
	ld a, [de] ; $5c5b
	call MulHLByA ; $5c5c
	ld e, l ; $5c5f
	ld d, h ; $5c60
	ld hl, wScorePopupValue ; $5c61
	ld a, e ; $5c64
	ld [hl+], a ; $5c65
	ld [hl], d ; $5c66
	call AddToMinigameScore ; $5c67
	call StartScorePopup ; $5c6a
	ld b, $03 ; $5c6d
	call IncrementCappedCounter ; $5c6f
	ld a, POINTOUTCOME_WINNER ; $5c72
	ld [wPointOutcome], a ; $5c74
	ld a, $01 ; $5c77
	ld [wPointOutcomeSide], a ; $5c79
	ret ; $5c7c
TreasureBoxValuesByType:
	; $5c7d, 4 bytes (bytes:4)
	db $05, $0a, $32, $64 ; 0x00
TreasureBoxHitStreakSounds:
	; $5c81, 4 bytes (bytes:4)
	db $c0, $be, $bc, $ba ; 0x00
TreasureBoxHitStreakMultipliers:
	; $5c85, 4 bytes (bytes:4)
	db $01, $02, $04, $08 ; 0x00
DrawTreasureBoxSprite:
	call ProjectTreasureBoxWorldPosition ; $5c89
	ld c, $30 ; $5c8c
	call QueueSprite16 ; $5c8e
	ld a, [wMinigameSceneActor + 1] ; $5c91
	ld b, a ; $5c94
	ld hl, wTreasureBoxState ; $5c95
	ld a, [hl] ; $5c98
	inc [hl] ; $5c99
	and $1f ; $5c9a
	ld_hl_indexed TreasureBoxSpriteAnimFrames ; $5c9c
	ld a, [hl] ; $5ca3
	cp $ff ; $5ca4
	ret z ; $5ca6
	farcall LoadEffectFrameTiles_28 ; $5ca7
	ret ; $5caa
TreasureBoxSpriteAnimFrames:
	; $5cab, 32 bytes (bytes:8)
	db $00, $ff, $ff, $ff, $ff, $ff, $ff, $01 ; 0x00
	db $ff, $ff, $ff, $ff, $ff, $02, $ff, $ff ; 0x08
	db $ff, $ff, $ff, $ff, $03, $ff, $ff, $ff ; 0x10
	db $ff, $ff, $04, $ff, $ff, $ff, $ff, $ff ; 0x18
DrawTreasureBoxHitCountdown:
	call ProjectTreasureBoxWorldPosition ; $5ccb
	ld c, $3c ; $5cce
	ld a, [wMinigameSceneActor + 3] ; $5cd0
	call QueueMinigameHitBurstFirstFour ; $5cd3
	ret ; $5cd6
; Instruction-identical to ProjectMedallionMatchWorldPosition (in this bank); a change here belongs in every copy.
	twin_named project_medallion_match_world_position, ProjectTreasureBoxWorldPosition ; $5cd7
MinigameConfig_MedallionMatch:
	; $5cea, 16 bytes
	drill_def CHAR_LUIGI, COURT_MEDALLION_MATCH, 2, GAMEMODE_MARIO_MINIGAME, MINIGAME_MEDALLION_MATCH, BGM_TARGET_MINIGAMES, CHAR_WALUIGI, MinigameHooks_MedallionMatch, MinigamePointLayoutDuo, InitMinigame_MedallionMatch
InitMinigame_MedallionMatch:
	ld a, $01 ; $5cfa
	ld [wMinigameUsesTennisMachine], a ; $5cfc
	ld a, [wMinigameLevel] ; $5cff
	cp $02 ; $5d02
	jr nz, .done ; $5d04
	ld a, $01 ; $5d06
	ld [wMinigameHighScoreMode], a ; $5d08
.done:
	ret ; $5d0b
MinigameHooks_MedallionMatch:
	; $5d0c, 16 bytes (mode_hooks)
	dw MedallionMatchHook_PerFrame ; record 0
	dw MedallionMatchHook_PointStart ; record 1
	dw MedallionMatchHook_PointEnd ; record 2
	dw MedallionMatchHook_MinigameStart ; record 3
	dw MedallionMatchHook_BallHit ; record 4
	dw MedallionMatchHook_Bounce ; record 5
	dw MedallionMatchHook_RallyTick ; record 6
	dw MedallionMatchHook_Draw ; record 7
MedallionMatchHook_MinigameStart:
	call SpawnMedallionMatchTargets ; $5d1c
	ld a, $01 ; $5d1f
	ld [wMinigameServeSlot], a ; $5d21
	call StartMinigameMatch ; $5d24
	xor a ; $5d27
	ld [wStandingShadowsEnabled], a ; $5d28
	ret ; $5d2b
Unused_0d:
	; $5d2c, 6 bytes (records:2)
	dw $0064 ; record 0
	dw $012c ; record 1
	dw $270f ; record 2
MedallionMatchHook_PerFrame:
	call DrawMinigameScoreHud ; $5d32
	call UpdateScorePopup ; $5d35
	ret ; $5d38
MedallionMatchHook_Draw:
	call UpdateMinigameActors ; $5d39
	ret ; $5d3c
MedallionMatchHook_PointStart:
	farcall AdvanceMatchRng ; $5d3d
	and $01 ; $5d40
	inc a ; $5d42
	ld hl, wMinigameServeSlot ; $5d43
	add [hl] ; $5d46
	cp $03 ; $5d47
	jr c, .store ; $5d49
	sub $03 ; $5d4b
.store:
	ld [hl], a ; $5d4d
	call LaunchMinigameServe ; $5d4e
	call ResetMedallionMatchHitState ; $5d51
	ret ; $5d54
MedallionMatchHook_PointEnd:
	call EndMinigamePoint ; $5d55
	ret ; $5d58
MedallionMatchHook_RallyTick:
	call KeepMinigameCameraFixed ; $5d59
	ret ; $5d5c
MedallionMatchHook_Bounce:
	call CheckMinigameStartBannerTrigger ; $5d5d
	ret ; $5d60
MedallionMatchHook_BallHit:
	call FreezeMinigameOpponentOnReturn ; $5d61
	ret ; $5d64
SpawnMedallionMatchTargets:
	call ClearMinigameActors ; $5d65
	ld hl, $0040 ; $5d68
	ld de, rJOYP ; $5d6b
	ld bc, wMinigameActors ; $5d6e
	ld a, $00 ; $5d71
	call InitMedallionMatchTargetActor ; $5d73
	ld hl, $0080 ; $5d76
	ld de, $fe40 ; $5d79
	ld bc, wMinigameActors + 16 ; $5d7c
	ld a, $01 ; $5d7f
	call InitMedallionMatchTargetActor ; $5d81
	ld hl, $00c0 ; $5d84
	ld de, $fd80 ; $5d87
	ld bc, wMinigameActors + 32 ; $5d8a
	ld a, $02 ; $5d8d
	call InitMedallionMatchTargetActor ; $5d8f
	ld hl, $ffc0 ; $5d92
	ld de, rJOYP ; $5d95
	ld bc, wMinigameActors + 48 ; $5d98
	ld a, $03 ; $5d9b
	call InitMedallionMatchTargetActor ; $5d9d
	ld hl, $ff80 ; $5da0
	ld de, $fe40 ; $5da3
	ld bc, wMinigameActors + 64 ; $5da6
	ld a, $04 ; $5da9
	call InitMedallionMatchTargetActor ; $5dab
	ld hl, rLCDC ; $5dae
	ld de, $fd80 ; $5db1
	ld bc, wMinigameActors + 80 ; $5db4
	ld a, $05 ; $5db7
	call InitMedallionMatchTargetActor ; $5db9
	ret ; $5dbc
InitMedallionMatchTargetActor:
	push af ; $5dbd
	push bc ; $5dbe
	push de ; $5dbf
	push hl ; $5dc0
	ld de, MedallionMatchTargetActorHandler ; $5dc1
	call SetMinigameActorHandler ; $5dc4
	pop hl ; $5dc7
	pop de ; $5dc8
	pop bc ; $5dc9
	pop af ; $5dca
	push hl ; $5dcb
	ld hl, $0001 ; $5dcc
	add hl, bc ; $5dcf
	ld [hl], a ; $5dd0
	pop hl ; $5dd1
	call SetMinigameActorPosition ; $5dd2
	ret ; $5dd5
ResetMedallionMatchHitState:
	xor a ; $5dd6
	ld [wMinigameHitStreak], a ; $5dd7
	xor a ; $5dda
	ld [wMinigameActors + 2], a ; $5ddb
	ld [wMinigameActors + 18], a ; $5dde
	ld [wMinigameActors + 34], a ; $5de1
	ld [wMinigameActors + 50], a ; $5de4
	ld [wMinigameActors + 66], a ; $5de7
	ld [wMinigameActors + 82], a ; $5dea
	ret ; $5ded
MedallionMatchTargetActorHandler:
	ld a, [wMinigameSceneActor + 2] ; $5dee
	rst Rst00 ; $5df1
	dw MedallionMatchTargetState0 ; $5df2 jumptable
	dw MedallionMatchTargetState1 ; $5df4 jumptable
	dw MedallionMatchTargetState2 ; $5df6 jumptable
	dw MedallionMatchTargetState3 ; $5df8 jumptable
	dw RetStub ; $5dfa jumptable
AdvanceMedallionMatchActorState:
	ld hl, wMinigameSceneActor + 2 ; $5dfc
	inc [hl] ; $5dff
	ret ; $5e00
MedallionMatchTargetState0:
	call AdvanceMedallionMatchActorState ; $5e01
MedallionMatchTargetState1:
	call DrawMedallionMatchSprite ; $5e04
	call IsBallInMedallionMatchHitZone ; $5e07
	and a ; $5e0a
	ret z ; $5e0b
	call AwardMedallionMatchHitScore ; $5e0c
	jp AdvanceMedallionMatchActorState ; $5e0f
MedallionMatchTargetState2:
	call DrawMedallionMatchHitCountdown ; $5e12
	ld hl, wMinigameSceneActor + 3 ; $5e15
	dec [hl] ; $5e18
	ld a, [hl] ; $5e19
	and a ; $5e1a
	ret nz ; $5e1b
	ld hl, wMinigameSceneActor + 8 ; $5e1c
	ld a, [hl+] ; $5e1f
	ld d, [hl] ; $5e20
	ld e, a ; $5e21
	farcall AdvanceMatchRng ; $5e22
	ld h, $00 ; $5e25
	ld l, a ; $5e27
	add hl, hl ; $5e28
	ld bc, $ff00 ; $5e29
	add hl, bc ; $5e2c
	call SetMinigameActorWorldPos ; $5e2d
	jp AdvanceMedallionMatchActorState ; $5e30
MedallionMatchTargetState3:
	call DrawMedallionMatchSprite ; $5e33
	ret ; $5e36
; Instruction-identical to IsBallInTreasureBoxHitZone (in this bank); a change here belongs in every copy.
	twin_named is_ball_in_medallion_match_hit_zone, IsBallInMedallionMatchHitZone ; $5e37
AwardMedallionMatchHitScore:
	ld a, $10 ; $5e9e
	ld [wMinigameSceneActor + 3], a ; $5ea0
	ld hl, $0001 ; $5ea3
	ld a, [wCurrentShotType] ; $5ea6
	cp SHOTTYPE_SMASH ; $5ea9
	jr nz, .step ; $5eab
	ld a, $20 ; $5ead
	ld [wMinigameSceneActor + 3], a ; $5eaf
	ld hl, $0002 ; $5eb2
.step:
	ld a, [wMinigameHitStreak] ; $5eb5
	ld_de_indexed MedallionMatchHitStreakSounds ; $5eb8
	ld a, [de] ; $5ebf
	call PlaySoundManaged ; $5ec0
	ld a, [wMinigameHitStreak] ; $5ec3
	ld_de_indexed MedallionMatchHitStreakMultipliers ; $5ec6
	ld a, [de] ; $5ecd
	call MulHLByA ; $5ece
	ld e, l ; $5ed1
	ld d, h ; $5ed2
	ld hl, wScorePopupValue ; $5ed3
	ld a, e ; $5ed6
	ld [hl+], a ; $5ed7
	ld [hl], d ; $5ed8
	call AddToMinigameScore ; $5ed9
	call StartScorePopup ; $5edc
	ld hl, wMinigameHitStreak ; $5edf
	inc [hl] ; $5ee2
	ret ; $5ee3
MedallionMatchHitStreakSounds:
	; $5ee4, 8 bytes (bytes:8)
	db $c0, $bf, $be, $bd, $bc, $bb, $ba, $ba ; 0x00
MedallionMatchHitStreakMultipliers:
	; $5eec, 6 bytes (bytes:6)
	db $01, $05, $1e, $46, $96, $fa ; 0x00
DrawMedallionMatchSprite:
	call ProjectMedallionMatchWorldPosition ; $5ef2
	ldh a, [hVBlankCounter] ; $5ef5
	ld hl, wMinigameSceneActor + 10 ; $5ef7
	add [hl] ; $5efa
	srl a ; $5efb
	srl a ; $5efd
	srl a ; $5eff
	and $03 ; $5f01
	ld_hl_indexed MedallionMatchSpriteAnimFrames ; $5f03
	ld c, [hl] ; $5f0a
	call QueueSprite16 ; $5f0b
	ret ; $5f0e
MedallionMatchSpriteAnimFrames:
	; $5f0f, 4 bytes (bytes:4)
	db $20, $24, $28, $2c ; 0x00
DrawMedallionMatchHitCountdown:
	call ProjectMedallionMatchWorldPosition ; $5f13
	ld c, $3c ; $5f16
	ld a, [wMinigameSceneActor + 3] ; $5f18
	call QueueMinigameHitBurstFirstTwo ; $5f1b
	ret ; $5f1e
; Instruction-identical to ProjectTreasureBoxWorldPosition (in this bank); a change here belongs in every copy.
	twin_named project_medallion_match_world_position, ProjectMedallionMatchWorldPosition ; $5f1f
MinigameConfig_FruitFantasy:
	; $5f32, 16 bytes
	drill_def CHAR_ALEX, COURT_FRUIT_FANTASY, 1, GAMEMODE_MARIO_MINIGAME, MINIGAME_FRUIT_FANTASY, BGM_COURT_TROPIC, CHAR_YOSHI, MinigameHooks_FruitFantasy, MinigamePointLayoutSolo, InitMinigame_FruitFantasy
InitMinigame_FruitFantasy:
	farcall InitMinigameTargets ; $5f42
	ld a, $06 ; $5f45
	farcall SpawnMinigameTargetFormation ; $5f47
	ld a, $01 ; $5f4a
	ld [wMinigameTargetsAltMode], a ; $5f4c
	ld a, $01 ; $5f4f
	ld [wMinigameUsesWall], a ; $5f51
	ld a, [wMinigameLevel] ; $5f54
	cp $02 ; $5f57
	jr nz, .done ; $5f59
	ld a, $01 ; $5f5b
	ld [wMinigameHighScoreMode], a ; $5f5d
.done:
	ret ; $5f60
MinigameHooks_FruitFantasy:
	; $5f61, 16 bytes (mode_hooks)
	dw FruitFantasyHook_PerFrame ; record 0
	dw FruitFantasyHook_PointStart ; record 1
	dw FruitFantasyHook_PointEnd ; record 2
	dw FruitFantasyHook_MinigameStart ; record 3
	dw FruitFantasyHook_BallHit ; record 4
	dw FruitFantasyHook_Bounce ; record 5
	dw FruitFantasyHook_RallyTick ; record 6
	dw RetStub ; record 7
FruitFantasyHook_MinigameStart:
	ret ; $5f71
FruitFantasyHook_PerFrame:
	call UpdateMinigameHudAndBallTrail ; $5f72
	call UpdateFruitFantasyTargetHits ; $5f75
	ret ; $5f78
FruitFantasyHook_PointStart:
	call StartMinigameSoloPoint ; $5f79
	ld a, [wMinigameLevel] ; $5f7c
	add a ; $5f7f
	ld_hl_indexed FruitFantasyGridLayoutsByLevel ; $5f80
	ld a, [hl+] ; $5f87
	ld h, [hl] ; $5f88
	ld l, a ; $5f89
	call CopyMinigameTilemapBlock ; $5f8a
	ret ; $5f8d
FruitFantasyGridLayoutsByLevel:
	; $5f8e, 6 bytes (records:2)
	dw FruitFantasyGridLayout0 ; record 0
	dw FruitFantasyGridLayout1 ; record 1
	dw FruitFantasyGridLayout2 ; record 2
FruitFantasyGridLayout0:
	; $5f94, 24 bytes (bytes:8)
	db $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
	db $00, $00, $00, $00, $00, $00, $00, $00 ; 0x08
	db $00, $00, $00, $00, $00, $00, $00, $00 ; 0x10
FruitFantasyGridLayout1:
	; $5fac, 24 bytes (bytes:8)
	db $00, $00, $05, $05, $00, $06, $00, $00 ; 0x00
	db $00, $00, $00, $00, $00, $00, $00, $00 ; 0x08
	db $00, $04, $00, $07, $07, $00, $00, $00 ; 0x10
FruitFantasyGridLayout2:
	; $5fc4, 24 bytes (bytes:8)
	db $00, $04, $04, $00, $06, $06, $00, $00 ; 0x00
	db $07, $00, $00, $05, $00, $00, $07, $00 ; 0x08
	db $00, $07, $07, $00, $07, $07, $00, $00 ; 0x10
FruitFantasyHook_PointEnd:
	call HandleMinigamePointEnd ; $5fdc
	ret ; $5fdf
FruitFantasyHook_RallyTick:
	call FruitFantasyReflectBallAndRecordCell ; $5fe0
	ret ; $5fe3
FruitFantasyHook_Bounce:
	call StubNop_0d_0 ; $5fe4
	ret ; $5fe7
FruitFantasyHook_BallHit:
	call HideLandingMarkerAndExtendSoloCourt ; $5fe8
	ret ; $5feb
UpdateFruitFantasyTargetHits:
	call ScoreMinigameTargetHitOrDeflectBall ; $5fec
	ret ; $5fef
FruitFantasyReflectBallAndRecordCell:
	call ReflectBallVelocity ; $5ff0
	call GetMinigameGridCellIndex ; $5ff3
	ld [wMinigameLastHitCell], a ; $5ff6
	ret ; $5ff9
	; $5ffa, 8198 bytes fill to bank end (linker-padded)
