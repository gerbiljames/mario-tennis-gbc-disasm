; Shared by Unused_24_SetBallTargetByPrediction,
; Unused_21_SetBallTargetByPrediction, Unused_23_SetBallTargetByPrediction,
; Unused_2c_SetBallTargetByPrediction, SetBallTargetByPrediction_2b,
; SetBallTargetByPrediction_2a, SetBallTargetByPrediction_29,
; Unused_20_SetBallTargetByPrediction, Unused_22_SetBallTargetByPrediction
; (banks $20, $21, $22, $23, $24, $29, $2a, $2b, $2c).

{TWIN_LABEL}:
	ld a, [hl+]
	ld c, a
	ld a, [hl+]
	ld b, a
	push hl
	ld hl, wShotPredictionEntry
	ld a, c
	ld [hl+], a
	ld [hl], b
	ld hl, wShotAimDeltaX
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	abs_hl
	add hl, hl
	ld a, b
	call MulHLByAFrac
	add hl, hl
	add hl, hl
	add hl, bc
	ld c, l
	ld b, h
	pop hl
	push bc
	ld a, [hl+]
	ld c, a
	ld a, [hl+]
	ld b, a
	ld a, [hl+]
	ld e, a
	ld a, [hl+]
	ld d, a
	ld a, [wShotAimMirror]
	and a
	jr z, .applyAngle
	neg_de
.applyAngle:
	ld hl, wShotAimAngle
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	pop hl
	farcall SetBallVelocityPolar
	ld de, $fd40
	ld a, [wCharCourtPos]
	and COURTPOSF_FAR
	jr z, .nearSide
	neg_de
.nearSide:
	ld hl, wBallTargetDepth
	ld a, e
	ld [hl+], a
	ld [hl], d
	farcall PredictBallXAtDepth
	ld e, l
	ld d, h
	ld hl, wBallTargetX
	ld a, e
	ld [hl+], a
	ld [hl], d
	ret
