; SetBallTargetFromAim_<bank>: one routine assembled into banks $20, $21, $22, $23, $24, $29, $2a, $2b, $2c through
; `twin_in set_ball_target_from_aim, <Label>, <bank>` -- {TWIN_LABEL} is the copy's name
; (Unused_<bank>_SetBallTargetFromAim where nothing reaches it) and {TWIN} the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

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
