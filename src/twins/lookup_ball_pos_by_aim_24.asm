; Shared by LookupBallPosByAim_24, Unused_2c_LookupBallPosByAim (banks $24,
; $2c).

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
