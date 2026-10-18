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

; Island Open: exit $02, Mario World: exit $03 (Peach's Castle); B walks the
; player back off the gate cell (a 2x2 cell: two tiles north)
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
	farcall BeginCutsceneScriptMode
	script_face ACTOR_PLAYER, FACE_UP
	script_set_anim ACTOR_PLAYER, ANIM_WALK
	script_player_speed 0.75
	wram_bank WRAM_ACTORS
	ld hl, wActors + ACTORF_X
	ld a, [hl+]
	ld c, a
	ld a, [hl+]
	ld b, a
	ld a, [hl+]
	ld e, a
	ld d, [hl]
	dec d
	dec d
	xor a
	farcall MovePlayerToPosition
	farcall WaitPlayerMoveDone
	; the walk moved the sprite (slot 1); the leader it follows again
	; (slot 0) has to be there too, or it walks back onto the gate
	wram_bank WRAM_ACTORS
	ld hl, wActors + ACTOR_SIZE + ACTORF_X
	ld de, wActors + ACTORF_X
	ld bc, 4
	call CopyMemoryBC
	ld a, FACE_UP
	ld [wActors + ACTORF_HEADING], a
	farcall EndCutsceneScriptMode
	ret
