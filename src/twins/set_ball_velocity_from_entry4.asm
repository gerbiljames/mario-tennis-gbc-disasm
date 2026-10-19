; Shared by SetBallVelocityFromEntry4_24, Unused_21_SetBallVelocityFromEntry4,
; Unused_23_SetBallVelocityFromEntry4, SetBallVelocityFromEntry4_2c,
; Unused_2b_SetBallVelocityFromEntry4, Unused_2a_SetBallVelocityFromEntry4,
; Unused_29_SetBallVelocityFromEntry4, Unused_20_SetBallVelocityFromEntry4,
; Unused_22_SetBallVelocityFromEntry4 (banks $20, $21, $22, $23, $24, $29,
; $2a, $2b, $2c).

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
