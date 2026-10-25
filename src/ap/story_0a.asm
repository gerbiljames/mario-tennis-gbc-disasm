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
	ld hl, ActorScript_Null
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

; a = a story match's court -> a, this seed's court for the match unless its
; ApCourtTable entry is AP_COURT_VANILLA; keeps hl, clobbers de
ApOverrideCourt:
	ld e, a
	push hl
	ld a, [wCurrentMatchList]
	cp MATCHLIST_DOUBLES
	ld a, [wCurrentMatchIndex]
	jr nz, .haveRow
	add AP_STORY_MATCH_ROWS
.haveRow:
	ld hl, ApCourtTable
	add_hl_a
	ld a, [hl]
	pop hl
	cp AP_COURT_VANILLA
	ret nz
	ld a, e
	ret

; the singles rows, then the doubles rows
ApCourtTable:
	ASSERT DoublesMatchSettingsTable_0a - SinglesMatchSettingsTable_0a == AP_STORY_MATCH_ROWS * 5
	ds 2 * AP_STORY_MATCH_ROWS, AP_COURT_VANILLA

; Sets a singles story opponent's home-position strategy (doubles AI never
; reads it) to the match's ApStrategyTable entry unless AP_STRATEGY_VANILLA
ApOverrideOpponentStrategy:
	ld a, [wCurrentMatchList]
	cp MATCHLIST_SINGLES
	ret nz
	ld a, [wCurrentMatchIndex]
	ld hl, ApStrategyTable
	add_hl_a
	ld a, [hl]
	cp AP_STRATEGY_VANILLA
	ret z
	ld [wPlayer2MainAiPosition], a
	ret

; the singles rows
ApStrategyTable:
	ds AP_STORY_MATCH_ROWS, AP_STRATEGY_VANILLA
