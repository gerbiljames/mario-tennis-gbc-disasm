PredictBallXAtDepth:
	ld hl, wShotAimAngle ; $7c86
	ld a, [hl+] ; $7c89
	ld b, [hl] ; $7c8a
	ld c, a ; $7c8b
	ld hl, wBallDepth ; $7c8c
	ld a, [hl+] ; $7c8f
	ld h, [hl] ; $7c90
	ld l, a ; $7c91
	xor a ; $7c92
	sub l ; $7c93
	ld l, a ; $7c94
	sbc a ; $7c95
	sub h ; $7c96
	ld h, a ; $7c97
	add hl, de ; $7c98
	call MulHLByTangent ; $7c99
	ld hl, wBallX ; $7c9c
	ld a, [hl+] ; $7c9f
	ld h, [hl] ; $7ca0
	ld l, a ; $7ca1
	add hl, de ; $7ca2
	ret ; $7ca3
AiRecoverStateSingles:
	ld a, [wAiPhase] ; $7ca4
	rst Rst00 ; $7ca7
	dw AiChooseHomePosition ; $7ca8 jumptable
	dw AiReturnToPositionPhase ; $7caa jumptable
	dw AiPhaseNoop ; $7cac jumptable
AiChooseHomePosition:
	ld a, [wAiPositionStrategy] ; $7cae
	rst Rst00 ; $7cb1
	dw AiChooseHomePosition.baseline ; $7cb2 jumptable
	dw AiChooseHomePosition.net ; $7cb4 jumptable
	dw AiChooseHomePosition.midCourt ; $7cb6 jumptable
	dw AiChooseHomePosition.midCourt ; $7cb8 jumptable
	dw AiChooseHomePosition.midCourt ; $7cba jumptable
	dw AiChooseHomePosition.baseline ; $7cbc jumptable
	dw AiChooseHomePosition.midCourt ; $7cbe jumptable
	dw AiChooseHomePosition.midCourt ; $7cc0 jumptable
.baseline:
	ld de, $0460 ; $7cc2
	jr .apply ; $7cc5
.midCourt:
	ld de, $0180 ; $7cc7
	jr .apply ; $7cca
.net:
	ld hl, wCharPosDepth + 1 ; $7ccc
	ld a, [hl+] ; $7ccf
	ld d, [hl] ; $7cd0
	ld e, a ; $7cd1
	bit 7, d ; $7cd2
	jr z, .apply ; $7cd4
	xor a ; $7cd6
	sub e ; $7cd7
	ld e, a ; $7cd8
	sbc a ; $7cd9
	sub d ; $7cda
	ld d, a ; $7cdb
.apply:
	ld hl, wBallTargetX ; $7cdc
	ld a, [hl+] ; $7cdf
	ld h, [hl] ; $7ce0
	ld l, a ; $7ce1
	sra h ; $7ce2
	rr l ; $7ce4
	sra h ; $7ce6
	rr l ; $7ce8
	jp AiSetMirroredTarget ; $7cea
AiReturnToPositionPhase:
	call AiSteerTowardTarget ; $7ced
	call CheckCharNearTarget ; $7cf0
	and a ; $7cf3
	jr z, .done ; $7cf4
	jp AiAdvancePhase ; $7cf6
.done:
	ret ; $7cf9
AiRallyStateSingles:
	ld a, [wAiPhase] ; $7cfa
	rst Rst00 ; $7cfd
	dw AiSetReactionDelay ; $7cfe jumptable
	dw AiChoosePositionByStrategy ; $7d00 jumptable
	dw AiTrackBallPhase ; $7d02 jumptable
	dw AiWaitThenPickShot ; $7d04 jumptable
	dw AiSwingControlSingles ; $7d06 jumptable
	dw AiPhaseNoop ; $7d08 jumptable
AiSetReactionDelay:
	ld a, [wCharBallReachFlags] ; $7d0a
	bit 4, a ; $7d0d
	ld hl, wAiReactionDelayFar ; $7d0f
	jr z, .randomize ; $7d12
	ld hl, wAiReactionDelayNear ; $7d14
.randomize:
	call AdvanceMatchRng ; $7d17
	and $03 ; $7d1a
	add [hl] ; $7d1c
	ld [wAiActionTimer], a ; $7d1d
	jp AiAdvancePhase ; $7d20
AiChoosePositionByStrategy:
	ld a, [wAiPositionStrategy] ; $7d23
	rst Rst00 ; $7d26
	dw AiChoosePositionByStrategy.behindLanding ; $7d27 jumptable
	dw AiChoosePositionByStrategy.adaptive ; $7d29 jumptable
	dw AiChoosePositionByStrategy.lateral ; $7d2b jumptable
	dw AiChoosePositionByStrategy.midCourt ; $7d2d jumptable
	dw AiChoosePositionByStrategy.lateralMove ; $7d2f jumptable
	dw AiChoosePositionByStrategy.lateralMove ; $7d31 jumptable
	dw AiChoosePositionByStrategy.nearNet ; $7d33 jumptable
	dw AiChoosePositionByStrategy.behindLanding ; $7d35 jumptable
	call AiIsIncomingLobShot ; $7d37
	and a ; $7d3a
	jp nz, AiRushToBallLanding ; $7d3b
.behindLanding:
	jp AiMoveBehindBallLanding ; $7d3e
.lateral:
	call AiIsIncomingDropOrLobShot ; $7d41
	and a ; $7d44
	jp nz, AiRushToBallLanding ; $7d45
.lateralMove:
	jp AiMoveLaterallyToBallLine ; $7d48
.midCourt:
	call AiIsIncomingDropOrLobShot ; $7d4b
	and a ; $7d4e
	jp nz, AiRushToBallLanding ; $7d4f
	jp AiInterceptAtMidCourt ; $7d52
.nearNet:
	jp AiInterceptNearNet ; $7d55
.adaptive:
	ld hl, wCharBallReachFlags ; $7d58
	bit 4, [hl] ; $7d5b
	jr z, .adaptiveLob ; $7d5d
	call AiIsIncomingDropOrLobShot ; $7d5f
	and a ; $7d62
	jp nz, AiRushToBallLanding ; $7d63
	jp AiInterceptAtMidCourt ; $7d66
.adaptiveLob:
	call AiIsIncomingLobShot ; $7d69
	and a ; $7d6c
	jp nz, AiRushToBallLanding ; $7d6d
	jp AiMoveBehindBallLanding ; $7d70
AiTrackBallPhase:
	ld a, [wBallHasBouncedFlag] ; $7d73
	ld b, a ; $7d76
	ld a, [wBallCrossedNetFlag] ; $7d77
	and b ; $7d7a
	jr nz, .trackBall ; $7d7b
	ld a, [wCharRallyReady] ; $7d7d
	and a ; $7d80
	ret z ; $7d81
	call AiSteerTowardTarget ; $7d82
	call CheckCharNearTarget ; $7d85
	and a ; $7d88
	jr nz, .advance ; $7d89
	ld hl, wCharBallReachFlags ; $7d8b
	bit 0, [hl] ; $7d8e
	jr nz, .advance ; $7d90
	ret ; $7d92
.trackBall:
	ld de, $0200 ; $7d93
	call MirrorDepthForFarSide ; $7d96
	call PredictBallXAtDepth ; $7d99
	ld de, $0200 ; $7d9c
	call SetCharTargetMirrored ; $7d9f
	ret ; $7da2
.advance:
	ld a, [wAiTrackingParam] ; $7da3
	ld [wAiTrackingCountdown], a ; $7da6
	ld hl, wAiPhase ; $7da9
	inc [hl] ; $7dac
AiWaitThenPickShot:
	ld hl, wCharBallReachFlags ; $7dad
	bit 0, [hl] ; $7db0
	jr nz, .pickShot ; $7db2
	ld hl, wAiTrackingCountdown ; $7db4
	ld a, [hl] ; $7db7
	and a ; $7db8
	jr z, .pickShot ; $7db9
	dec [hl] ; $7dbb
	ret ; $7dbc
.pickShot:
	call AiPickShotButtons ; $7dbd
	call AiPressFirstShotButton ; $7dc0
	ld hl, wAiSecondButtonDelay ; $7dc3
	ld [hl], $05 ; $7dc6
	jp AiAdvancePhase ; $7dc8
AiSwingControlSingles:
	ld a, [wAiSecondButtonDelay] ; $7dcb
	and a ; $7dce
	jr nz, .checkSwing ; $7dcf
	ld a, [wCharShotButton2] ; $7dd1
	and a ; $7dd4
	jr nz, .checkSwing ; $7dd5
	call AiPressSecondShotButton ; $7dd7
.checkSwing:
	ld hl, wCharBallReachFlags ; $7dda
	bit 1, [hl] ; $7ddd
	jr nz, .partnerCheck ; $7ddf
	call AiSteerTowardBall ; $7de1
	ret ; $7de4
.partnerCheck:
	ld a, [wCharIndex] ; $7de5
	add $01 ; $7de8
	and $01 ; $7dea
	call AiRollAimAwayFromChar ; $7dec
	jp AiAdvancePhase ; $7def
AiRecoverStateNetPlayer:
	ld a, [wAiPhase] ; $7df2
	rst Rst00 ; $7df5
	dw AiTrackBallTargetX ; $7df6 jumptable
	dw AiReturnToPositionPhase ; $7df8 jumptable
	dw AiPhaseNoop ; $7dfa jumptable
AiRecoverStateBaseliner:
	ld a, [wAiPhase] ; $7dfc
	rst Rst00 ; $7dff
	dw AiAdvancePhase ; $7e00 jumptable
	dw AiBaselinerShadowPartner ; $7e02 jumptable
	dw AiReturnToPositionPhase ; $7e04 jumptable
	dw AiPhaseNoop ; $7e06 jumptable
AiTrackBallTargetX:
	ld hl, wBallTargetX ; $7e08
	ld a, [hl+] ; $7e0b
	ld h, [hl] ; $7e0c
	ld l, a ; $7e0d
	sra h ; $7e0e
	rr l ; $7e10
	ld e, l ; $7e12
	ld d, h ; $7e13
	sra h ; $7e14
	rr l ; $7e16
	add hl, de ; $7e18
	ld de, $0180 ; $7e19
	call SetCharTargetMirrored ; $7e1c
	jp AiAdvancePhase ; $7e1f
AiBaselinerShadowPartner:
	ldh a, [hWramBank] ; $7e22
	push af ; $7e24
	ld a, [wCharIndex] ; $7e25
	add $02 ; $7e28
	and $03 ; $7e2a
	call CharIndexToWramBank ; $7e2c
	ld a, a ; $7e2f
	wram_bank ; $7e30
	ld hl, rLCDC ; $7e34
	ld a, [wCharWalkTargetX + 1] ; $7e37
	bit 7, a ; $7e3a
	jr z, .setTarget ; $7e3c
	xor a ; $7e3e
	sub l ; $7e3f
	ld l, a ; $7e40
	sbc a ; $7e41
	sub h ; $7e42
	ld h, a ; $7e43
.setTarget:
	pop_wram_bank ; $7e44
	ld de, $0460 ; $7e49
	call SetCharTargetMirrored ; $7e4c
	jp AiAdvancePhase ; $7e4f
AiRallyStateNetPlayer:
	ld a, [wAiPhase] ; $7e52
	rst Rst00 ; $7e55
	dw AiNetPlayerCheckRally ; $7e56 jumptable
	dw AiNetPlayerPredictLanding ; $7e58 jumptable
	dw AiDoublesTrackBallPhase ; $7e5a jumptable
	dw AiWaitThenPickShot ; $7e5c jumptable
	dw AiSwingControlDoubles ; $7e5e jumptable
	dw AiPhaseNoop ; $7e60 jumptable
	dw AiPhaseNoop ; $7e62 jumptable
	dw AiPhaseNoop ; $7e64 jumptable
	dw AiNetPlayerPoachCheck ; $7e66 jumptable
AiRallyStateBaseliner:
	ld a, [wAiPhase] ; $7e68
	rst Rst00 ; $7e6b
	dw AiBaselinerSetTarget ; $7e6c jumptable
	dw AiBaselinerDone ; $7e6e jumptable
	dw AiDoublesTrackBallPhase ; $7e70 jumptable
	dw AiWaitThenPickShot ; $7e72 jumptable
	dw AiSwingControlDoubles ; $7e74 jumptable
	dw AiPhaseNoop ; $7e76 jumptable
	dw AiPhaseNoop ; $7e78 jumptable
	dw AiPhaseNoop ; $7e7a jumptable
	dw AiNetPlayerPoachCheck ; $7e7c jumptable
AiNetPlayerCheckRally:
	ld a, [wRallyLength] ; $7e7e
	cp $02 ; $7e81
	ret c ; $7e83
	call AdvanceMatchRng ; $7e84
	and $03 ; $7e87
	ld hl, wAiReactionDelayNear ; $7e89
	add [hl] ; $7e8c
	ld [wAiActionTimer], a ; $7e8d
	ld a, [wAiTrackingParam] ; $7e90
	ld [wAiTrackingCountdown], a ; $7e93
	jp AiAdvancePhase ; $7e96
AiNetPlayerPredictLanding:
	ld de, $0180 ; $7e99
	call MirrorDepthForFarSide ; $7e9c
	call PredictBallXAtDepth ; $7e9f
	ld de, $0180 ; $7ea2
	call SetCharTargetMirrored ; $7ea5
	ld a, [wAiTrackingParam] ; $7ea8
	ld [wAiTrackingCountdown], a ; $7eab
	jp AiAdvancePhase ; $7eae
AiBaselinerSetTarget:
	call AdvanceMatchRng ; $7eb1
	and $03 ; $7eb4
	ld hl, wAiReactionDelayFar ; $7eb6
	add [hl] ; $7eb9
	ld [wAiActionTimer], a ; $7eba
	jp AiAdvancePhase ; $7ebd
AiBaselinerDone:
	ld de, $0460 ; $7ec0
	call MirrorDepthForFarSide ; $7ec3
	call PredictBallXAtDepth ; $7ec6
	ld de, $0460 ; $7ec9
	call SetCharTargetMirrored ; $7ecc
	jp AiAdvancePhase ; $7ecf
AiDoublesTrackBallPhase:
	ld a, [wCharRallyReady] ; $7ed2
	and a ; $7ed5
	ret z ; $7ed6
	call AiSteerTowardTarget ; $7ed7
	call CheckCharNearTarget ; $7eda
	and a ; $7edd
	jr nz, .advance ; $7ede
	ld hl, wCharBallReachFlags ; $7ee0
	bit 0, [hl] ; $7ee3
	jr nz, .advance ; $7ee5
	ldh a, [hWramBank] ; $7ee7
	push af ; $7ee9
	ld a, [wCharIndex] ; $7eea
	add $02 ; $7eed
	and $03 ; $7eef
	call CharIndexToWramBank ; $7ef1
	ld a, a ; $7ef4
	wram_bank ; $7ef5
	ld a, [wCharShotButton1] ; $7ef9
	ld b, a ; $7efc
	pop_wram_bank ; $7efd
	ld a, b ; $7f02
	and a ; $7f03
	jr nz, .poachCheck ; $7f04
	ret ; $7f06
.advance:
	jp AiAdvancePhase ; $7f07
.poachCheck:
	ld a, $08 ; $7f0a
	ld [wAiPhase], a ; $7f0c
	jr AiNetPlayerPoachCheck ; $7f0f
AiNetPlayerPoachCheck:
	ld a, [wCharServeRole] ; $7f11
	and $02 ; $7f14
	jr z, .checkSide ; $7f16
	ld a, [wCharIndex] ; $7f18
	and $01 ; $7f1b
	jr z, .checkSide ; $7f1d
	ld a, [wCharIndex] ; $7f1f
.checkSide:
	ld hl, wCharBallReachFlags ; $7f22
	bit 0, [hl] ; $7f25
	jr z, .checkDistance ; $7f27
	ld a, $03 ; $7f29
	ld [wAiPhase], a ; $7f2b
	jp AiWaitThenPickShot ; $7f2e
.checkDistance:
	ldh a, [hWramBank] ; $7f31
	push af ; $7f33
	ld a, [wCharIndex] ; $7f34
	add $02 ; $7f37
	and $03 ; $7f39
	call CharIndexToWramBank ; $7f3b
	ld a, a ; $7f3e
	wram_bank ; $7f3f
	ld hl, wBallDepth ; $7f43
	ld a, [hl+] ; $7f46
	ld d, [hl] ; $7f47
	ld e, a ; $7f48
	bit 7, d ; $7f49
	jr z, .poach ; $7f4b
	xor a ; $7f4d
	sub e ; $7f4e
	ld e, a ; $7f4f
	sbc a ; $7f50
	sub d ; $7f51
	ld d, a ; $7f52
.poach:
	ld hl, wCharPosDepth + 1 ; $7f53
	ld a, [hl+] ; $7f56
	ld h, [hl] ; $7f57
	ld l, a ; $7f58
	bit 7, h ; $7f59
	jr z, .stay ; $7f5b
	xor a ; $7f5d
	sub l ; $7f5e
	ld l, a ; $7f5f
	sbc a ; $7f60
	sub h ; $7f61
	ld h, a ; $7f62
.stay:
	ld bc, $0020 ; $7f63
	add hl, bc ; $7f66
	ld a, l ; $7f67
	sub e ; $7f68
	ld l, a ; $7f69
	ld a, h ; $7f6a
	sbc d ; $7f6b
	ld h, a ; $7f6c
	pop_wram_bank ; $7f6d
	bit 7, h ; $7f72
	jr z, .done ; $7f74
	ld hl, wCharPosDepth + 1 ; $7f76
	ld a, [hl+] ; $7f79
	ld d, [hl] ; $7f7a
	ld e, a ; $7f7b
	push de ; $7f7c
	call PredictBallXAtDepth ; $7f7d
	pop de ; $7f80
	call SetCharTarget ; $7f81
	ld a, $02 ; $7f84
	ld [wAiPhase], a ; $7f86
.done:
	ret ; $7f89
AiSwingControlDoubles:
	ld a, [wAiSecondButtonDelay] ; $7f8a
	and a ; $7f8d
	jr nz, .checkPartner ; $7f8e
	ld a, [wCharShotButton2] ; $7f90
	and a ; $7f93
	jr nz, .checkPartner ; $7f94
	call AiPressSecondShotButton ; $7f96
.checkPartner:
	ld hl, wCharBallReachFlags ; $7f99
	bit 1, [hl] ; $7f9c
	jr nz, .swing ; $7f9e
	call AiSteerTowardBall ; $7fa0
	ret ; $7fa3
.swing:
	ld a, [wCharIndex] ; $7fa4
	add $01 ; $7fa7
	and $03 ; $7fa9
	ld d, a ; $7fab
	call GetCharRoleByIndex ; $7fac
	ld a, b ; $7faf
	and $02 ; $7fb0
	jr nz, .done ; $7fb2
	ld a, [wCharIndex] ; $7fb4
	add $03 ; $7fb7
	and $03 ; $7fb9
	ld d, a ; $7fbb
.done:
	ld c, d ; $7fbc
	call AiAimAwayFromChar ; $7fbd
	jp AiAdvancePhase ; $7fc0
	; $7fc3, 61 bytes fill to bank end (linker-padded)
