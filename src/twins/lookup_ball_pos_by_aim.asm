; LookupBallPosByAim_<bank>: one routine assembled into banks $20, $21, $22, $23, $29, $2a, $2b through
; `twin lookup_ball_pos_by_aim, <bank>` -- {TWIN} is the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

LookupBallPosByAim_{TWIN}:
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
	jr nc, .readEntry
	inc h
.readEntry:
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	add hl, de
	ret
