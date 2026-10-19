; FetchText_<bank>, one copy in each of banks $1f, $25, $26, $30, $31, $32,
; $33, $34, $35, $36, $37, $5e, $6e.

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
	ld c, wTextBuffer_SIZE
	jr .loop
.nonZero:
	ld de, wShortTextBuffer
	ld c, wShortTextBuffer_SIZE
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
	ASSERT DEBUGSTEP_OFF == 0
	or a
	jr z, .restore
	sound BGM_CREDITS
.restore:
	pop hl
	pop de
	pop bc
	ret
