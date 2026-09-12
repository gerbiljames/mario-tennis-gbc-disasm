ResetSwingAnimation:
	ld a, [wCharAnimId] ; $6c99
	cp CHARANIM_SMASH ; $6c9c
	jr z, .toIdle ; $6c9e
	cp CHARANIM_SMASH_QUICK ; $6ca0
	jr z, .toIdle ; $6ca2
	jr .checkAnim ; $6ca4
.toIdle:
	ld hl, wCharFlags ; $6ca6
	bit CHARB_AIRBORNE, [hl] ; $6ca9
	jr nz, .checkAnim ; $6cab
	ld d, CHARANIM_IDLE ; $6cad
	call SetCharAnimation ; $6caf
.checkAnim:
	ld a, [wCharAnimId] ; $6cb2
	cp CHARANIM_IDLE ; $6cb5
	jr nz, .done ; $6cb7
	xor a ; $6cb9
	ld [wCharStatePhase], a ; $6cba
.done:
	ret ; $6cbd
CharStandbyState:
	ld a, [wCharStatePhase] ; $6cbe
	rst Rst00 ; $6cc1
	dw CharRallyEndState ; $6cc2 jumptable
	dw CharAwaitServeState.checkInput ; $6cc4 jumptable
	dw AdvanceCharStatePhase.done ; $6cc6 jumptable
CharAwaitServeState:
	ld a, [wCharStatePhase] ; $6cc8
	rst Rst00 ; $6ccb
	dw CharRallyEndState ; $6ccc jumptable
	dw CharAwaitServeState.startServe ; $6cce jumptable
	dw CharAwaitServeState.checkInput ; $6cd0 jumptable
	dw AdvanceCharStatePhase.done ; $6cd2 jumptable
.checkInput:
	call ApplyCharMovementInput ; $6cd4
	call UpdateCharRunAnimation ; $6cd7
	ret ; $6cda
.startServe:
	call ApplyCharMovementInput ; $6cdb
	call UpdateCharRunAnimation ; $6cde
	ld hl, wCharPosDepth + 1 ; $6ce1
	ld a, [hl+] ; $6ce4
	ld h, [hl] ; $6ce5
	ld l, a ; $6ce6
	bit 7, h ; $6ce7
	jr z, .waitForToss ; $6ce9
	xor a ; $6ceb
	sub l ; $6cec
	ld l, a ; $6ced
	sbc a ; $6cee
	sub h ; $6cef
	ld h, a ; $6cf0
.waitForToss:
	ld de, $fe00 ; $6cf1
	add hl, de ; $6cf4
	bit 7, h ; $6cf5
	jr nz, .done ; $6cf7
	push_wram_bank WRAM_CHAR0 ; $6cf9
	farcall DismissServeIndicatorObjs ; $6d02
	pop_wram_bank ; $6d05
	jp AdvanceCharStatePhase ; $6d0a
.done:
	ret ; $6d0d
CharWalkState:
	ld a, [wCharStatePhase] ; $6d0e
	rst Rst00 ; $6d11
	dw CharWalkToTargetPhase ; $6d12 jumptable
	dw AdvanceCharStatePhase.done ; $6d14 jumptable
CharPointEndState:
	ld a, [wCharStatePhase] ; $6d16
	rst Rst00 ; $6d19
	dw CharRallyEndState ; $6d1a jumptable
	dw CharWalkToTargetPhase ; $6d1c jumptable
	dw CharPointReactionPhase ; $6d1e jumptable
	dw AdvanceCharStatePhase.done ; $6d20 jumptable
	dw PrintString.markDirty ; $6d22 jumptable
	dw UpdateSoundChannels.step6 ; $6d24 jumptable
	ret ; $6d26
CharPointReactionPhase:
	call ReloadCharFrameGfx ; $6d27
	ld a, [wCharPointResult] ; $6d2a
	add a ; $6d2d
	jr z, .advance ; $6d2e
	ld d, CHARANIM_CELEBRATE ; $6d30
	jr nc, .setAnim ; $6d32
	ld d, CHARANIM_DEJECTED ; $6d34
.setAnim:
	call SetCharAnimation ; $6d36
.advance:
	ld hl, wCharStatePhase ; $6d39
	inc [hl] ; $6d3c
	ret ; $6d3d
CharWalkToTargetPhase:
	call MoveCharTowardTarget ; $6d3e
	push af ; $6d41
	call UpdateCharRunAnimation ; $6d42
	pop af ; $6d45
	and a ; $6d46
	jp z, AdvanceCharStatePhase ; $6d47
	ret ; $6d4a
UpdateCharRunAnimation:
	ld d, CHARANIM_RUN ; $6d4b
	ld hl, wCharFlags ; $6d4d
	bit CHARB_MOVING, [hl] ; $6d50
	jr nz, .setAnim ; $6d52
	ld d, CHARANIM_IDLE ; $6d54
.setAnim:
	call SetCharAnimation ; $6d56
	ret ; $6d59
StartCharSwing:
	ld a, [wCharSwingAttrWord] ; $6d5a
	bit 7, a ; $6d5d
	call PredictBallLateralOffset ; $6d5f
	bit 7, h ; $6d62
	jr nz, .facingLeft ; $6d64
	ld a, [wCharInputBits] ; $6d66
	bit PADB_RIGHT, a ; $6d69
	jr z, .checkHeight ; $6d6b
	jr .checkReach ; $6d6d
.facingLeft:
	ld a, [wCharInputBits] ; $6d6f
	bit PADB_LEFT, a ; $6d72
	jr z, .checkHeight ; $6d74
.checkReach:
	ld a, [wCharReachX] ; $6d76
	ld e, a ; $6d79
	ld a, [wCharReachX + 1] ; $6d7a
	ld d, a ; $6d7d
	ld a, [wCharBallReachFlags] ; $6d7e
	bit 4, a ; $6d81
	ld bc, $fff0 ; $6d83
	jr nz, .absOffset ; $6d86
	ld bc, $0000 ; $6d88
.absOffset:
	bit 7, h ; $6d8b
	jr z, .compareReach ; $6d8d
	xor a ; $6d8f
	sub l ; $6d90
	ld l, a ; $6d91
	sbc a ; $6d92
	sub h ; $6d93
	ld h, a ; $6d94
.compareReach:
	add hl, bc ; $6d95
	ld a, l ; $6d96
	sub e ; $6d97
	ld l, a ; $6d98
	ld a, h ; $6d99
	sbc d ; $6d9a
	ld h, a ; $6d9b
	bit 7, h ; $6d9c
	jr z, .dive ; $6d9e
.checkHeight:
	ld a, [wBallVelocityHeight + 1] ; $6da0
	ld l, a ; $6da3
	add a ; $6da4
	sbc a ; $6da5
	ld h, a ; $6da6
	add hl, hl ; $6da7
	ld c, l ; $6da8
	ld b, h ; $6da9
	ld hl, wCharReachHeight ; $6daa
	ld a, [hl+] ; $6dad
	ld d, [hl] ; $6dae
	ld e, a ; $6daf
	ld hl, wBallHeight ; $6db0
	ld a, [hl+] ; $6db3
	ld h, [hl] ; $6db4
	ld l, a ; $6db5
	add hl, de ; $6db6
	add hl, de ; $6db7
	add hl, bc ; $6db8
	bit 7, h ; $6db9
	jr nz, .jumpSmash ; $6dbb
	ld hl, wBallHeight ; $6dbd
	ld a, [hl+] ; $6dc0
	ld h, [hl] ; $6dc1
	ld l, a ; $6dc2
	add hl, de ; $6dc3
	sra d ; $6dc4
	rr e ; $6dc6
	add hl, de ; $6dc8
	add hl, bc ; $6dc9
	bit 7, h ; $6dca
	jr z, .swingGround ; $6dcc
	ld hl, wCharSwingAnim ; $6dce
	ld [hl], CHARANIM_OVERHEAD ; $6dd1
.swingGround:
	jr .startSwing ; $6dd3
.jumpSmash:
	ld hl, wCharFlags ; $6dd5
	set CHARB_AIRBORNE, [hl] ; $6dd8
	ld hl, wCharSmashJumpSpeed ; $6dda
	ld a, [hl+] ; $6ddd
	ld d, [hl] ; $6dde
	ld e, a ; $6ddf
	xor a ; $6de0
	sub e ; $6de1
	ld e, a ; $6de2
	sbc a ; $6de3
	sub d ; $6de4
	ld d, a ; $6de5
	ld hl, wCharVelHeight ; $6de6
	ld a, e ; $6de9
	ld [hl+], a ; $6dea
	ld [hl], d ; $6deb
	ld hl, wCharSwingAnim ; $6dec
	ld [hl], CHARANIM_SMASH ; $6def
	sound SFX_SWING ; $6df1
	ret ; $6df3
.dive:
	ld hl, wCharSwingAnim ; $6df4
	ld [hl], CHARANIM_DIVE ; $6df7
	ld d, $00 ; $6df9
	ld a, [wCharInputBits] ; $6dfb
	bit PADB_RIGHT, a ; $6dfe
	jr nz, .storeFacing ; $6e00
	ld d, $80 ; $6e02
.storeFacing:
	ld hl, wCharFacingShown ; $6e04
	ld [hl], d ; $6e07
	ld hl, wCharFlags ; $6e08
	set CHARB_DIVING, [hl] ; $6e0b
	res CHARB_CHARGING, [hl] ; $6e0d
	ld hl, wCharDiveSpeed ; $6e0f
	ld a, [hl+] ; $6e12
	ld h, [hl] ; $6e13
	ld l, a ; $6e14
	ld a, [wCharFacingDesired] ; $6e15
	call VectorFromLengthAndAngleRaw ; $6e18
	ld c, l ; $6e1b
	ld b, h ; $6e1c
	xor a ; $6e1d
	ld hl, wCharVelX ; $6e1e
	ld [hl+], a ; $6e21
	ld [hl], c ; $6e22
	xor a ; $6e23
	ld hl, wCharVelDepth ; $6e24
	ld [hl+], a ; $6e27
	ld [hl], e ; $6e28
	sound SFX_SWING ; $6e29
	ret ; $6e2b
.startSwing:
	xor a ; $6e2c
	ld [wCharQuickSwing], a ; $6e2d
	ld a, [wCharSwingFrames] ; $6e30
	cp $05 ; $6e33
	jr nc, .chargedSwing ; $6e35
	ld hl, wCharSwingAnim ; $6e37
	ld a, $04 ; $6e3a
	add [hl] ; $6e3c
	ld [hl], a ; $6e3d
	ld a, $01 ; $6e3e
	ld [wCharQuickSwing], a ; $6e40
.chargedSwing:
	ret ; $6e43
SelectForehandBackhand:
	call PredictBallLateralOffset ; $6e44
	ld a, [wCharMirrorAttrMask] ; $6e47
	and a ; $6e4a
	jr z, .compareSide ; $6e4b
	ld a, h ; $6e4d
	cpl ; $6e4e
	ld h, a ; $6e4f
.compareSide:
	ld a, [wCharPosDepth + 2] ; $6e50
	xor h ; $6e53
	bit 7, a ; $6e54
	jr nz, .backhand ; $6e56
	ld a, CHARANIM_FOREHAND ; $6e58
	ld [wCharSwingAnim], a ; $6e5a
	ret ; $6e5d
.backhand:
	ld a, CHARANIM_BACKHAND ; $6e5e
	ld [wCharSwingAnim], a ; $6e60
	ret ; $6e63
UpdateCharBallGeometry:
	ld de, wBallX ; $6e64
	ld hl, wCharPosX + 1 ; $6e67
	ld bc, wBallRelCharX ; $6e6a
	ld a, [de] ; $6e6d
	sub [hl] ; $6e6e
	ld [bc], a ; $6e6f
	inc e ; $6e70
	inc l ; $6e71
	inc c ; $6e72
	ld a, [de] ; $6e73
	sbc [hl] ; $6e74
	ld [bc], a ; $6e75
	inc c ; $6e76
	ld de, wBallDepth ; $6e77
	ld hl, wCharPosDepth + 1 ; $6e7a
	ld a, [de] ; $6e7d
	sub [hl] ; $6e7e
	ld [bc], a ; $6e7f
	inc e ; $6e80
	inc l ; $6e81
	inc c ; $6e82
	ld a, [de] ; $6e83
	sbc [hl] ; $6e84
	ld [bc], a ; $6e85
	inc c ; $6e86
	ld de, wBallHeight ; $6e87
	ld hl, wCharPosHeight + 1 ; $6e8a
	ld a, [de] ; $6e8d
	sub [hl] ; $6e8e
	ld [bc], a ; $6e8f
	inc e ; $6e90
	inc l ; $6e91
	inc c ; $6e92
	ld a, [de] ; $6e93
	sbc [hl] ; $6e94
	ld [bc], a ; $6e95
	ld hl, wCharPosDepth + 1 ; $6e96
	ld a, [hl+] ; $6e99
	ld h, [hl] ; $6e9a
	ld l, a ; $6e9b
	bit 7, h ; $6e9c
	jr z, .checkReach ; $6e9e
	xor a ; $6ea0
	sub l ; $6ea1
	ld l, a ; $6ea2
	sbc a ; $6ea3
	sub h ; $6ea4
	ld h, a ; $6ea5
.checkReach:
	xor a ; $6ea6
	ld de, $fd60 ; $6ea7
	add hl, de ; $6eaa
	jr c, .storeFlags ; $6eab
	set 4, a ; $6ead
.storeFlags:
	ld [wCharBallReachFlags], a ; $6eaf
	call CheckBallInSwingRange ; $6eb2
	ld hl, wCharBallReachFlags ; $6eb5
	bit 0, [hl] ; $6eb8
	ret z ; $6eba
	call CheckBallContactWindow ; $6ebb
	ld hl, wCharBallReachFlags ; $6ebe
	bit 1, [hl] ; $6ec1
	ret z ; $6ec3
	ret ; $6ec4
CheckCharBallContact:
	ld a, [wCharShotButton1] ; $6ec5
	and a ; $6ec8
	ret nz ; $6ec9
	ld a, [wCharState] ; $6eca
	cp CHARSTATE_RALLY ; $6ecd
	ret nz ; $6ecf
	ld a, [wPointOutcome] ; $6ed0
	and a ; $6ed3
	ret nz ; $6ed4
	ld hl, wBallRelCharDepth ; $6ed5
	ld a, [hl+] ; $6ed8
	ld h, [hl] ; $6ed9
	ld l, a ; $6eda
	bit 7, h ; $6edb
	jr z, .checkHeight ; $6edd
	xor a ; $6edf
	sub l ; $6ee0
	ld l, a ; $6ee1
	sbc a ; $6ee2
	sub h ; $6ee3
	ld h, a ; $6ee4
.checkHeight:
	ld de, $fff0 ; $6ee5
	add hl, de ; $6ee8
	ret c ; $6ee9
	ld hl, wCharReachX ; $6eea
	ld a, [hl+] ; $6eed
	ld h, [hl] ; $6eee
	ld l, a ; $6eef
	ld e, l ; $6ef0
	ld d, h ; $6ef1
	ld hl, wBallRelCharX ; $6ef2
	ld a, [hl+] ; $6ef5
	ld h, [hl] ; $6ef6
	ld l, a ; $6ef7
	bit 7, h ; $6ef8
	jr z, .checkX ; $6efa
	xor a ; $6efc
	sub l ; $6efd
	ld l, a ; $6efe
	sbc a ; $6eff
	sub h ; $6f00
	ld h, a ; $6f01
.checkX:
	add hl, hl ; $6f02
	ld a, l ; $6f03
	sub e ; $6f04
	ld l, a ; $6f05
	ld a, h ; $6f06
	sbc d ; $6f07
	ld h, a ; $6f08
	ret nc ; $6f09
	ld hl, wCharReachHeight ; $6f0a
	ld a, [hl+] ; $6f0d
	ld h, [hl] ; $6f0e
	ld l, a ; $6f0f
	ld e, l ; $6f10
	ld d, h ; $6f11
	ld hl, wBallRelCharHeight ; $6f12
	ld a, [hl+] ; $6f15
	ld h, [hl] ; $6f16
	ld l, a ; $6f17
	bit 7, h ; $6f18
	jr z, .done ; $6f1a
	xor a ; $6f1c
	sub l ; $6f1d
	ld l, a ; $6f1e
	sbc a ; $6f1f
	sub h ; $6f20
	ld h, a ; $6f21
.done:
	ld a, l ; $6f22
	sub e ; $6f23
	ld l, a ; $6f24
	ld a, h ; $6f25
	sbc d ; $6f26
	ld h, a ; $6f27
	ret nc ; $6f28
	ld hl, wCharBallReachFlags ; $6f29
	set 2, [hl] ; $6f2c
	ld a, $01 ; $6f2e
	ld [wBallTouchCharFlag], a ; $6f30
	ld a, [wCharIndex] ; $6f33
	ld [wBallTouchCharIndex], a ; $6f36
	ld hl, wCharFlags ; $6f39
	set CHARB_RECOIL, [hl] ; $6f3c
	res CHARB_CHARGING, [hl] ; $6f3e
	ld a, CHARSTATE_INERT ; $6f40
	call SetCharState ; $6f42
	ld hl, wBallVelocityDepth ; $6f45
	ld a, [hl+] ; $6f48
	ld d, [hl] ; $6f49
	ld e, a ; $6f4a
	sra d ; $6f4b
	rr e ; $6f4d
	ld hl, wCharVelDepth ; $6f4f
	ld a, e ; $6f52
	ld [hl+], a ; $6f53
	ld [hl], d ; $6f54
	ld hl, wBallVelocityDepthFrac ; $6f55
	ld a, [hl] ; $6f58
	cpl ; $6f59
	ld [hl+], a ; $6f5a
	ld a, [hl] ; $6f5b
	cpl ; $6f5c
	ld [hl+], a ; $6f5d
	ld a, [hl] ; $6f5e
	cpl ; $6f5f
	ld [hl+], a ; $6f60
	ld hl, wBallDepthFrac ; $6f61
	ld de, wBallVelocityDepthFrac ; $6f64
	call AddVel24ToPos32 ; $6f67
	ld hl, wBallVelocityDepth ; $6f6a
	ld a, [hl+] ; $6f6d
	ld d, [hl] ; $6f6e
	ld e, a ; $6f6f
	sra d ; $6f70
	rr e ; $6f72
	sra d ; $6f74
	rr e ; $6f76
	sra d ; $6f78
	rr e ; $6f7a
	sra d ; $6f7c
	rr e ; $6f7e
	ld hl, wBallVelocityDepth ; $6f80
	ld a, e ; $6f83
	ld [hl+], a ; $6f84
	ld [hl], d ; $6f85
	ld hl, wBallVelocityX ; $6f86
	ld a, [hl+] ; $6f89
	ld d, [hl] ; $6f8a
	ld e, a ; $6f8b
	sra d ; $6f8c
	rr e ; $6f8e
	ld hl, wBallVelocityX ; $6f90
	ld a, e ; $6f93
	ld [hl+], a ; $6f94
	ld [hl], d ; $6f95
	ld hl, wBallVelocityHeight ; $6f96
	ld a, [hl+] ; $6f99
	ld d, [hl] ; $6f9a
	ld e, a ; $6f9b
	sra d ; $6f9c
	rr e ; $6f9e
	ld hl, wBallVelocityHeight ; $6fa0
	ld a, e ; $6fa3
	ld [hl+], a ; $6fa4
	ld [hl], d ; $6fa5
	ret ; $6fa6
