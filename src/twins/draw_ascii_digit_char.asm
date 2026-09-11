; DrawAsciiDigitChar_<bank>: one routine assembled into banks $16, $17, $1b, $3b, $3e through
; `twin draw_ascii_digit_char, <bank>` -- {TWIN} is the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

DrawAsciiDigitChar_{TWIN}:
	push hl
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH
	sub $30
	jr c, .carry
	add $30
	ld b, a
	wram_bank $03
	ld a, b
	ld [de], a
	inc de
	pop hl
	ret
.carry:
	inc de
	pop hl
	ret
