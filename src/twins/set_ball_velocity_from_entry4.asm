; SetBallVelocityFromEntry4_<bank>: one routine assembled into banks $20, $21, $22, $23, $24, $29, $2a, $2b, $2c through
; `twin_in set_ball_velocity_from_entry4, <Label>, <bank>` -- {TWIN_LABEL} is the copy's name
; (Unused_<bank>_SetBallVelocityFromEntry4 where nothing reaches it) and {TWIN} the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

ASSERT STRCMP("{TWIN_LABEL}", "{SetBallVelocityFromEntry4_{TWIN}_NAME}") == 0
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
	ld hl, wShotAimAngle
	ld a, [hl+]
	ld d, [hl]
	ld e, a
	pop hl
	farcall SetBallVelocityPolar
	ret
