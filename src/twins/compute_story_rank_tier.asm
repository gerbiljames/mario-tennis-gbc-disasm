; ComputeStoryRankTier_<bank>, one copy in each of banks $13, $15.

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
