; Called from RunStoryLocation's idle loop when no event is waiting: applies
; received items to the slot and opens the next Archipelago message, frozen
; as an event would freeze the player. -> nz if a message was shown.
ApStoryIdle:
	ld a, [wStoryModeCurrentLocation]
	cp STORYLOC_MAIN_MENU
	jr z, .none
	ldh a, [hFadeState]
	and a
	jr nz, .none
	test_flag FLAG_ENDING_CREDITS_RUNNING
	jr nz, .none
	apcall ApCatchUpSlot
	apcall ApNextMessage
	and a
	ret z
	wram_bank WRAM_ACTORS
	ld bc, wActors
	ld hl, ActorScript_0a
	ldh a, [hRomBank]
	farcall SetActorScript
	ld hl, wActors + $18
	ld [hl], $01
	call WaitPlayerMoveDone
	ld hl, AP_MESSAGE_TEXT
	ld a, $80
	farcall ShowSpeakerDialogue
	or 1
	ret
.none:
	xor a
	ret

; e = a story match's packed length (sets << 4 | games) -> e and a with the
; story_match_sets / story_match_games option bytes in place of nonzero ones
ApOverrideMatchLength:
	ld a, [ApOptMatchGames]
	and a
	jr z, .sets
	ld d, a
	ld a, e
	and $f0
	or d
	ld e, a
.sets:
	ld a, [ApOptMatchSets]
	and a
	jr z, .done
	swap a
	ld d, a
	ld a, e
	and $0f
	or d
	ld e, a
.done:
	ld a, e
	ret
