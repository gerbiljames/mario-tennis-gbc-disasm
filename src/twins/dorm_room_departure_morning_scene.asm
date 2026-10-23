; Shared by DormRoomDepartureMorningAltScene, DormRoomDepartureMorningScene (bank $13).

{TWIN_LABEL}:
	script_set_text Text_NarrationMorningOfDeparture
	call ShowStoryNarration_13
	ld a, STORYLOC_ACADEMY_ENTRANCE
	ld [wStoryModeCurrentLocation], a
	ld a, ENTRY_ACADEMY_ENTRANCE_DEPART_FOR_ISLAND_OPEN
	ld [wStoryModeEntryPoint], a
	ld a, EXITTRIGGER_DIRECT
	ld [wUnusedExitTriggerIdMirror], a
	ld [wStoryModeExitTriggerRequest], a
	ret
