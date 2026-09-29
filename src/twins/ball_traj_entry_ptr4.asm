; BallTrajEntryPtr4_<bank>: one routine assembled into banks $20, $21, $22, $23, $24, $29, $2a, $2b, $2c through
; `twin_in ball_traj_entry_ptr4, <Label>, <bank>` -- {TWIN_LABEL} is the copy's name
; (Unused_<bank>_BallTrajEntryPtr4 where nothing reaches it) and {TWIN} the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

ASSERT STRCMP("{TWIN_LABEL}", "{BallTrajEntryPtr4_{TWIN}_NAME}") == 0
{TWIN_LABEL}:
	push hl
	ld l, e
	ld h, d
	add hl, hl
	add hl, hl
	ld l, h
	ld h, $00
	add hl, hl
	add hl, hl
	pop de
	add hl, de
	ret
