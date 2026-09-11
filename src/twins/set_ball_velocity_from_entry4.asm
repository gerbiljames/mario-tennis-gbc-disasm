; SetBallVelocityFromEntry4_<bank>: one routine assembled into banks $20, $21, $22, $23, $24, $29, $2a, $2b, $2c through
; `twin set_ball_velocity_from_entry4, <bank>` -- {TWIN} is the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

SetBallVelocityFromEntry4_{TWIN}:
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
