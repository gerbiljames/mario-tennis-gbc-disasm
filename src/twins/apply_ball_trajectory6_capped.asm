; ApplyBallTrajectory6Capped_<bank>: one routine assembled into banks $20, $21, $22, $23, $24, $29, $2a, $2b, $2c through
; `twin_in apply_ball_trajectory6_capped, <Label>, <bank>` -- {TWIN_LABEL} is the copy's name
; (Unused_<bank>_ApplyBallTrajectory6Capped where nothing calls it) and {TWIN} the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin_in` line in each bank carries the member's address. Every member's
; note is above its `twin_in` line. A fix here lands in every bank.

{TWIN_LABEL}:
	xor a
	sub c
	ld c, a
	sbc a
	sub b
	ld b, a
	ld a, [wShotDistMin]
	ld e, a
	ld a, [wShotDistMin + 1]
	ld d, a
	call {BallTrajEntryPtr6_{TWIN}_NAME}
	push hl
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	add hl, bc
	ld e, l
	ld d, h
	pop hl
	jp c, {ApplyBallTrajectory4_{TWIN}_NAME}.applyFallbackBallTrajectory
	call {SeekBallTrajEntry6_{TWIN}_NAME}
	push de
	call {SetBallVelocityFromEntry6_{TWIN}_NAME}
	pop de
	ld h, d
	ld l, $00
	sra h
	rr l
	sra h
	rr l
	call {SetBallTargetFromAim_{TWIN}_NAME}
	ret
