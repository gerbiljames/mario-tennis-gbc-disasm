; Shared by ApplyBallTrajectoryCapped_24, Unused_21_ApplyBallTrajectoryCapped,
; Unused_23_ApplyBallTrajectoryCapped, Unused_2c_ApplyBallTrajectoryCapped,
; Unused_2b_ApplyBallTrajectoryCapped, Unused_2a_ApplyBallTrajectoryCapped,
; Unused_20_ApplyBallTrajectoryCapped, Unused_22_ApplyBallTrajectoryCapped
; (banks $20, $21, $22, $23, $24, $2a, $2b, $2c).

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
