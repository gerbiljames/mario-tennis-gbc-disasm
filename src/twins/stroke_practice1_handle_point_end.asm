; Shared by StrokePractice1HandlePointEnd, StrokePractice3HandlePointEnd (bank
; $0b).

{TWIN_LABEL}:
	farcall UpdateScorePanelDisplay
	ld a, [wDrillPointJudgement]
	ld [wPointWinLoseFlag], a
	cp WINLOSE_WIN
	jr nz, .recordDrillPointResultBits
	ld hl, wDrillCounters + DRILLCTR_STROKE_PASSES
	inc [hl]
.recordDrillPointResultBits:
	call RecordDrillPointResultBits
	call ShowQueuedDrillMessage
	farcall UpdatePointStats
	farcall AwardPoint
	ld a, [wDrillCounters + DRILLCTR_STROKE_PASSES]
	ld [wPlayer1PointsWon], a
	xor a
	ld [wPlayer2PointsWon], a
	ld a, [wPlayer1PointsWon]
	ld b, DIGITGFX_NUMERALS
	farcall LoadPlayer1PointsDigitGfx
	ld a, [wPlayer2PointsWon]
	ld b, DIGITGFX_NUMERALS
	farcall LoadPlayer2PointsDigitGfx
	farcall StepMatchFrame
	frame_task SyncPointWinLoseFlagTask
	farcall StartPointEndReactions
	ld hl, SyncPointWinLoseFlagTask
	call UnregisterFrameTask
	call PlayDrillPointEndSequence
	ret
