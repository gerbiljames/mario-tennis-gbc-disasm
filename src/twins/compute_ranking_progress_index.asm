; Shared by Unused_27_ComputeRankingProgressIndex,
; ComputeRankingProgressIndex_11, ComputeRankingProgressIndex_12,
; ComputeRankingProgressIndex_0e (banks $0e, $11, $12, $27).

ASSERT STRCMP("{TWIN_LABEL}", "{ComputeRankingProgressIndex_{TWIN}_NAME}") == 0
{TWIN_LABEL}:
	test_flag FLAG_DOUBLES
	jr nz, .doubles
	ld a, STORYRANK_SINGLES_ACADEMY
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1
	jr z, .store
	ld a, STORYRANK_SINGLES_JUNIOR_CHAMP
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1
	jr z, .store
	ld a, STORYRANK_SINGLES_SENIOR_CHAMP
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES
	jr z, .store
	ld a, STORYRANK_SINGLES_ISLAND_OPEN
	test_flag FLAG_STORY_COMPLETE_SINGLES
	jr z, .store
	ld a, STORYRANK_SINGLES_COMPLETE
.store:
	ld [wMapSceneStage], a
	ret
.doubles:
	ld a, STORYRANK_DOUBLES_ACADEMY
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1
	jr z, .store
	ld a, STORYRANK_DOUBLES_JUNIOR_CHAMP
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1
	jr z, .store
	ld a, STORYRANK_DOUBLES_SENIOR_CHAMP
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES
	jr z, .store
	ld a, STORYRANK_DOUBLES_ISLAND_OPEN
	test_flag FLAG_STORY_COMPLETE_DOUBLES
	jr z, .store
	ld a, STORYRANK_DOUBLES_COMPLETE
	jr .store
