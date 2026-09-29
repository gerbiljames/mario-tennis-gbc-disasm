; ComputeRankingProgressIndex_<bank>: one routine assembled into banks $13, $14, $15 through
; `twin_in compute_ranking_progress_index_13, <Label>, <bank>` -- {TWIN_LABEL} is the copy's name
; (Unused_<bank>_ComputeRankingProgressIndex where nothing reaches it) and {TWIN} the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

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
