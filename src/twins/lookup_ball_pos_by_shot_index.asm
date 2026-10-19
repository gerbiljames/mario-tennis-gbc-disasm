; LookupBallPosByShotIndex_<bank>, one copy in each of banks $20, $21, $22,
; $23, $24, $29, $2a, $2b.

LookupBallPosByShotIndex_{TWIN}:
	ld e, l
	ld d, h
	add a
	ld l, c
	ld h, b
	add_hl_a
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	add hl, de
	ret
