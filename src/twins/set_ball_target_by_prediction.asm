; SetBallTargetByPrediction_<bank>: one routine assembled into banks $20, $21, $22, $23, $24, $29, $2a, $2b, $2c through
; `twin_in set_ball_target_by_prediction, <Label>, <bank>` -- {TWIN_LABEL} is the copy's name
; (Unused_<bank>_SetBallTargetByPrediction where nothing calls it) and {TWIN} the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin_in` line in each bank carries the member's address. Every member's
; note is above its `twin_in` line. A fix here lands in every bank.

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
	bit 7, h
	jr z, .offset
	xor a
	sub l
	ld l, a
	sbc a
	sub h
	ld h, a
.offset:
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
	jr z, .zero
	xor a
	sub e
	ld e, a
	sbc a
	sub d
	ld d, a
.zero:
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
	and $02
	jr z, .maskClear
	xor a
	sub e
	ld e, a
	sbc a
	sub d
	ld d, a
.maskClear:
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
