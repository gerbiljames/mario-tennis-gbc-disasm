; Shared by StrokePractice1Hook_MinigameStart, StrokePractice3Hook_MinigameStart (bank $0b).

{TWIN_LABEL}:
	ld a, $01
	ld [wDrillIsPracticeLesson], a
	xor a
	ld [wDrillCounters + 2], a
	ld [wDrillCounters + 1], a
	ret
