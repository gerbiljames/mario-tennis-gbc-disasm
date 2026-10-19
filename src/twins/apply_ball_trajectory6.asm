; Shared by Unused_24_ApplyBallTrajectory6, Unused_21_ApplyBallTrajectory6,
; Unused_23_ApplyBallTrajectory6, ApplyBallTrajectory6_2c,
; Unused_2b_ApplyBallTrajectory6, Unused_2a_ApplyBallTrajectory6,
; Unused_29_ApplyBallTrajectory6, Unused_20_ApplyBallTrajectory6,
; Unused_22_ApplyBallTrajectory6 (banks $20, $21, $22, $23, $24, $29, $2a,
; $2b, $2c).

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
