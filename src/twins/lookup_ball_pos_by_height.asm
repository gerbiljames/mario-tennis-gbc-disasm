; LookupBallPosByHeight_<bank>, one copy in each of banks $20, $21, $22, $23,
; $24, $29, $2a, $2b, $2c.

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
