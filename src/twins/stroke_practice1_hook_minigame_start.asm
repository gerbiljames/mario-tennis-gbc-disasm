; Shared by StrokePractice1Hook_MinigameStart, StrokePractice3Hook_MinigameStart (bank $0b).

{TWIN_LABEL}:
	ld a, $01
	ld [wDrillIsPracticeLesson], a
	xor a
	ld [wDrillCounters + DRILLCTR_STROKE_PASSES], a
	ld [wDrillCounters + DRILLCTR_OUTS], a
	ret
