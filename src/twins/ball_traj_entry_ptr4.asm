; Shared by BallTrajEntryPtr4_24, Unused_21_BallTrajEntryPtr4,
; Unused_23_BallTrajEntryPtr4, BallTrajEntryPtr4_2c,
; Unused_2b_BallTrajEntryPtr4, Unused_2a_BallTrajEntryPtr4,
; Unused_29_BallTrajEntryPtr4, Unused_20_BallTrajEntryPtr4,
; Unused_22_BallTrajEntryPtr4 (banks $20, $21, $22, $23, $24, $29, $2a, $2b,
; $2c).

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
