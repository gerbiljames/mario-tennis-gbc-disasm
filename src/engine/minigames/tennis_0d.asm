ApplyMinigameCharTargetFromTable:
	push_wram_bank WRAM_TEXT ; $48b6
	ld a, [wMinigameServeSlot] ; $48bf
	call GetMinigameCharCoordsEntry ; $48c2
	farcall SetCharTarget ; $48c5
	pop_wram_bank ; $48c8
	ret ; $48cd
PlayMinigameCountdown:
	wram_bank WRAM_ACTORS ; $48ce
	xor a ; $48d4
	ld [wPauseDisabled], a ; $48d5
	ld a, [wCurrentBGM] ; $48d8
	push af ; $48db
	sound BGM_NONE ; $48dc
	ld a, $14 ; $48de
	farcall StepMatchFrames ; $48e0
	ld a, $03 ; $48e3
.loop:
	push af ; $48e5
	ld b, $01 ; $48e6
	ld de, vTiles0 + $20 * TILE_SIZE ; $48e8
	farcall LoadScoreDigitGfx ; $48eb
	ld a, [wMatchFramesAbort] ; $48ee
	and a ; $48f1
	jr nz, .nonZero ; $48f2
	sound SFX_COUNTDOWN ; $48f4
.nonZero:
	ld a, $11 ; $48f6
	farcall SpawnCourtBannerObj ; $48f8
	ld a, $28 ; $48fb
	farcall StepMatchFrames ; $48fd
	pop af ; $4900
	dec a ; $4901
	jr nz, .loop ; $4902
	ld a, [wMatchFramesAbort] ; $4904
	and a ; $4907
	jr nz, .nonZero2 ; $4908
	sound SFX_COUNTDOWN_GO ; $490a
.nonZero2:
	ld a, $10 ; $490c
	farcall ShowCourtBanner ; $490e
	ld a, $28 ; $4911
	farcall StepMatchFrames ; $4913
	farcall HideCourtBanner ; $4916
	pop af ; $4919
	ld b, a ; $491a
	ld a, [wMatchFramesAbort] ; $491b
	and a ; $491e
	jr nz, .done ; $491f
	ld a, b ; $4921
	call PlaySoundManaged ; $4922
.done:
	ret ; $4925
GetMinigameCharCoordsEntry:
	add a ; $4926
	add a ; $4927
	ld_hl_indexed MinigameCharCoordsTable ; $4928
	ld a, [hl+] ; $492f
	ld c, a ; $4930
	ld a, [hl+] ; $4931
	ld b, a ; $4932
	ld a, [hl+] ; $4933
	ld e, a ; $4934
	ld a, [hl+] ; $4935
	ld d, a ; $4936
	ld l, c ; $4937
	ld h, b ; $4938
	ret ; $4939
; Instruction-identical to SnapCameraTo (one copy per bank); a change here belongs in every copy.
	twin_named snap_camera_to, SnapCameraTo_0d ; $493a
MinigameConfig_TennisMachine2:
	; $4959, 16 bytes (bytes:16)
	db $15, $0a, $02, $06, $13, $1e, $00, $80, $74, $49, $bd, $40, $69, $49, $00, $00 ; 0x00
InitMinigame_TennisMachine2:
	ld a, $01 ; $4969
	ld [wMinigameUsesTennisMachine], a ; $496b
	ld a, $01 ; $496e
	ld [wMinigameLevel], a ; $4970
	ret ; $4973
MinigameHooks_TennisMachine2:
	; $4974, 16 bytes (mode_hooks)
	dw TennisMachine2Hook_PerFrame ; record 0
	dw TennisMachine2Hook_PointStart ; record 1
	dw TennisMachine2Hook_PointEnd ; record 2
	dw TennisMachine2Hook_MinigameStart ; record 3
	dw TennisMachine2Hook_BallHit ; record 4
	dw TennisMachine2Hook_Bounce ; record 5
	dw TennisMachine2Hook_RallyTick ; record 6
	dw RetStub ; record 7
TennisMachine2Hook_MinigameStart:
	ld a, $01 ; $4984
	ld [wMinigameServeSlot], a ; $4986
	call StartMinigameMatch ; $4989
	ret ; $498c
TennisMachine2Hook_PerFrame:
	call DrawMinigameScoreHud ; $498d
	ret ; $4990
TennisMachine2Hook_PointStart:
	farcall AdvanceMatchRng ; $4991
	and $01 ; $4994
	inc a ; $4996
	ld hl, wMinigameServeSlot ; $4997
	add [hl] ; $499a
	cp $03 ; $499b
	jr c, .store ; $499d
	sub $03 ; $499f
.store:
	ld [hl], a ; $49a1
	call LaunchMinigameServe ; $49a2
	ret ; $49a5
TennisMachine2Hook_PointEnd:
	call AwardMinigamePointAndEnd ; $49a6
	ret ; $49a9
TennisMachine2Hook_RallyTick:
	call KeepMinigameCameraFixed ; $49aa
	ret ; $49ad
TennisMachine2Hook_Bounce:
	call CheckMinigameStartBannerTrigger ; $49ae
	ret ; $49b1
TennisMachine2Hook_BallHit:
	call FreezeMinigameOpponentOnReturn ; $49b2
	ret ; $49b5
MinigameConfig_TennisMachine3:
	dec d ; $49b6
	ld a, [bc] ; $49b7
	ld [bc], a ; $49b8
	ld b, $14 ; $49b9
	ld e, $00 ; $49bb
	add b ; $49bd
	pop de ; $49be
	ld c, c ; $49bf
	cp l ; $49c0
	ld b, b ; $49c1
	add $49 ; $49c2
	nop ; $49c4
	nop ; $49c5
InitMinigame_TennisMachine3:
	ld a, $01 ; $49c6
	ld [wMinigameUsesTennisMachine], a ; $49c8
	ld a, $02 ; $49cb
	ld [wMinigameLevel], a ; $49cd
	ret ; $49d0
MinigameHooks_TennisMachine3:
	; $49d1, 16 bytes (mode_hooks)
	dw TennisMachine3Hook_PerFrame ; record 0
	dw TennisMachine3Hook_PointStart ; record 1
	dw TennisMachine3Hook_PointEnd ; record 2
	dw TennisMachine3Hook_MinigameStart ; record 3
	dw TennisMachine3Hook_BallHit ; record 4
	dw TennisMachine3Hook_Bounce ; record 5
	dw TennisMachine3Hook_RallyTick ; record 6
	dw RetStub ; record 7
TennisMachine3Hook_MinigameStart:
	ld a, $04 ; $49e1
	ld [wMinigameServeSlot], a ; $49e3
	call StartMinigameMatch ; $49e6
	ret ; $49e9
TennisMachine3Hook_PerFrame:
	call DrawMinigameScoreHud ; $49ea
	ret ; $49ed
TennisMachine3Hook_PointStart:
	farcall AdvanceMatchRng ; $49ee
	and $03 ; $49f1
	inc a ; $49f3
	ld hl, wMinigameServeSlot ; $49f4
	add [hl] ; $49f7
	cp $06 ; $49f8
	jr c, .store ; $49fa
	sub $06 ; $49fc
.store:
	ld [hl], a ; $49fe
	call LaunchMinigameServe ; $49ff
	ret ; $4a02
TennisMachine3Hook_PointEnd:
	call AwardMinigamePointAndEnd ; $4a03
	ret ; $4a06
TennisMachine3Hook_RallyTick:
	call KeepMinigameCameraFixed ; $4a07
	ret ; $4a0a
TennisMachine3Hook_Bounce:
	call CheckMinigameStartBannerTrigger ; $4a0b
	ret ; $4a0e
TennisMachine3Hook_BallHit:
	call FreezeMinigameOpponentOnReturn ; $4a0f
	ret ; $4a12
MinigameConfig_TennisMachine4:
	dec d ; $4a13
	ld a, [bc] ; $4a14
	ld [bc], a ; $4a15
	ld b, $15 ; $4a16
	ld e, $00 ; $4a18
	add b ; $4a1a
	ld l, $4a ; $4a1b
	cp l ; $4a1d
	ld b, b ; $4a1e
	inc hl ; $4a1f
	ld c, d ; $4a20
	nop ; $4a21
	nop ; $4a22
InitMinigame_TennisMachine4:
	ld a, $01 ; $4a23
	ld [wMinigameUsesTennisMachine], a ; $4a25
	ld a, $03 ; $4a28
	ld [wMinigameLevel], a ; $4a2a
	ret ; $4a2d
MinigameHooks_TennisMachine4:
	; $4a2e, 16 bytes (mode_hooks)
	dw TennisMachine4Hook_PerFrame ; record 0
	dw TennisMachine4Hook_PointStart ; record 1
	dw TennisMachine4Hook_PointEnd ; record 2
	dw TennisMachine4Hook_MinigameStart ; record 3
	dw TennisMachine4Hook_BallHit ; record 4
	dw TennisMachine4Hook_Bounce ; record 5
	dw TennisMachine4Hook_RallyTick ; record 6
	dw RetStub ; record 7
TennisMachine4Hook_MinigameStart:
	ld a, $04 ; $4a3e
	ld [wMinigameServeSlot], a ; $4a40
	call StartMinigameMatch ; $4a43
	ret ; $4a46
TennisMachine4Hook_PerFrame:
	call DrawMinigameScoreHud ; $4a47
	ret ; $4a4a
; Instruction-identical to TennisMachineHighScoreHook_PointStart (in this bank); a change here belongs in every copy.
	twin_named tennis_machine4_hook__point_start, TennisMachine4Hook_PointStart ; $4a4b
TennisMachine4Hook_PointEnd:
	call AwardMinigamePointAndEnd ; $4a60
	ret ; $4a63
TennisMachine4Hook_RallyTick:
	call KeepMinigameCameraFixed ; $4a64
	ret ; $4a67
TennisMachine4Hook_Bounce:
	call CheckMinigameStartBannerTrigger ; $4a68
	ret ; $4a6b
TennisMachine4Hook_BallHit:
	call FreezeMinigameOpponentOnReturn ; $4a6c
	ret ; $4a6f
MinigameConfig_WallPractice1:
	nop ; $4a70
	dec bc ; $4a71
	ld bc, $1607 ; $4a72
	rra ; $4a75
	nop ; $4a76
	add b ; $4a77
	sub e ; $4a78
	ld c, d ; $4a79
	or h ; $4a7a
	ld b, b ; $4a7b
	add b ; $4a7c
	ld c, d ; $4a7d
	nop ; $4a7e
	nop ; $4a7f
InitMinigame_WallPractice1:
	ld a, $01 ; $4a80
	ld [wMinigameUsesWall], a ; $4a82
	ld a, $00 ; $4a85
	ld [wMinigameLevel], a ; $4a87
	farcall InitMinigameTargets ; $4a8a
	ld a, $00 ; $4a8d
	farcall SpawnMinigameTargetFormation ; $4a8f
	ret ; $4a92
MinigameHooks_WallPractice1:
	; $4a93, 16 bytes (mode_hooks)
	dw WallPractice1Hook_PerFrame ; record 0
	dw WallPractice1Hook_PointStart ; record 1
	dw WallPractice1Hook_PointEnd ; record 2
	dw RetStub ; record 3
	dw WallPractice1Hook_BallHit ; record 4
	dw WallPractice1Hook_Bounce ; record 5
	dw WallPractice1Hook_RallyTick ; record 6
	dw RetStub ; record 7
WallPractice1Hook_PerFrame:
	call UpdateMinigameHudAndBallTrail ; $4aa3
	ret ; $4aa6
WallPractice1Hook_PointStart:
	call StartMinigameSoloPoint ; $4aa7
	ret ; $4aaa
WallPractice1Hook_PointEnd:
	call HandleMinigamePointEnd ; $4aab
	ret ; $4aae
WallPractice1Hook_RallyTick:
	call AwardMinigamePointAndReflectBall ; $4aaf
	ret ; $4ab2
WallPractice1Hook_Bounce:
	call StubNop_0d_0 ; $4ab3
	ret ; $4ab6
WallPractice1Hook_BallHit:
	call HideLandingMarkerAndExtendSoloCourt ; $4ab7
	ret ; $4aba
UpdateMinigameHudAndBallTrail:
	ld a, [wPointWinLoseFlag] ; $4abb
	and a ; $4abe
	jr nz, .trail ; $4abf
	ld de, $8484 ; $4ac1
	call DrawMinigameScore ; $4ac4
.trail:
	push_wram_bank WRAM_ACTORS ; $4ac7
	ld hl, wBallHistory + 12 ; $4ad0
	ld de, wBallTrailSlots + 8 ; $4ad3
	call MarkMinigameObjectOffscreen ; $4ad6
	ld hl, wBallHistory + 6 ; $4ad9
	ld de, wBallTrailSlots + 12 ; $4adc
	call MarkMinigameObjectOffscreen ; $4adf
	ld hl, wBallHistory ; $4ae2
	ld de, wBallTrailSlots + 16 ; $4ae5
	call MarkMinigameObjectOffscreen ; $4ae8
	pop_wram_bank ; $4aeb
	ret ; $4af0
MarkMinigameObjectOffscreen:
	inc hl ; $4af1
	inc hl ; $4af2
	ld a, [hl+] ; $4af3
	ld b, [hl] ; $4af4
	ld c, a ; $4af5
	ld hl, $fe60 ; $4af6
	add hl, bc ; $4af9
	bit 7, h ; $4afa
	ret z ; $4afc
	ld a, $ff ; $4afd
	ld [de], a ; $4aff
	ret ; $4b00
StartMinigameSoloPoint:
	call InitMinigameScore ; $4b01
	xor a ; $4b04
	ld [wStandingShadowsEnabled], a ; $4b05
	ld de, $0000 ; $4b08
	ld hl, wNetHeight ; $4b0b
	ld a, e ; $4b0e
	ld [hl+], a ; $4b0f
	ld [hl], d ; $4b10
	push_wram_bank WRAM_ACTORS ; $4b11
	ld hl, $0000 ; $4b1a
	ld de, $04e0 ; $4b1d
	farcall SetCharPosAndTarget ; $4b20
	pop_wram_bank ; $4b23
	ret ; $4b28
HandleMinigamePointEnd:
	push_wram_bank WRAM_ACTORS ; $4b29
	ld a, CHARSTATE_STANDBY ; $4b32
	farcall SetCharState ; $4b34
	pop_wram_bank ; $4b37
	call ShowPointOutcomeBanner ; $4b3c
	call DetermineMinigamePointResult ; $4b3f
	push de ; $4b42
	push_wram_bank WRAM_ACTORS ; $4b43
	farcall CharPointEndReaction ; $4b4c
	pop_wram_bank ; $4b4f
	pop de ; $4b54
	call ShowMinigamePointResult ; $4b55
	ret ; $4b58
AwardMinigamePointAndReflectBall:
	ld a, [wPointOutcome] ; $4b59
	and a ; $4b5c
	jr nz, ReflectBallVelocity ; $4b5d
	ld de, $0001 ; $4b5f
	call AddToMinigameScore ; $4b62
	call IsMinigameTargetReached ; $4b65
	and a ; $4b68
	jr z, ReflectBallVelocity ; $4b69
	ld a, POINTOUTCOME_MINIGAME_CLEARED ; $4b6b
	ld [wPointOutcome], a ; $4b6d
ReflectBallVelocity:
	ld a, $01 ; $4b70
	ld [wCameraFollowBall], a ; $4b72
	farcall StartBounceEffect ; $4b75
	xor a ; $4b78
	ld [wBallBounceCount], a ; $4b79
	ld hl, wBallQuadrantAtHit ; $4b7c
	ld a, [hl] ; $4b7f
	xor $02 ; $4b80
	ld [hl], a ; $4b82
	ld hl, wBallDepthFrac ; $4b83
	ld a, [hl] ; $4b86
	cpl ; $4b87
	ld [hl+], a ; $4b88
	ld a, [hl] ; $4b89
	cpl ; $4b8a
	ld [hl+], a ; $4b8b
	ld a, [hl] ; $4b8c
	cpl ; $4b8d
	ld [hl+], a ; $4b8e
	ld a, [hl] ; $4b8f
	cpl ; $4b90
	ld [hl+], a ; $4b91
	ld hl, wBallVelocityDepthFrac ; $4b92
	ld a, [hl] ; $4b95
	cpl ; $4b96
	ld [hl+], a ; $4b97
	ld a, [hl] ; $4b98
	cpl ; $4b99
	ld [hl+], a ; $4b9a
	ld a, [hl] ; $4b9b
	cpl ; $4b9c
	ld [hl+], a ; $4b9d
	ld hl, wBallVelocityDepthFrac ; $4b9e
	ld b, $e6 ; $4ba1
	farcall MulMem24ByFrac ; $4ba3
	ld hl, wBallVelocityDepthFrac ; $4ba6
	ld [hl+], a ; $4ba9
	ld a, e ; $4baa
	ld [hl+], a ; $4bab
	ld a, d ; $4bac
	ld [hl+], a ; $4bad
	ld a, [wPointOutcome] ; $4bae
	and a ; $4bb1
	ret nz ; $4bb2
	push_wram_bank WRAM_ACTORS ; $4bb3
	ld a, CHARSTATE_RALLY ; $4bbc
	farcall SetCharState ; $4bbe
	pop_wram_bank ; $4bc1
	ret ; $4bc6
StubNop_0d_0:
	ret ; $4bc7
HideLandingMarkerAndExtendSoloCourt:
	xor a ; $4bc8
	ld [wLandingMarkerActive], a ; $4bc9
	ld a, [wRallyLength] ; $4bcc
	cp $01 ; $4bcf
	ret nz ; $4bd1
	ld de, $fb20 ; $4bd2
	ld hl, wCourtLimitDepth ; $4bd5
	ld a, e ; $4bd8
	ld [hl+], a ; $4bd9
	ld [hl], d ; $4bda
	ld de, $fe50 ; $4bdb
	ld hl, wCourtLimitX ; $4bde
	ld a, e ; $4be1
	ld [hl+], a ; $4be2
	ld [hl], d ; $4be3
	ld a, $02 ; $4be4
	ld [wRallyLength], a ; $4be6
	ret ; $4be9
