PerfectShotLevelHasTargets:
	; $58a3, 3 bytes (bytes:3)
	db $00, $07, $08 ; 0x00
MinigameHooks_PerfectShot:
	; $58a6, 16 bytes (mode_hooks)
	dw PerfectShotHook_PerFrame ; record 0
	dw PerfectShotHook_PointStart ; record 1
	dw PerfectShotHook_PointEnd ; record 2
	dw RetStub ; record 3
	dw PerfectShotHook_BallHit ; record 4
	dw PerfectShotHook_Bounce ; record 5
	dw PerfectShotHook_RallyTick ; record 6
	dw RetStub ; record 7
PerfectShotHook_PerFrame:
	call UpdateMinigameHudAndBallTrail ; $58b6
	ret ; $58b9
PerfectShotHook_PointStart:
	call StartMinigameSoloPoint ; $58ba
	call ResetTargetGrid ; $58bd
	ret ; $58c0
PerfectShotHook_PointEnd:
	call HandleMinigamePointEnd ; $58c1
	ret ; $58c4
PerfectShotHook_RallyTick:
	call ProcessTargetTileHit ; $58c5
	ret ; $58c8
PerfectShotHook_Bounce:
	call StubNop_0d_0 ; $58c9
	ret ; $58cc
PerfectShotHook_BallHit:
	call HideLandingMarkerAndExtendSoloCourt ; $58cd
	ret ; $58d0
ProcessTargetTileHit:
	call ReflectBallVelocity ; $58d1
	call GetMinigameGridCellIndex ; $58d4
	cp $ff ; $58d7
	ret z ; $58d9
	ld b, a ; $58da
	add $c0 ; $58db
	ld l, a ; $58dd
	adc $c7 ; $58de
	sub l ; $58e0
	ld h, a ; $58e1
	ld a, [hl] ; $58e2
	cp $01 ; $58e3
	ret z ; $58e5
	push_wram_bank $02 ; $58e6
	ld a, $01 ; $58ef
	ld [hl], a ; $58f1
	ld a, b ; $58f2
	ld b, $01 ; $58f3
	call DrawMinigameGridCell ; $58f5
	farcall FlushTilemapToVram ; $58f8
	pop_wram_bank ; $58fb
	sound SFX_CHIME ; $5900
	ld a, [wTargetTileHit] ; $5902
	inc a ; $5905
	ld e, a ; $5906
	ld d, $00 ; $5907
	call AddToMinigameScore ; $5909
	call IsMinigameTargetReached ; $590c
	and a ; $590f
	jr z, .areAllTargetsHit ; $5910
	ld a, POINTOUTCOME_MINIGAME_CLEARED ; $5912
	ld [wPointOutcome], a ; $5914
	ret ; $5917
.areAllTargetsHit:
	call AreAllTargetsHit ; $5918
	and a ; $591b
	ret z ; $591c
	ld hl, wTargetTileHit ; $591d
	ld a, [hl] ; $5920
	cp $09 ; $5921
	jr nc, .ge09 ; $5923
	inc [hl] ; $5925
.ge09:
	push_wram_bank $02 ; $5926
	ld a, $01 ; $592f
	ld [wMatchSimFrozen], a ; $5931
	call AnimateTargetGridClear ; $5934
	xor a ; $5937
	ld [wMatchSimFrozen], a ; $5938
	pop_wram_bank ; $593b
	ret ; $5940
PerfectShotTargetGridLayout:
	; $5941, 24 bytes (bytes:8)
	db $02, $02, $02, $02, $02, $02, $02, $00 ; 0x00
	db $02, $02, $02, $02, $02, $02, $02, $00 ; 0x08
	db $03, $03, $03, $03, $03, $03, $03, $00 ; 0x10
	; $5959, 32 bytes (bytes:8)
	db $01, $01, $01, $01, $01, $01, $01, $00 ; 0x00
	db $01, $01, $01, $01, $01, $01, $01, $00 ; 0x08
	db $01, $01, $01, $03, $01, $01, $01, $00 ; 0x10
	db $03, $03, $03, $03, $03, $03, $03, $00 ; 0x18
ResetTargetGrid:
	ld hl, PerfectShotTargetGridLayout ; $5979
	call CopyMinigameTilemapBlock ; $597c
	ld a, $01 ; $597f
	ld [wMinigameTargetGrid + 7], a ; $5981
	ld [wMinigameTargetGrid + 15], a ; $5984
	ld [wMinigameTargetGrid + 23], a ; $5987
	ret ; $598a
AnimateTargetGridClear:
	ld a, $02 ; $598b
	farcall StepMatchFrames ; $598d
	ld hl, PerfectShotTargetGridLayout ; $5990
	ld b, $18 ; $5993
	ld c, $00 ; $5995
.loop:
	ld a, [hl+] ; $5997
	cp $00 ; $5998
	jr z, .eq00 ; $599a
	push bc ; $599c
	push hl ; $599d
	ld b, a ; $599e
	ld a, c ; $599f
	call DrawMinigameGridCell ; $59a0
	farcall FlushTilemapToVram ; $59a3
	sound SFX_GRID_CLEAR ; $59a6
	ld a, $08 ; $59a8
	farcall StepMatchFrames ; $59aa
	pop hl ; $59ad
	pop bc ; $59ae
.eq00:
	inc c ; $59af
	dec b ; $59b0
	jr nz, .loop ; $59b1
	call ResetTargetGrid ; $59b3
	ret ; $59b6
AreAllTargetsHit:
	ld hl, wMinigameTargetGrid ; $59b7
	ld c, $18 ; $59ba
	xor a ; $59bc
.loop:
	ld a, [hl+] ; $59bd
	cp $01 ; $59be
	jr nz, .ne01 ; $59c0
	dec c ; $59c2
	jr nz, .loop ; $59c3
	ld a, $01 ; $59c5
	ret ; $59c7
.ne01:
	ld a, $00 ; $59c8
	ret ; $59ca
MinigameConfig_TreasureBox:
	; $59cb, 16 bytes (bytes:16)
	db $1b, $14, $02, $08, $22, $14, $00, $1e, $ed, $59, $bd, $40, $db, $59, $00, $00 ; 0x00
InitMinigame_TreasureBox:
	ld a, $01 ; $59db
	ld [wMinigameUsesTennisMachine], a ; $59dd
	ld a, [wMinigameLevel] ; $59e0
	cp $02 ; $59e3
	jr nz, .done ; $59e5
	ld a, $01 ; $59e7
	ld [wMinigameHighScoreMode], a ; $59e9
.done:
	ret ; $59ec
MinigameHooks_TreasureBox:
	; $59ed, 16 bytes (mode_hooks)
	dw TreasureBoxHook_PerFrame ; record 0
	dw TreasureBoxHook_PointStart ; record 1
	dw TreasureBoxHook_PointEnd ; record 2
	dw TreasureBoxHook_MinigameStart ; record 3
	dw TreasureBoxHook_BallHit ; record 4
	dw TreasureBoxHook_Bounce ; record 5
	dw TreasureBoxHook_RallyTick ; record 6
	dw TreasureBoxHook_Draw ; record 7
TreasureBoxHook_MinigameStart:
	call ClearMinigameActors ; $59fd
	ld a, $01 ; $5a00
	ld [wMinigameServeSlot], a ; $5a02
	call StartMinigameMatch ; $5a05
	ld a, $01 ; $5a08
	ld [wTargetZoneEnabled], a ; $5a0a
	ld de, TreasureBoxTargetActorHandler ; $5a0d
	ld bc, wMinigameActors ; $5a10
	call SetMinigameActorHandler ; $5a13
	ret ; $5a16
TreasureBoxHook_PerFrame:
	call DrawMinigameScoreHud ; $5a17
	call UpdateTreasureBoxScorePopup ; $5a1a
	ret ; $5a1d
TreasureBoxHook_Draw:
	call UpdateMinigameActors ; $5a1e
	ret ; $5a21
TreasureBoxHook_PointStart:
	call SelectRandomTreasureBoxTargetZone ; $5a22
	farcall AdvanceMatchRng ; $5a25
	and $01 ; $5a28
	inc a ; $5a2a
	ld hl, wMinigameServeSlot ; $5a2b
	add [hl] ; $5a2e
	cp $03 ; $5a2f
	jr c, .store ; $5a31
	sub $03 ; $5a33
.store:
	ld [hl], a ; $5a35
	call LaunchMinigameServe ; $5a36
	ret ; $5a39
TreasureBoxHook_PointEnd:
	call StubNop_0d_3 ; $5a3a
	call EndMinigamePoint ; $5a3d
	ret ; $5a40
TreasureBoxHook_RallyTick:
	call KeepMinigameCameraFixed ; $5a41
	ret ; $5a44
TreasureBoxHook_Bounce:
	ld a, [wPointOutcome] ; $5a45
	and a ; $5a48
	ret nz ; $5a49
	call CheckMinigameStartBannerTrigger ; $5a4a
	call CheckBallLandedOut ; $5a4d
	ld a, [wPointOutcome] ; $5a50
	cp POINTOUTCOME_WINNER ; $5a53
	ret nz ; $5a55
	ld de, $0001 ; $5a56
	ld hl, wScorePopupValue ; $5a59
	ld a, e ; $5a5c
	ld [hl+], a ; $5a5d
	ld [hl], d ; $5a5e
	call AddToMinigameScore ; $5a5f
	call StartScorePopup ; $5a62
	sound SFX_CHIME ; $5a65
	ret ; $5a67
TreasureBoxHook_BallHit:
	call FreezeMinigameOpponentOnReturn ; $5a68
	ret ; $5a6b
UpdateTreasureBoxScorePopup:
	call UpdateScorePopup ; $5a6c
	ret ; $5a6f
SelectRandomTreasureBoxTargetZone:
	ld a, [wMinigameLevel] ; $5a70
	add a ; $5a73
	ld_hl_indexed TreasureBoxZonePoolsByLevel ; $5a74
	ld a, [hl+] ; $5a7b
	ld h, [hl] ; $5a7c
	ld l, a ; $5a7d
	farcall AdvanceMatchRng ; $5a7e
	and $0f ; $5a81
	add l ; $5a83
	ld l, a ; $5a84
	jr nc, .read ; $5a85
	inc h ; $5a87
.read:
	ld a, [hl] ; $5a88
	ld [wMinigameShotRoll], a ; $5a89
	ld a, [wMinigameShotRoll] ; $5a8c
	call LoadTargetZoneConfig ; $5a8f
	ld a, [wMinigameHitScored] ; $5a92
	and a ; $5a95
	jr nz, .nonZero ; $5a96
	xor a ; $5a98
	ld [wMinigameHitStreak], a ; $5a99
.nonZero:
	xor a ; $5a9c
	ld [wMinigameHitScored], a ; $5a9d
	xor a ; $5aa0
	ld [wMinigameActors + 2], a ; $5aa1
	ret ; $5aa4
TreasureBoxZonePoolsByLevel:
	; $5aa5, 6 bytes (records:2)
	dw TreasureBoxZonePool0 ; record 0
	dw TreasureBoxZonePool1 ; record 1
	dw TreasureBoxZonePool1 ; record 2
TreasureBoxZonePool0:
	; $5aab, 16 bytes (bytes:16)
	db $00, $00, $00, $00, $01, $01, $01, $01, $04, $04, $04, $04, $00, $00, $01, $01 ; 0x00
TreasureBoxZonePool1:
	; $5abb, 16 bytes (bytes:16)
	db $00, $00, $00, $00, $01, $01, $01, $01, $04, $04, $04, $04, $02, $02, $03, $03 ; 0x00
StubNop_0d_3:
	ret ; $5acb
TreasureBoxTargetActorHandler:
	ld a, [wMinigameSceneActor + 2] ; $5acc
	rst Rst00 ; $5acf
	dw AdvanceTreasureBoxActorState.step ; $5ad0 jumptable
	dw AdvanceTreasureBoxActorState.drawTreasureBoxSprite ; $5ad2 jumptable
	dw AdvanceTreasureBoxActorState.drawTreasureBoxHitCountdown ; $5ad4 jumptable
	dw AdvanceTreasureBoxActorState.done ; $5ad6 jumptable
	dw RetStub ; $5ad8 jumptable
AdvanceTreasureBoxActorState:
	ld hl, wMinigameSceneActor + 2 ; $5ada
	inc [hl] ; $5add
	ret ; $5ade
.step:
	xor a ; $5adf
	ld [wTreasureBoxState], a ; $5ae0
	ld hl, wMinigameServeCount ; $5ae3
	ld a, [hl+] ; $5ae6
	ld h, [hl] ; $5ae7
	ld l, a ; $5ae8
	ld de, $fff5 ; $5ae9
	add hl, de ; $5aec
	bit 7, h ; $5aed
	ld hl, TreasureBoxTypePoolLate ; $5aef
	jr z, .advanceMatchRng ; $5af2
	ld hl, TreasureBoxTypePoolEarly ; $5af4
.advanceMatchRng:
	farcall AdvanceMatchRng ; $5af7
	and $0f ; $5afa
	add l ; $5afc
	ld l, a ; $5afd
	jr nc, .read ; $5afe
	inc h ; $5b00
.read:
	ld a, [hl] ; $5b01
	ld [wMinigameSceneActor + 1], a ; $5b02
	ld a, [wMinigameShotRoll] ; $5b05
	add a ; $5b08
	ld_hl_indexed TreasureBoxSpawnPointsByZone ; $5b09
	ld a, [hl+] ; $5b10
	ld h, [hl] ; $5b11
	ld l, a ; $5b12
	farcall AdvanceMatchRng ; $5b13
	and $03 ; $5b16
	add a ; $5b18
	add a ; $5b19
	add l ; $5b1a
	ld l, a ; $5b1b
	jr nc, .readB ; $5b1c
	inc h ; $5b1e
.readB:
	ld a, [hl+] ; $5b1f
	ld c, a ; $5b20
	ld a, [hl+] ; $5b21
	ld b, a ; $5b22
	ld a, [hl+] ; $5b23
	ld e, a ; $5b24
	ld a, [hl+] ; $5b25
	ld d, a ; $5b26
	ld l, c ; $5b27
	ld h, b ; $5b28
	call SetMinigameActorWorldPos ; $5b29
	call AdvanceTreasureBoxActorState ; $5b2c
.drawTreasureBoxSprite:
	call DrawTreasureBoxSprite ; $5b2f
	call IsBallInTreasureBoxHitZone ; $5b32
	and a ; $5b35
	ret z ; $5b36
	call AwardTreasureBoxHitScore ; $5b37
	jp AdvanceTreasureBoxActorState ; $5b3a
.drawTreasureBoxHitCountdown:
	call DrawTreasureBoxHitCountdown ; $5b3d
	ld hl, wMinigameSceneActor + 3 ; $5b40
	dec [hl] ; $5b43
	ld a, [hl] ; $5b44
	and a ; $5b45
	ret nz ; $5b46
	jp AdvanceTreasureBoxActorState ; $5b47
.done:
	ret ; $5b4a
TreasureBoxTypePoolLate:
	; $5b4b, 16 bytes (bytes:16)
	db $00, $00, $00, $00, $00, $00, $03, $03, $01, $01, $01, $01, $01, $02, $02, $02 ; 0x00
TreasureBoxTypePoolEarly:
	; $5b5b, 16 bytes (bytes:16)
	db $00, $00, $00, $00, $00, $00, $01, $00, $01, $01, $01, $01, $01, $02, $02, $02 ; 0x00
TreasureBoxSpawnPointsByZone:
	; $5b6b, 10 bytes (records:2)
	dw TreasureBoxSpawnPoints0 ; record 0
	dw TreasureBoxSpawnPoints1 ; record 1
	dw TreasureBoxSpawnPoints2 ; record 2
	dw TreasureBoxSpawnPoints3 ; record 3
	dw TreasureBoxSpawnPoints4 ; record 4
TreasureBoxSpawnPoints0:
	; $5b75, 16 bytes (bytes:4)
	db $80, $ff, $80, $fe ; 0x00
	db $00, $ff, $00, $fe ; 0x04
	db $60, $ff, $80, $fd ; 0x08
	db $e0, $fe, $00, $fd ; 0x0c
TreasureBoxSpawnPoints1:
	; $5b85, 16 bytes (bytes:4)
	db $80, $00, $80, $fe ; 0x00
	db $00, $01, $00, $fe ; 0x04
	db $a0, $00, $80, $fd ; 0x08
	db $20, $01, $00, $fd ; 0x0c
TreasureBoxSpawnPoints2:
	; $5b95, 16 bytes (bytes:4)
	db $a0, $00, $00, $fe ; 0x00
	db $20, $00, $00, $fe ; 0x04
	db $e0, $ff, $00, $fe ; 0x08
	db $60, $ff, $00, $fe ; 0x0c
TreasureBoxSpawnPoints3:
	; $5ba5, 16 bytes (bytes:4)
	db $c0, $00, $00, $fd ; 0x00
	db $40, $00, $00, $fd ; 0x04
	db $c0, $ff, $00, $fd ; 0x08
	db $40, $ff, $00, $fd ; 0x0c
TreasureBoxSpawnPoints4:
	; $5bb5, 16 bytes (bytes:4)
	db $00, $00, $00, $fd ; 0x00
	db $00, $00, $80, $fe ; 0x04
	db $00, $01, $c0, $fd ; 0x08
	db $00, $ff, $c0, $fd ; 0x0c
; Instruction-identical to IsBallInMedallionMatchHitZone (in this bank); a change here belongs in every copy.
IsBallInTreasureBoxHitZone:
	ld a, [wLastShotCharIndex] ; $5bc5
	and $01 ; $5bc8
	jp nz, .returnZero ; $5bca
	ld hl, wMinigameSceneActor + 6 ; $5bcd
	ld a, [hl+] ; $5bd0
	ld d, [hl] ; $5bd1
	ld e, a ; $5bd2
	ld hl, wBallX ; $5bd3
	ld a, [hl+] ; $5bd6
	ld h, [hl] ; $5bd7
	ld l, a ; $5bd8
	ld a, l ; $5bd9
	sub e ; $5bda
	ld l, a ; $5bdb
	ld a, h ; $5bdc
	sbc d ; $5bdd
	ld h, a ; $5bde
	bit 7, h ; $5bdf
	jr z, .positive ; $5be1
	xor a ; $5be3
	sub l ; $5be4
	ld l, a ; $5be5
	sbc a ; $5be6
	sub h ; $5be7
	ld h, a ; $5be8
.positive:
	ld de, $ffa0 ; $5be9
	add hl, de ; $5bec
	jr c, .returnZero ; $5bed
	ld hl, wMinigameSceneActor + 8 ; $5bef
	ld a, [hl+] ; $5bf2
	ld d, [hl] ; $5bf3
	ld e, a ; $5bf4
	ld hl, wBallDepth ; $5bf5
	ld a, [hl+] ; $5bf8
	ld h, [hl] ; $5bf9
	ld l, a ; $5bfa
	ld a, l ; $5bfb
	sub e ; $5bfc
	ld l, a ; $5bfd
	ld a, h ; $5bfe
	sbc d ; $5bff
	ld h, a ; $5c00
	bit 7, h ; $5c01
	jr z, .positive2 ; $5c03
	xor a ; $5c05
	sub l ; $5c06
	ld l, a ; $5c07
	sbc a ; $5c08
	sub h ; $5c09
	ld h, a ; $5c0a
.positive2:
	ld de, $ff80 ; $5c0b
	add hl, de ; $5c0e
	jr c, .returnZero ; $5c0f
	ld hl, wBallHeight ; $5c11
	ld a, [hl+] ; $5c14
	ld h, [hl] ; $5c15
	ld l, a ; $5c16
	bit 7, h ; $5c17
	jr z, .positive3 ; $5c19
	xor a ; $5c1b
	sub l ; $5c1c
	ld l, a ; $5c1d
	sbc a ; $5c1e
	sub h ; $5c1f
	ld h, a ; $5c20
.positive3:
	ld de, $ff40 ; $5c21
	add hl, de ; $5c24
	jr c, .returnZero ; $5c25
	ld a, $01 ; $5c27
	ret ; $5c29
.returnZero:
	xor a ; $5c2a
	ret ; $5c2b
