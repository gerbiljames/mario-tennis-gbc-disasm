; The check points: each hook names a location, and ApCheckLocation marks it
; done and grants this world's item placed there.

; d = reward list (wCurrentMinigameStoryMatch), e = its index
; (GetRewardTableIndex), as SetRewardGameFlag sets the vanilla flag
ApCheckReward:
	ld a, d
	cp 3
	ret nc
	ld a, e
	cp AP_REWARD_LIST_SIZE
	ret nc
	ld a, d
	swap a
	add a
	add e
	ld e, a
	ld d, 0
	ld hl, ApRewardLocations
	add hl, de
	ld a, [hl]
	cp AP_NO_LOCATION
	ret z
	ld e, a
	jr ApCheckLocation

; a Mario mini-game won, at wMinigameLevel of game wCurrentMinigameStoryMatch + 1
ApCheckMinigameClear:
	ld a, [wCurrentMinigameStoryMatch + 1]
	sub MINIGAME_BOO_BLAST
	ret c
	cp NUM_MARIO_MINIGAMES
	ret nc
	ld e, a
	add a
	add e
	ld e, a
	ld a, [wMinigameLevel]
	cp 3
	ret nc
	add e
	add LOC_BOO_BLAST_1
	ld e, a
	jr ApCheckLocation

; a level-3 score beating the game's default record, for the games whose
; record unlocks a court (SetMinigameRecordSaveFlag)
ApCheckMinigameRecord:
	ld a, [wMinigameLevel]
	cp 2
	ret nz
	ld a, [wCurrentMinigameStoryMatch + 1]
	ld e, LOC_SHOOTING_STAR_RECORD
	cp MINIGAME_SHOOTING_STAR
	jr z, .game
	ld e, LOC_TARGET_SHOT_RECORD
	cp MINIGAME_TARGET_SHOT
	jr z, .game
	ld e, LOC_BANANA_BUNCH_RECORD
	cp MINIGAME_BANANA_BUNCH
	ret nz
.game:
	push de
	sub MINIGAME_BOO_BLAST - 2
	farcall GetDefaultMinigameRecordValue
	ld hl, wMinigamesCurrentScore
	ld a, e
	sub [hl]
	inc hl
	ld a, d
	sbc [hl]
	pop de
	ret nc
	jr ApCheckLocation

; after the swing contest's count: one location per threshold reached
ApCheckSwingContest:
	ld a, [ApOptSwingLow]
	and a
	jr nz, .low
	ld a, SWING_CONTEST_LOW
.low:
	call .reached
	ld e, LOC_SWING_CONTEST_LOW
	call nc, ApCheckLocation
	ld a, [ApOptSwingHigh]
	and a
	jr nz, .high
	ld a, SWING_CONTEST_HIGH
.high:
	call .reached
	ld e, LOC_SWING_CONTEST_HIGH
	ret c
	jr ApCheckLocation

; a = threshold -> nc if wSwingContestSwings reaches it
.reached:
	ld b, a
	ld a, [wSwingContestSwings + 1]
	and a
	ret nz
	ld a, [wSwingContestSwings]
	cp b
	ret

; e = location id: marks it done; the first time, grants this world's item
; placed there
ApCheckLocation:
	push de
	call ApSetLocationDone
	pop de
	and a
	ret z
	ld d, 0
	ld hl, ApPlacements
	add hl, de
	ld a, [hl]
	and a
	ret z
	ld e, a
	jp ApGrantItem

; per reward list, the location of each index (AP_NO_LOCATION for none)
ApRewardLocations:
	db AP_NO_LOCATION
	db LOC_JUNIOR_SINGLES_RANK_4, LOC_JUNIOR_SINGLES_RANK_3, LOC_JUNIOR_SINGLES_RANK_2, LOC_JUNIOR_SINGLES_RANK_1
	db AP_NO_LOCATION
	db LOC_SENIOR_SINGLES_RANK_4, LOC_SENIOR_SINGLES_RANK_3, LOC_SENIOR_SINGLES_RANK_2, LOC_SENIOR_SINGLES_RANK_1
	db AP_NO_LOCATION
	db LOC_VARSITY_SINGLES_RANK_4
	ds 4, AP_NO_LOCATION
	db LOC_ISLAND_OPEN_SINGLES_ROUND_1, LOC_ISLAND_OPEN_SINGLES_ROUND_2
	db LOC_ISLAND_OPEN_SINGLES_SEMIFINAL, LOC_ISLAND_OPEN_SINGLES_FINAL
	ds 2, AP_NO_LOCATION
	ds 3, LOC_DREAM_MATCH_SINGLES
	ds AP_REWARD_LIST_SIZE - 25, AP_NO_LOCATION

	ds 2, AP_NO_LOCATION
	db LOC_JUNIOR_DOUBLES_RANK_3, LOC_JUNIOR_DOUBLES_RANK_2, LOC_JUNIOR_DOUBLES_RANK_1
	ds 2, AP_NO_LOCATION
	db LOC_SENIOR_DOUBLES_RANK_3, LOC_SENIOR_DOUBLES_RANK_2, LOC_SENIOR_DOUBLES_RANK_1
	ds 3, AP_NO_LOCATION
	db LOC_VARSITY_DOUBLES_RANK_2
	ds 3, AP_NO_LOCATION
	db LOC_ISLAND_OPEN_DOUBLES_ROUND_1, LOC_ISLAND_OPEN_DOUBLES_SEMIFINAL, LOC_ISLAND_OPEN_DOUBLES_FINAL
	ds 2, AP_NO_LOCATION
	ds 3, LOC_DREAM_MATCH_DOUBLES
	ds AP_REWARD_LIST_SIZE - 25, AP_NO_LOCATION

; drills by minigame id; the two Expert levels are not locations
FOR I, MINIGAME_WALL_PRACTICE_HIGH_SCORE + 1
	db LOC_SERVICE_MATCH_1 + I
ENDR
	ds AP_REWARD_LIST_SIZE - (MINIGAME_WALL_PRACTICE_HIGH_SCORE + 1), AP_NO_LOCATION
	ASSERT @ - ApRewardLocations == 3 * AP_REWARD_LIST_SIZE
