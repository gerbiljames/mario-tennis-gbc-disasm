; ApplySpriteWobbleY_<bank>: one routine assembled into banks $16, $17 through
; `twin apply_sprite_wobble_y, <bank>` -- {TWIN} is the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

ApplySpriteWobbleY_{TWIN}:
	ldh a, [hVBlankCounter]
	and $0f
	ld hl, SpriteWobbleYTable_{TWIN}
	add l
	ld l, a
	jr nc, .readOffset
	inc h
.readOffset:
	ld a, [hl]
	ld b, a
	ld a, c
	or a
	jr z, .subtract
	ld a, b
	add e
	ld e, a
	ret
.subtract:
	ld a, e
	sub b
	ld e, a
	ret
