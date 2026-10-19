; Shared by SeekBallTrajEntry4_24, Unused_21_SeekBallTrajEntry4,
; Unused_23_SeekBallTrajEntry4, SeekBallTrajEntry4_2c,
; Unused_2b_SeekBallTrajEntry4, Unused_2a_SeekBallTrajEntry4,
; Unused_29_SeekBallTrajEntry4, Unused_20_SeekBallTrajEntry4,
; Unused_22_SeekBallTrajEntry4 (banks $20, $21, $22, $23, $24, $29, $2a, $2b,
; $2c).

ASSERT STRCMP("{TWIN_LABEL}", "{SeekBallTrajEntry4_{TWIN}_NAME}") == 0
{TWIN_LABEL}:
	ld a, [wShotTrajRowMin]
	ld d, a
	ld a, [wShotTrajRowMax]
	ld e, a
.loop:
	push hl
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	add hl, bc
	pop hl
	jr c, .done
	ld a, d
	cp e
	jr nc, .done
	inc d
	ld a, $04
	add_hl_a
	jr .loop
.done:
	ret
