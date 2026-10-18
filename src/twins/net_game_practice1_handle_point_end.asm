; Shared by NetGamePractice1HandlePointEnd, NetGamePractice2HandlePointEnd,
; NetGamePractice3HandlePointEnd (bank $0b).

{TWIN_LABEL}:
	farcall UpdateScorePanelDisplay
	ld a, [wDrillPointJudgement]
	ld [wPointWinLoseFlag], a
	cp $01
	jr nz, .recordDrillPointResultBits
	ld hl, wDrillCounters + 4
	inc [hl]
.recordDrillPointResultBits:
	call RecordDrillPointResultBits
	call ShowQueuedDrillMessage
	farcall UpdatePointStats
	farcall AwardPoint
	ld a, [wDrillCounters + 4]
	ld [wPlayer1PointsWon], a
	xor a
	ld [wPlayer2PointsWon], a
	ld a, [wPlayer1PointsWon]
	ld b, $01
	farcall LoadPlayer1PointsDigitGfx
	ld a, [wPlayer2PointsWon]
	ld b, $01
	farcall LoadPlayer2PointsDigitGfx
	farcall StepMatchFrame
	ld a, $01
	ld hl, SyncPointWinLoseFlagTask
	call RegisterFrameTask
	farcall StartPointEndReactions
	ld hl, SyncPointWinLoseFlagTask
	call UnregisterFrameTask
	call PlayDrillPointEndSequence
	ret
