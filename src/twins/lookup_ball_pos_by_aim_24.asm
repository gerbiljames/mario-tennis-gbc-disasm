; LookupBallPosByAim_<bank>: one routine assembled into banks $24, $2c through
; `twin_in lookup_ball_pos_by_aim_24, <Label>, <bank>` -- {TWIN_LABEL} is the copy's name
; (Unused_<bank>_LookupBallPosByAim where nothing calls it) and {TWIN} the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin_in` line in each bank carries the member's address. Every member's
; note is above its `twin_in` line. A fix here lands in every bank.

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
	add l
	ld l, a
	jr nc, .read
	inc h
.read:
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	add hl, de
	ret
