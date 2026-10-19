; Shared by SetBallTargetFromAim_24, SetBallTargetFromAim_21,
; SetBallTargetFromAim_23, SetBallTargetFromAim_2c,
; Unused_2b_SetBallTargetFromAim, Unused_2a_SetBallTargetFromAim,
; Unused_29_SetBallTargetFromAim, SetBallTargetFromAim_20,
; SetBallTargetFromAim_22 (banks $20, $21, $22, $23, $24, $29, $2a, $2b, $2c).

ASSERT STRCMP("{TWIN_LABEL}", "{SetBallTargetFromAim_{TWIN}_NAME}") == 0
{TWIN_LABEL}:
	ld a, [wShotAimAngle]
	ld c, a
	ld a, [wShotAimAngle + 1]
	ld b, a
	call MulSinCos
	ld c, l
	ld b, h
	ld hl, wBallX
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	add hl, bc
	ld c, l
	ld b, h
	ld hl, wBallTargetX
	ld a, c
	ld [hl+], a
	ld [hl], b
	ld hl, wBallDepth
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	ld hl, wBallTargetDepth
	ld a, e
	ld [hl+], a
	ld [hl], d
	ret
