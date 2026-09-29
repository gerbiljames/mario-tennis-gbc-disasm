; ApplyBallTrajectoryCapped_<bank>: one routine assembled into banks $20, $21, $22, $23, $24, $2a, $2b, $2c through
; `twin_in apply_ball_trajectory_capped, <Label>, <bank>` -- {TWIN_LABEL} is the copy's name
; (Unused_<bank>_ApplyBallTrajectoryCapped where nothing calls it) and {TWIN} the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin_in` line in each bank carries the member's address. Every member's
; note is above its `twin_in` line. A fix here lands in every bank.

{TWIN_LABEL}:
	push hl
	ld hl, wShotAimAngle
	ld a, [hl+]
	ld b, [hl]
	ld c, a
	ld hl, wShotAimDeltaDepth
	ld a, [hl+]
	ld d, [hl]
	ld e, a
	ld hl, wShotAimDeltaX
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	call VectorLengthFromAngle
	ld e, l
	ld d, h
	ld hl, wShotDistMax
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	ld a, l
	sub e
	ld l, a
	ld a, h
	sbc d
	ld h, a
	jr nc, .restore
	ld hl, wShotDistMax
	ld a, [hl+]
	ld d, [hl]
	ld e, a
.restore:
	pop hl
	push de
	call {BallTrajEntryPtr6_{TWIN}_NAME}
	call {SetBallVelocityFromEntry6_{TWIN}_NAME}
	pop hl
	call {SetBallTargetFromAim_{TWIN}_NAME}
	ret
