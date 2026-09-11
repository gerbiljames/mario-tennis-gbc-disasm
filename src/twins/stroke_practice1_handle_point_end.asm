; One body under 2 names (banks $0b, $0b), assembled through
; `twin_named stroke_practice1_handle_point_end, <Label>` -- {TWIN_LABEL} is the label the bank gives it.
; No per-instruction addresses: the `twin_named` line carries the member's.
; A fix here lands in every copy.

{TWIN_LABEL}:
	farcall UpdateScorePanelDisplay
	ld a, [wDrillPointJudgement]
	ld [wPointWinLoseFlag], a
	cp $01
	jr nz, .recordDrillPointResultBits
	ld hl, wDrillCounters + 2
	inc [hl]
.recordDrillPointResultBits:
	call RecordDrillPointResultBits
	call ShowQueuedDrillMessage
	farcall UpdatePointStats
	farcall AwardPoint
	ld a, [wDrillCounters + 2]
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
