; After the principal's congratulations, with Peach's Castle still locked: no
; walk out to the plane. The arc is complete as Island Sky would mark it, and
; the player stays in the Academy Wing corridor.
ApStayAfterCeremony_10:
	test_flag FLAG_DOUBLES
	jr nz, .doubles
	set_flag FLAG_STORY_COMPLETE_SINGLES
	jr .save
.doubles:
	set_flag FLAG_STORY_COMPLETE_DOUBLES
.save:
	farcall SaveStorySlotWithTimer
	script_set_position ACTOR_PLAYER, 43.0, 59.0
	ld hl, wStoryModePlayersXPosition
	ld de, wStoryModeSpawnPosition
	ld bc, wStoryModeSpawnPosition_SIZE
	call CopyMemoryBC
	ld a, STORYENTRY_NONE
	ld [wStoryModeEntryPoint], a
	ld [wUnusedExitTriggerIdMirror], a
	ld [wStoryModeExitTriggerRequest], a
	ret
