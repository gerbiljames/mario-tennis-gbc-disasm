; SeekBallTrajEntry6_<bank>: one routine assembled into banks $20, $21, $22, $23, $24, $29, $2a, $2b, $2c through
; `twin_in seek_ball_traj_entry6, <Label>, <bank>` -- {TWIN_LABEL} is the copy's name
; (Unused_<bank>_SeekBallTrajEntry6 where nothing reaches it) and {TWIN} the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

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
