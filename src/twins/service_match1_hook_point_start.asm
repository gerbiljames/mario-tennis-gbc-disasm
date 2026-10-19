; Shared by ServiceMatch1Hook_PointStart, ServiceMatch3Hook_PointStart (bank $0b).

{TWIN_LABEL}:
	xor a
	ld [wDrillAbortCountdownActive], a
	ld a, DRILL_ABORT_FRAMES
	ld [wDrillAbortCountdown], a
	ASSERT DRILLMSG_NONE == 0
	xor a
	ld [wDrillMessageId], a
	xor a
	ld [wDrillPointJudgement], a
	ret
