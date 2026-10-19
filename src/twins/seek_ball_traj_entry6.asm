; Shared by Unused_24_SeekBallTrajEntry6, SeekBallTrajEntry6_21,
; SeekBallTrajEntry6_23, SeekBallTrajEntry6_2c, Unused_2b_SeekBallTrajEntry6,
; Unused_2a_SeekBallTrajEntry6, Unused_29_SeekBallTrajEntry6,
; SeekBallTrajEntry6_20, SeekBallTrajEntry6_22 (banks $20, $21, $22, $23, $24,
; $29, $2a, $2b, $2c).

ASSERT STRCMP("{TWIN_LABEL}", "{SeekBallTrajEntry6_{TWIN}_NAME}") == 0
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
	ld a, $06
	add l
	ld l, a
	jr nc, .gotPtr
	inc h
.gotPtr:
	jr .loop
.done:
	ret
