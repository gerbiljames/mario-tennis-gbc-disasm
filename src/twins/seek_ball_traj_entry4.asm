; SeekBallTrajEntry4_<bank>: one routine assembled into banks $20, $21, $22, $23, $24, $29, $2a, $2b, $2c through
; `twin seek_ball_traj_entry4, <bank>` -- {TWIN} is the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

SeekBallTrajEntry4_{TWIN}:
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
	add l
	ld l, a
	jr nc, .gotPtr
	inc h
.gotPtr:
	jr .loop
.done:
	ret
