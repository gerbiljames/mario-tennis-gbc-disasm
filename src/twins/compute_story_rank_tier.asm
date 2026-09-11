; ComputeStoryRankTier_<bank>: one routine assembled into banks $13, $15 through
; `twin compute_story_rank_tier, <bank>` -- {TWIN} is the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

ComputeStoryRankTier_{TWIN}:
	ld a, $00
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1
	jr z, .loop
	inc a
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1
	jr z, .loop
	inc a
	test_flag FLAG_DOUBLES
	jr nz, .checkFlag
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES
	jr z, .loop
	inc a
	test_flag FLAG_STORY_COMPLETE_SINGLES
	jr z, .loop
	inc a
.loop:
	ld [wMapSceneStage], a
	ret
.checkFlag:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES
	jr z, .loop
	inc a
	test_flag FLAG_STORY_COMPLETE_DOUBLES
	jr z, .loop
	inc a
	jr .loop
