; Shared by NetGamePractice2Hook_MinigameStart, NetGamePractice3Hook_MinigameStart (bank $0b).

{TWIN_LABEL}:
	xor a
	ld [wDrillCounters + 3], a
	ld [wDrillCounters + 4], a
	ld a, $04
	ld [wDrillCounters + 5], a
	ld a, $01
	ld [wDrillIsPracticeLesson], a
	ret
