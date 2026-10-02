; DrawCornerBrackets_<bank>: one routine assembled into banks $1b, $38, $3b, $3e through
; `twin_in draw_corner_brackets, <Label>, <bank>` -- {TWIN_LABEL} is the copy's name
; (Unused_<bank>_DrawCornerBrackets where nothing reaches it) and {TWIN} the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

ASSERT STRCMP("{TWIN_LABEL}", "{DrawCornerBrackets_{TWIN}_NAME}") == 0
{TWIN_LABEL}:
	push de
	push bc
	ld c, $00
	ld b, OAM_BANK1 | 1
	call QueueSprite
	pop bc
	pop de
	push de
	push bc
	ld a, b
	add d
	ld d, a
	push de
	ld c, $00
	ld b, OAM_BANK1 | OAM_XFLIP | 1
	call QueueSprite
	pop de
	pop bc
	pop de
	push de
	push bc
	ld a, c
	add e
	ld e, a
	ld a, b
	add d
	ld d, a
	push de
	ld c, $00
	ld b, OAM_BANK1 | OAM_XFLIP | OAM_YFLIP | 1
	call QueueSprite
	pop de
	pop bc
	pop de
	ld a, e
	add c
	ld e, a
	push de
	ld c, $00
	ld b, OAM_BANK1 | OAM_YFLIP | 1
	call QueueSprite
	pop de
	ret
