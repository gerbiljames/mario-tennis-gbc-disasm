; FetchText_<bank>: one routine assembled into banks $1f, $25, $26, $30, $31, $32, $33, $34, $35, $36, $37, $5e, $6e through
; `twin fetch_text, <bank>` -- {TWIN} is the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

FetchText_{TWIN}:
	push bc
	push de
	push hl
	ld hl, FetchTextTable_{TWIN}
	sla e
	rl d
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, TextStrings_{TWIN}
	add hl, de
	or a
	jr nz, .nonZero
	ld de, wTextBuffer
	ld c, $a0
	jr .loop
.nonZero:
	ld de, wShortTextBuffer
	ld c, $10
.loop:
	dec c
	jr z, .countDone
	ld a, [hl+]
	ld [de], a
	inc de
	or a
	jr nz, .loop
	pop hl
	pop de
	pop bc
	ret
.countDone:
	xor a
	ld [de], a
	ldh a, [hDebugStepMode]
	or a
	jr z, .restore
	sound BGM_CREDITS
.restore:
	pop hl
	pop de
	pop bc
	ret
