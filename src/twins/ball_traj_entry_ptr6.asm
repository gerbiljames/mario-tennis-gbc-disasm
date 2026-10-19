; Shared by BallTrajEntryPtr6_24, BallTrajEntryPtr6_21, BallTrajEntryPtr6_23,
; BallTrajEntryPtr6_2c, Unused_2b_BallTrajEntryPtr6,
; Unused_2a_BallTrajEntryPtr6, Unused_29_BallTrajEntryPtr6,
; BallTrajEntryPtr6_20, BallTrajEntryPtr6_22 (banks $20, $21, $22, $23, $24,
; $29, $2a, $2b, $2c).

ASSERT STRCMP("{TWIN_LABEL}", "{BallTrajEntryPtr6_{TWIN}_NAME}") == 0
{TWIN_LABEL}:
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
