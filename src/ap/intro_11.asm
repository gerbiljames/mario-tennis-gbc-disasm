; skip_intro: the opening tour's last save (Dorm Entrance, $4657), then the
; Dorm Room welcome the tour ends on.
ApSkipIntro:
	ld b, STORYLOC_DORM_ROOM
	ld c, $0f
	farcall SaveStoryReturnPoint
	farcall SaveStorySlotWithTimer
	ld a, $01
	farcall EraseStorySlotSaveData
	farcall SaveStorySlotWithTimer
	ld a, STORYLOC_DORM_ROOM
	ld [wStoryModeCurrentLocation], a
	ld a, $0f
	ld [wStoryModeEntryPoint], a
	ld a, $ff
	ld [wUnusedExitTriggerIdMirror], a
	ld [wStoryModeExitTriggerRequest], a
	ret
