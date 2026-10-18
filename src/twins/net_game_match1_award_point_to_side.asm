; Shared by NetGameMatch1AwardPointToSide, NetGameMatch2AwardPointToSide,
; NetGameMatch3AwardPointToSide, ServiceMatch3AwardPointToSide,
; ServiceMatch2AwardPointToSide, StrokeMatch2AwardPointToSide,
; StrokeMatch3AwardPointToSide (bank $0b).

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
