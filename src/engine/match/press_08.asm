AiPhaseNoop:
	ret ; $796c
AiRushToBallLanding:
	ld hl, $fea0 ; $796d
	call OffsetFromBallLanding ; $7970
	bit 7, d ; $7973
	jr z, .clampTarget ; $7975
	xor a ; $7977
	sub e ; $7978
	ld e, a ; $7979
	sbc a ; $797a
	sub d ; $797b
	ld d, a ; $797c
.clampTarget:
	push hl ; $797d
	ld l, e ; $797e
	ld h, d ; $797f
	ld bc, $ff00 ; $7980
	add hl, bc ; $7983
	bit 7, h ; $7984
	jr z, .setTarget ; $7986
	ld de, $0100 ; $7988
.setTarget:
	pop hl ; $798b
	call SetCharTargetMirrored ; $798c
	jp AiAdvancePhase ; $798f
AiMoveBehindBallLanding:
	ld hl, $00c0 ; $7992
	call OffsetFromBallLanding ; $7995
	call SetCharTarget ; $7998
	jp AiAdvancePhase ; $799b
AiInterceptAtMidCourt:
	ld de, $0200 ; $799e
	call MirrorDepthForFarSide ; $79a1
	call PredictBallXAtDepth ; $79a4
	ld de, $0200 ; $79a7
	call SetCharTargetMirrored ; $79aa
	jp AiAdvancePhase ; $79ad
AiInterceptNearNet:
	ld de, $0100 ; $79b0
	call MirrorDepthForFarSide ; $79b3
	call PredictBallXAtDepth ; $79b6
	ld de, $0100 ; $79b9
	call SetCharTargetMirrored ; $79bc
	jp AiAdvancePhase ; $79bf
AiMoveLaterallyToBallLine:
	ld hl, wCharPosDepth + 1 ; $79c2
	ld a, [hl+] ; $79c5
	ld d, [hl] ; $79c6
	ld e, a ; $79c7
	push de ; $79c8
	call PredictBallXAtDepth ; $79c9
	pop de ; $79cc
	call SetCharTarget ; $79cd
	jp AiAdvancePhase ; $79d0
AiSetMirroredTarget:
	call SetCharTargetMirrored ; $79d3
	jp AiAdvancePhase ; $79d6
AiIsIncomingDropOrLobShot:
	ld a, [wCurrentShotType] ; $79d9
	cp SHOTTYPE_DROP ; $79dc
	jr z, ReturnOne_08 ; $79de
AiIsIncomingLobShot:
	ld a, [wCurrentShotType] ; $79e0
	cp SHOTTYPE_LOB ; $79e3
	jr z, ReturnOne_08 ; $79e5
	ld a, [wFallbackTrajectoryFlag] ; $79e7
	and a ; $79ea
	jr nz, ReturnOne_08 ; $79eb
	xor a ; $79ed
	ret ; $79ee
ReturnOne_08:
	ld a, $01 ; $79ef
	ret ; $79f1
AiServeState:
	ld a, [wAiPhase] ; $79f2
	rst Rst00 ; $79f5
	dw AiServeWalkToSpot ; $79f6 jumptable
	dw AiServeSteerToSpot ; $79f8 jumptable
	dw AiServePressToss ; $79fa jumptable
	dw AiServeStrike ; $79fc jumptable
	dw AiServeApplyAim ; $79fe jumptable
	dw AiPhaseNoop ; $7a00 jumptable
AiServeWalkToSpot:
	ld a, [wCharAnimId] ; $7a02
	cp CHARANIM_SERVE_READY ; $7a05
	ret nz ; $7a07
	ld hl, wAiServeTargetX ; $7a08
	ld a, [hl+] ; $7a0b
	ld b, [hl] ; $7a0c
	ld c, a ; $7a0d
	ld a, b ; $7a0e
	or c ; $7a0f
	jr nz, .haveTargetX ; $7a10
	call AdvanceMatchRng ; $7a12
	and $07 ; $7a15
	add a ; $7a17
	ld_hl_indexed ServeWalkToSpotTable ; $7a18
	ld a, [hl+] ; $7a1f
	ld b, [hl] ; $7a20
	ld c, a ; $7a21
.haveTargetX:
	ld hl, wCharPosDepth + 1 ; $7a22
	ld a, [hl+] ; $7a25
	ld d, [hl] ; $7a26
	ld e, a ; $7a27
	ld a, [wCharCourtPos] ; $7a28
	and $01 ; $7a2b
	jr z, .setTarget ; $7a2d
	xor a ; $7a2f
	sub c ; $7a30
	ld c, a ; $7a31
	sbc a ; $7a32
	sub b ; $7a33
	ld b, a ; $7a34
.setTarget:
	ld l, c ; $7a35
	ld h, b ; $7a36
	call SetCharTarget ; $7a37
	jp AiAdvancePhase ; $7a3a
ServeWalkToSpotTable:
	; $7a3d, 16 bytes (records:2)
	dw $0020 ; record 0
	dw $0020 ; record 1
	dw $0080 ; record 2
	dw $00e0 ; record 3
	dw $0140 ; record 4
	dw $0180 ; record 5
	dw $0180 ; record 6
	dw $0180 ; record 7
AiServeSteerToSpot:
	call AiSteerTowardTarget ; $7a4d
	call CheckCharNearTarget ; $7a50
	and a ; $7a53
	jr z, .done ; $7a54
	ld hl, wAiActionTimer ; $7a56
	ld [hl], $19 ; $7a59
	jp AiAdvancePhase ; $7a5b
.done:
	ret ; $7a5e
AiServePressToss:
	ld hl, wCharInputBits ; $7a5f
	set 0, [hl] ; $7a62
	ld a, [wAiServeSkipToss] ; $7a64
	and a ; $7a67
	jr nz, .release ; $7a68
	ld a, [wServeFaultFlag] ; $7a6a
	and a ; $7a6d
	jr nz, .release ; $7a6e
	ld a, [wAiServeStyle] ; $7a70
	and $0f ; $7a73
	add a ; $7a75
	ld_hl_indexed ServePressTossPtrs ; $7a76
	ld a, [hl+] ; $7a7d
	ld h, [hl] ; $7a7e
	ld l, a ; $7a7f
	call AdvanceMatchRng ; $7a80
	and $07 ; $7a83
	add l ; $7a85
	ld l, a ; $7a86
	jr nc, .press ; $7a87
	inc h ; $7a89
.press:
	ld a, [hl] ; $7a8a
	and a ; $7a8b
	jr z, .release ; $7a8c
	ld a, $23 ; $7a8e
	ld [wAiActionTimer], a ; $7a90
	jr .done ; $7a93
.release:
	ld a, $32 ; $7a95
	ld [wAiActionTimer], a ; $7a97
.done:
	jp AiAdvancePhase ; $7a9a
ServePressTossPtrs:
	; $7a9d, 32 bytes (records:2)
	dw ServePressToss0 ; record 0
	dw ServePressToss1 ; record 1
	dw ServePressToss2 ; record 2
	dw ServePressToss3 ; record 3
	dw ServePressToss2 ; record 4
	dw ServePressToss2 ; record 5
	dw ServePressToss2 ; record 6
	dw ServePressToss2 ; record 7
	dw ServePressToss2 ; record 8
	dw ServePressToss2 ; record 9
	dw ServePressToss2 ; record 10
	dw ServePressToss2 ; record 11
	dw ServePressToss2 ; record 12
	dw ServePressToss2 ; record 13
	dw ServePressToss2 ; record 14
	dw ServePressToss2 ; record 15
ServePressToss0:
	; $7abd, 8 bytes (bytes:8)
	db $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
ServePressToss1:
	; $7ac5, 8 bytes (bytes:8)
	db $00, $00, $00, $00, $00, $01, $01, $01 ; 0x00
ServePressToss2:
	; $7acd, 8 bytes (bytes:8)
	db $00, $00, $01, $01, $01, $01, $01, $01 ; 0x00
ServePressToss3:
	; $7ad5, 8 bytes (bytes:8)
	db $01, $01, $01, $01, $01, $01, $01, $01 ; 0x00
AiServeStrike:
	call AiPickServeButtons ; $7add
	call AiPressFirstShotButton ; $7ae0
	ld hl, wAiPhase ; $7ae3
	inc [hl] ; $7ae6
AiServeApplyAim:
	call AiApplyServeAim ; $7ae7
	ret ; $7aea
AiApplyServeAim:
	ld a, [wAiServeAimOverride] ; $7aeb
	cp $ff ; $7aee
	jr z, .randomAim ; $7af0
	ld b, a ; $7af2
	jr .applyAim ; $7af3
.randomAim:
	call AdvanceMatchRng ; $7af5
	and $07 ; $7af8
	ld_hl_indexed AiApplyServeAimTable ; $7afa
	ld b, [hl] ; $7b01
.applyAim:
	ld hl, wCharInputBits ; $7b02
	ld a, [hl] ; $7b05
	and $0f ; $7b06
	or b ; $7b08
	ld [hl], a ; $7b09
	ret ; $7b0a
AiApplyServeAimTable:
	; $7b0b, 8 bytes (bytes:8)
	db $10, $10, $10, $10, $20, $20, $20, $20 ; 0x00
AiRollAimAwayFromChar:
	ld c, a ; $7b13
	call AdvanceMatchRng ; $7b14
	ld hl, wAiAimAwayChance ; $7b17
	cp [hl] ; $7b1a
	ld b, $00 ; $7b1b
	jr nc, AiAimAwayFromChar.applyAim ; $7b1d
AiAimAwayFromChar:
	ldh a, [hWramBank] ; $7b1f
	push af ; $7b21
	ld a, c ; $7b22
	call CharIndexToWramBank ; $7b23
	ld a, a ; $7b26
	wram_bank ; $7b27
	ld hl, wCharVelX ; $7b2b
	ld a, [hl+] ; $7b2e
	ld d, [hl] ; $7b2f
	ld e, a ; $7b30
	ld hl, wCharPosX + 1 ; $7b31
	ld a, [hl+] ; $7b34
	ld h, [hl] ; $7b35
	ld l, a ; $7b36
	pop_wram_bank ; $7b37
	call AdvanceMatchRng ; $7b3c
	and $03 ; $7b3f
	jr z, .pickDirection ; $7b41
	cp $01 ; $7b43
	jr nz, .useSecond ; $7b45
	ld a, h ; $7b47
	cpl ; $7b48
	ld h, a ; $7b49
	jr .pickDirection ; $7b4a
.useSecond:
	ld a, d ; $7b4c
	or e ; $7b4d
	jr z, .pickDirection ; $7b4e
	ld h, d ; $7b50
.pickDirection:
	bit 7, h ; $7b51
	ld b, $20 ; $7b53
	jr z, .applyAim ; $7b55
	ld b, $10 ; $7b57
.applyAim:
	ld hl, wCharInputBits ; $7b59
	ld a, [hl] ; $7b5c
	and $0f ; $7b5d
	or b ; $7b5f
	ld [hl], a ; $7b60
	ret ; $7b61
AiPickServeButtons:
	call AdvanceMatchRng ; $7b62
	and $07 ; $7b65
	ld_hl_indexed AiPickServeButtons_AiShotButtonsTable ; $7b67
	ld a, [hl] ; $7b6e
	ld [wAiShotButtons], a ; $7b6f
	ret ; $7b72
AiPickServeButtons_AiShotButtonsTable:
	; $7b73, 8 bytes (bytes:8)
	db $10, $10, $10, $20, $20, $30, $30, $30 ; 0x00
AiPickShotButtons:
	ld a, [wLandingMarkerActive] ; $7b7b
	and a ; $7b7e
	jr z, .maybeCharge ; $7b7f
	ld b, $30 ; $7b81
	ld a, [wAiServeStyle] ; $7b83
	farcall DoesCharGroupRowContain ; $7b86
	and a ; $7b89
	jr z, .maybeCharge ; $7b8a
	ld a, $30 ; $7b8c
	ld [wAiShotButtons], a ; $7b8e
	ret ; $7b91
.maybeCharge:
	call AdvanceMatchRng ; $7b92
	and $01 ; $7b95
	jr nz, .done ; $7b97
	ld hl, wBallRelCharDepth ; $7b99
	ld a, [hl+] ; $7b9c
	ld h, [hl] ; $7b9d
	ld l, a ; $7b9e
	bit 7, h ; $7b9f
	jr z, .checkReachX ; $7ba1
	xor a ; $7ba3
	sub l ; $7ba4
	ld l, a ; $7ba5
	sbc a ; $7ba6
	sub h ; $7ba7
	ld h, a ; $7ba8
.checkReachX:
	ld de, $fec0 ; $7ba9
	add hl, de ; $7bac
	bit 7, h ; $7bad
	jr nz, .done ; $7baf
	ld b, $12 ; $7bb1
	ld a, [wAiServeStyle] ; $7bb3
	farcall DoesCharGroupRowContain ; $7bb6
	and a ; $7bb9
	jr z, .done ; $7bba
	ld a, [wMatchIsDoubles] ; $7bbc
	and a ; $7bbf
	jr z, .checkPartner ; $7bc0
	call AdvanceMatchRng ; $7bc2
	and $03 ; $7bc5
	jr nz, .done ; $7bc7
	jr .pressShot ; $7bc9
.checkPartner:
	ldh a, [hWramBank] ; $7bcb
	push af ; $7bcd
	ld a, [wCharIndex] ; $7bce
	add $01 ; $7bd1
	and $01 ; $7bd3
	call CharIndexToWramBank ; $7bd5
	ld a, a ; $7bd8
	wram_bank ; $7bd9
	ld hl, wCharPosDepth + 1 ; $7bdd
	ld a, [hl+] ; $7be0
	ld h, [hl] ; $7be1
	ld l, a ; $7be2
	pop_wram_bank ; $7be3
	bit 7, h ; $7be8
	jr z, .checkReachDepth ; $7bea
	xor a ; $7bec
	sub l ; $7bed
	ld l, a ; $7bee
	sbc a ; $7bef
	sub h ; $7bf0
	ld h, a ; $7bf1
.checkReachDepth:
	ld de, $fe20 ; $7bf2
	add hl, de ; $7bf5
	bit 7, h ; $7bf6
	jr z, .done ; $7bf8
.pressShot:
	ld a, $12 ; $7bfa
	ld [wAiShotButtons], a ; $7bfc
	ret ; $7bff
.done:
	call AdvanceMatchRng ; $7c00
	and $0f ; $7c03
	ld b, a ; $7c05
	ld a, [wAiServeStyle] ; $7c06
	farcall GetCharGroupEntry ; $7c09
	ld [wAiShotButtons], a ; $7c0c
	ret ; $7c0f
AiPressFirstShotButton:
	ld a, [wAiShotButtons] ; $7c10
	swap a ; $7c13
	and $0f ; $7c15
	ld b, a ; $7c17
	ld hl, wCharInputBits ; $7c18
	ld a, [hl] ; $7c1b
	and $f0 ; $7c1c
	or b ; $7c1e
	ld [hl], a ; $7c1f
	ret ; $7c20
AiPressSecondShotButton:
	ld a, [wAiShotButtons] ; $7c21
	and $0f ; $7c24
	ld b, a ; $7c26
	ld hl, wCharInputBits ; $7c27
	ld a, [hl] ; $7c2a
	and $f0 ; $7c2b
	or b ; $7c2d
	ld [hl], a ; $7c2e
	ret ; $7c2f
CharIndexToWramBank:
	add $04 ; $7c30
	ret ; $7c32
MirrorDepthForFarSide:
	ld a, [wCharCourtPos] ; $7c33
	and $02 ; $7c36
	ret z ; $7c38
	xor a ; $7c39
	sub e ; $7c3a
	ld e, a ; $7c3b
	sbc a ; $7c3c
	sub d ; $7c3d
	ld d, a ; $7c3e
	ret ; $7c3f
GetCharRoleByIndex:
	ld b, a ; $7c40
	ldh a, [hWramBank] ; $7c41
	push af ; $7c43
	ld a, b ; $7c44
	call CharIndexToWramBank ; $7c45
	ld a, a ; $7c48
	wram_bank ; $7c49
	ld a, [wCharServeRole] ; $7c4d
	ld b, a ; $7c50
	pop_wram_bank ; $7c51
	ret ; $7c56
OffsetFromBallLanding:
	ld a, [wShotAimAngle + 1] ; $7c57
	call VectorFromLengthAndAngle ; $7c5a
	ld c, l ; $7c5d
	ld b, h ; $7c5e
	ld hl, wBallTargetDepth ; $7c5f
	ld a, [hl+] ; $7c62
	ld h, [hl] ; $7c63
	ld l, a ; $7c64
	add hl, de ; $7c65
	ld e, l ; $7c66
	ld d, h ; $7c67
	ld hl, wBallTargetX ; $7c68
	ld a, [hl+] ; $7c6b
	ld h, [hl] ; $7c6c
	ld l, a ; $7c6d
	add hl, bc ; $7c6e
	ret ; $7c6f
SetCharTargetMirrored:
	call MirrorDepthForFarSide ; $7c70
	ld c, l ; $7c73
	ld b, h ; $7c74
	ld hl, wCharWalkTargetX ; $7c75
	ld a, c ; $7c78
	ld [hl+], a ; $7c79
	ld [hl], b ; $7c7a
	ld hl, wCharWalkTargetDepth ; $7c7b
	ld a, e ; $7c7e
	ld [hl+], a ; $7c7f
	ld [hl], d ; $7c80
	xor a ; $7c81
	ld [wCharWalkTargetFlag], a ; $7c82
	ret ; $7c85
