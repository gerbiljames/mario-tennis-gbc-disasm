; SetBallVelocityFromEntry6_<bank>: one routine assembled into banks $20, $21, $22, $23, $24, $29, $2a, $2b, $2c through
; `twin_in set_ball_velocity_from_entry6, <Label>, <bank>` -- {TWIN_LABEL} is the copy's name
; (Unused_<bank>_SetBallVelocityFromEntry6 where nothing reaches it) and {TWIN} the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

ASSERT STRCMP("{TWIN_LABEL}", "{SetBallVelocityFromEntry6_{TWIN}_NAME}") == 0
{TWIN_LABEL}:
	ld a, [hl+]
	ld c, a
	ld a, [hl+]
	ld b, a
	push bc
	ld a, [hl+]
	ld c, a
	ld a, [hl+]
	ld b, a
	ld a, [hl+]
	ld e, a
	ld a, [hl+]
	ld d, a
	ld a, [wShotAimMirror]
	and a
	jr z, .zero
	xor a
	sub e
	ld e, a
	sbc a
	sub d
	ld d, a
.zero:
	ld hl, wShotAimAngle
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	pop hl
	farcall SetBallVelocityPolar
	ret
