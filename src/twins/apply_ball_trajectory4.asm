; Shared by Unused_24_ApplyBallTrajectory4, Unused_21_ApplyBallTrajectory4,
; Unused_23_ApplyBallTrajectory4, ApplyBallTrajectory4_2c,
; Unused_2b_ApplyBallTrajectory4, Unused_2a_ApplyBallTrajectory4,
; Unused_29_ApplyBallTrajectory4, Unused_20_ApplyBallTrajectory4,
; Unused_22_ApplyBallTrajectory4 (banks $20, $21, $22, $23, $24, $29, $2a,
; $2b, $2c).

ASSERT STRCMP("{TWIN_LABEL}", "{ApplyBallTrajectory4_{TWIN}_NAME}") == 0
{TWIN_LABEL}:
	neg_bc
	ld a, [wShotDistMin]
	ld e, a
	ld a, [wShotDistMin + 1]
	ld d, a
	call {BallTrajEntryPtr4_{TWIN}_NAME}
	call {SeekBallTrajEntry4_{TWIN}_NAME}
	push de
	call {SetBallVelocityFromEntry4_{TWIN}_NAME}
	pop de
	ld h, d
	ld l, $00
	sra h
	rr l
	sra h
	rr l
	call {SetBallTargetFromAim_{TWIN}_NAME}
	ret
.applyFallbackBallTrajectory:
	farcall ApplyFallbackBallTrajectory_24
	ret
