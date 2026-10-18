; Shared by Unused_14_ComputeRankingProgressIndex,
; Unused_13_ComputeRankingProgressIndex, Unused_15_ComputeRankingProgressIndex
; (banks $13, $14, $15).

ASSERT STRCMP("{TWIN_LABEL}", "{ComputeRankingProgressIndex_{TWIN}_NAME}") == 0
{TWIN_LABEL}:
	test_flag FLAG_DOUBLES
	jr nz, .isDoubles
	ld a, STORYRANK_SINGLES_ACADEMY
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1
	jr z, .loop
	ld a, STORYRANK_SINGLES_JUNIOR_CHAMP
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1
	jr z, .loop
	ld a, STORYRANK_SINGLES_SENIOR_CHAMP
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES
	jr z, .loop
	ld a, STORYRANK_SINGLES_ISLAND_OPEN
	test_flag FLAG_STORY_COMPLETE_SINGLES
	jr z, .loop
	ld a, STORYRANK_SINGLES_COMPLETE
.loop:
	ld [wMapSceneStage], a
	ret
.isDoubles:
	ld a, STORYRANK_DOUBLES_ACADEMY
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1
	jr z, .loop
	ld a, STORYRANK_DOUBLES_JUNIOR_CHAMP
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1
	jr z, .loop
	ld a, STORYRANK_DOUBLES_SENIOR_CHAMP
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES
	jr z, .loop
	ld a, STORYRANK_DOUBLES_ISLAND_OPEN
	test_flag FLAG_STORY_COMPLETE_DOUBLES
	jr z, .loop
	ld a, STORYRANK_DOUBLES_COMPLETE
	jr .loop
