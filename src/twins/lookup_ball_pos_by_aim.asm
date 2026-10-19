; Shared by Unused_21_LookupBallPosByAim, Unused_23_LookupBallPosByAim,
; Unused_2b_LookupBallPosByAim, Unused_2a_LookupBallPosByAim,
; Unused_29_LookupBallPosByAim, Unused_20_LookupBallPosByAim,
; Unused_22_LookupBallPosByAim (banks $20, $21, $22, $23, $29, $2a, $2b).

{TWIN_LABEL}:
	push hl
	push bc
	ld hl, wShotAimAngle
	ld a, [hl+]
	ld b, [hl]
	ld c, a
	ld hl, wBallDepth
	ld a, [hl+]
	ld d, [hl]
	ld e, a
	ld hl, wBallX
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	call VectorLengthFromAngle
	add hl, hl
	ld a, h
	and $1f
	ld [wShotAimRow], a
	add a
	pop hl
	pop de
	add_hl_a
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	add hl, de
	ret
