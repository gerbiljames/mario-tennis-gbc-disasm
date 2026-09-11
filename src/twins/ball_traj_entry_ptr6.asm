; BallTrajEntryPtr6_<bank>: one routine assembled into banks $20, $21, $22, $23, $24, $29, $2a, $2b, $2c through
; `twin ball_traj_entry_ptr6, <bank>` -- {TWIN} is the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

BallTrajEntryPtr6_{TWIN}:
	push hl
	ld l, e
	ld h, d
	add hl, hl
	add hl, hl
	ld l, h
	ld h, $00
	ld e, l
	ld d, h
	add hl, hl
	add hl, de
	add hl, hl
	pop de
	add hl, de
	ret
