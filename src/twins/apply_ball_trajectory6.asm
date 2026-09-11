; ApplyBallTrajectory6_<bank>: one routine assembled into banks $20, $21, $22, $23, $24, $29, $2a, $2b, $2c through
; `twin apply_ball_trajectory6, <bank>` -- {TWIN} is the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

ApplyBallTrajectory6_{TWIN}:
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
	call BallTrajEntryPtr6_{TWIN}
	call SeekBallTrajEntry6_{TWIN}
	push de
	call SetBallVelocityFromEntry6_{TWIN}
	pop de
	ld h, d
	ld l, $00
	sra h
	rr l
	sra h
	rr l
	call SetBallTargetFromAim_{TWIN}
	ret
