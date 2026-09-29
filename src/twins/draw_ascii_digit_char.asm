; DrawAsciiDigitChar_<bank>: one routine assembled into banks $16, $17, $1b, $3b, $3e through
; `twin_in draw_ascii_digit_char, <Label>, <bank>` -- {TWIN_LABEL} is the copy's name
; (Unused_<bank>_DrawAsciiDigitChar where nothing reaches it) and {TWIN} the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

ASSERT STRCMP("{TWIN_LABEL}", "{DrawAsciiDigitChar_{TWIN}_NAME}") == 0
{TWIN_LABEL}:
	push hl
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH
	sub $30
	jr c, .carry
	add $30
	ld b, a
	wram_bank WRAM_SCREEN
	ld a, b
	ld [de], a
	inc de
	pop hl
	ret
.carry:
	inc de
	pop hl
	ret
