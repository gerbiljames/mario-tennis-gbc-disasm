; Shared by ApplyBallTrajectory4Capped_24,
; Unused_21_ApplyBallTrajectory4Capped, Unused_23_ApplyBallTrajectory4Capped,
; Unused_2c_ApplyBallTrajectory4Capped, Unused_2b_ApplyBallTrajectory4Capped,
; Unused_2a_ApplyBallTrajectory4Capped, Unused_29_ApplyBallTrajectory4Capped,
; Unused_20_ApplyBallTrajectory4Capped, Unused_22_ApplyBallTrajectory4Capped
; (banks $20, $21, $22, $23, $24, $29, $2a, $2b, $2c).

{TWIN_LABEL}:
	neg_bc
	ld a, [wShotDistMin]
	ld e, a
	ld a, [wShotDistMin + 1]
	ld d, a
	call {BallTrajEntryPtr4_{TWIN}_NAME}
	push hl
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	add hl, bc
	ld e, l
	ld d, h
	pop hl
	jp c, {ApplyBallTrajectory4_{TWIN}_NAME}.applyFallbackBallTrajectory
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
