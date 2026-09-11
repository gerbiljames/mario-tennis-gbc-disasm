; LookupBallPosByHeight_<bank>: one routine assembled into banks $20, $21, $22, $23, $24, $29, $2a, $2b, $2c through
; `twin lookup_ball_pos_by_height, <bank>` -- {TWIN} is the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

LookupBallPosByHeight_{TWIN}:
	ld e, l
	ld d, h
	ld hl, wBallHeight
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	xor a
	sub l
	ld l, a
	sbc a
	sub h
	ld h, a
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld a, h
	and $1f
	add a
	ld l, c
	ld h, b
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
