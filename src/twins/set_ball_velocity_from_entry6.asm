; Shared by SetBallVelocityFromEntry6_24, SetBallVelocityFromEntry6_21,
; SetBallVelocityFromEntry6_23, SetBallVelocityFromEntry6_2c,
; Unused_2b_SetBallVelocityFromEntry6, Unused_2a_SetBallVelocityFromEntry6,
; Unused_29_SetBallVelocityFromEntry6, SetBallVelocityFromEntry6_20,
; SetBallVelocityFromEntry6_22 (banks $20, $21, $22, $23, $24, $29, $2a, $2b,
; $2c).

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
