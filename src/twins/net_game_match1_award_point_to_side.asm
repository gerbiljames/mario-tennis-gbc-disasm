; One body under 7 names (banks $0b, $0b, $0b, $0b, $0b, $0b, $0b), assembled through
; `twin_named net_game_match1_award_point_to_side, <Label>` -- {TWIN_LABEL} is the label the bank gives it.
; No per-instruction addresses: the `twin_named` line carries the member's.
; A fix here lands in every copy.

{TWIN_LABEL}:
	ld a, [wPointWinLoseFlag]
	or a
	ret z
	inc a
	srl a
	ld b, a
	ld a, [wTotalPointsScoredInCurrentGame]
	and $01
	xor $01
	add b
	bit 0, a
	jr nz, .clearServeFaultFlag
	ld hl, wPlayer2PointsWon
	bit 1, a
	jr z, .bump
	ld hl, wPlayer1PointsWon
.bump:
	inc [hl]
.clearServeFaultFlag:
	xor a
	ld [wServeFaultFlag], a
	ld hl, wTotalPointsScoredInCurrentGame
	inc [hl]
	ret
