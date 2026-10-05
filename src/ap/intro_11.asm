; skip_intro: the opening tour's last save (Dorm Entrance, $4657), then the
; Dorm Room as Continue enters it ($01): the roommate's short greeting, not
; the end-of-day jingle and welcome ($0f) the tour ends on.
ApSkipIntro:
	ld b, STORYLOC_DORM_ROOM
	ld c, $01
	farcall SaveStoryReturnPoint
	farcall SaveStorySlotWithTimer
	ld a, $01
	farcall EraseStorySlotSaveData
	farcall SaveStorySlotWithTimer
	ld a, STORYLOC_DORM_ROOM
	ld [wStoryModeCurrentLocation], a
	ld a, $01
	ld [wStoryModeEntryPoint], a
	ld a, $ff
	ld [wUnusedExitTriggerIdMirror], a
	ld [wStoryModeExitTriggerRequest], a
	ret

; Yes: exit $02 (the Island Open), No: exit $03 (Peach's Castle)
ApFrontGateTile_11:
	apcall ApComposeGatePrompt
	script_set_text AP_MESSAGE_TEXT
	script_speak_restore ACTOR_PLAYER
	farcall RunDialogueYesNoPrompt
	farcall ScriptCloseDialogueWindow
	and a
	ld a, $02
	jr z, .exit
	ld a, $03
.exit:
	ld [wUnusedExitTriggerIdMirror], a
	ld [wStoryModeExitTriggerRequest], a
	ret
