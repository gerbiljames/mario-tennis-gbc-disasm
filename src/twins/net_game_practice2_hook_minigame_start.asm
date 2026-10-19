; Shared by NetGamePractice2Hook_MinigameStart, NetGamePractice3Hook_MinigameStart (bank $0b).

{TWIN_LABEL}:
	xor a
	ld [wDrillCounters + DRILLCTR_NET_OR_OUT], a
	ld [wDrillCounters + DRILLCTR_PASSES], a
	ld a, $04
	ld [wDrillCounters + DRILLCTR_SHOTS_LEFT], a
	ld a, $01
	ld [wDrillIsPracticeLesson], a
	ret
