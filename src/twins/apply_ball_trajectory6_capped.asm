; Shared by Unused_24_ApplyBallTrajectory6Capped,
; ApplyBallTrajectory6Capped_21, ApplyBallTrajectory6Capped_23,
; Unused_2c_ApplyBallTrajectory6Capped, Unused_2b_ApplyBallTrajectory6Capped,
; Unused_2a_ApplyBallTrajectory6Capped, Unused_29_ApplyBallTrajectory6Capped,
; ApplyBallTrajectory6Capped_20, ApplyBallTrajectory6Capped_22 (banks $20,
; $21, $22, $23, $24, $29, $2a, $2b, $2c).

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
