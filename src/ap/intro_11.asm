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
	ld a, EXITTRIGGER_DIRECT
	ld [wUnusedExitTriggerIdMirror], a
	ld [wStoryModeExitTriggerRequest], a
	ret

; Island Open: exit $02, Mario World: exit $03 (Peach's Castle); B walks the
; player back off the gate cell (a 2x2 cell: two tiles north), then hands
; them back to the controls
ApFrontGateTile_11:
	apcall ApComposeGateMenu
	ld hl, AP_MESSAGE_TEXT
	ld de, $0101
	ld a, $01
	farcall RunPagedTextMenu
	cp $ff
	jr z, .cancel
	and a
	ld a, $02
	jr z, .exit
	ld a, $03
.exit:
	ld [wUnusedExitTriggerIdMirror], a
	ld [wStoryModeExitTriggerRequest], a
	ret
.cancel:
	script_set_actor_script ACTOR_PLAYER, ApGateBackOffScript_11
	script_wait_actor_script ACTOR_PLAYER
	ld bc, wActors
	farcall AttachActorControllerScript
	ret

ApGateBackOffScript_11:
	as_anim ANIM_WALK
	as_set_field ACTORF_HEADING, FACE_UP
	as_move_by 0.0, -2.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
