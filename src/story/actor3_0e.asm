ActorScript_0e_16:
	; $7b11, 19 bytes (actor_script)
	as_set_target $0500, $1f00
	as_wait_move
	as_set_target $0d00, $1f00
	as_wait_move
	as_set_target $0d00, $1b00
	as_wait_move
	as_halt
ActorScript_0e_17:
	; $7b24, 11 bytes (actor_script)
	as_set_target $1300, $1700
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_0e_18:
	; $7b2f, 23 bytes (actor_script)
	as_set_target $0900, $1700
	as_wait_move
	as_set_target $0900, $0d00
	as_wait_move
	as_set_target $0d00, $0d00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_0e_19:
	; $7b46, 23 bytes (actor_script)
	as_set_target $0900, $1700
	as_wait_move
	as_set_target $0900, $1100
	as_wait_move
	as_set_target $0f00, $1100
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_0e_20:
	; $7b5d, 17 bytes (actor_script)
	as_set_target $0d00, $1d00
	as_wait_move
	as_set_target $0f00, $1d00
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_0e_21:
	; $7b6e, 17 bytes (actor_script)
	as_set_target $0f00, $1900
	as_wait_move
	as_set_target $0d00, $1900
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
PrepareStoryMatch:
	ld a, STORYLOC_SPECIAL_COURT ; $7b7f
	ld [wStoryModeCurrentLocation], a ; $7b81
	ld a, $0a ; $7b84
	ld [wStoryModeEntryPoint], a ; $7b86
	ld a, $ff ; $7b89
	ld [wUnusedExitTriggerIdMirror], a ; $7b8b
	ld [wStoryModeExitTriggerRequest], a ; $7b8e
	farcall InitStoryMatchSettings ; $7b91
	ld a, [wMapScratch + 2] ; $7b94
	add a ; $7b97
	ld_hl_indexed PrepareStoryMatchTable ; $7b98
	ld a, [hl+] ; $7b9f
	ld h, [hl] ; $7ba0
	ld l, a ; $7ba1
	call JumpToHL ; $7ba2
	farcall RunStoryMatch ; $7ba5
	farcall RestoreOverworldAfterMatch ; $7ba8
	ret ; $7bab
PrepareStoryMatchTable:
	dw LoadExhibitionMatchSettings0 ; $7bac
	dw LoadExhibitionMatchSettings1 ; $7bae
	dw LoadExhibitionMatchSettings2 ; $7bb0
	dw LoadExhibitionMatchSettings3 ; $7bb2
	dw LoadExhibitionMatchSettings4 ; $7bb4
	dw LoadExhibitionMatchSettings5 ; $7bb6
LoadExhibitionMatchSettings0:
	load_match_settings $0018 ; $7bb8
	ret ; $7bc5
LoadExhibitionMatchSettings1:
	load_match_settings $0017 ; $7bc6
	ret ; $7bd3
LoadExhibitionMatchSettings2:
	load_match_settings $0016 ; $7bd4
	ret ; $7be1
LoadExhibitionMatchSettings3:
	load_match_settings $0118 ; $7be2
	ret ; $7bef
LoadExhibitionMatchSettings4:
	load_match_settings $0117 ; $7bf0
	ret ; $7bfd
LoadExhibitionMatchSettings5:
	load_match_settings $0116 ; $7bfe
	ret ; $7c0b
HandleExhibitionMatchResult:
	ld a, [wMatchWinLoseFlag] ; $7c0c
	cp WINLOSE_WIN ; $7c0f
	jr nz, .lost ; $7c11
	test_flag FLAG_DOUBLES ; $7c13
	jr nz, .won ; $7c16
	test_flag FLAG_WON_DREAM_MATCH_SINGLES ; $7c18
	jr nz, .aborted ; $7c1b
	jr .lost ; $7c1d
.won:
	test_flag FLAG_WON_DREAM_MATCH_DOUBLES ; $7c1f
	jr nz, .aborted ; $7c22
.lost:
	ld a, STORYLOC_PEACHS_CASTLE ; $7c24
	ld [wStoryModeCurrentLocation], a ; $7c26
	ld a, $0e ; $7c29
	ld [wStoryModeEntryPoint], a ; $7c2b
	ld a, $ff ; $7c2e
	ld [wUnusedExitTriggerIdMirror], a ; $7c30
	ld [wStoryModeExitTriggerRequest], a ; $7c33
	ret ; $7c36
.aborted:
	test_flag FLAG_DOUBLES ; $7c37
	jr nz, .returnToLocation ; $7c3a
	ld b, $02 ; $7c3c
	ld a, [wStoryModeGenderOfMainCharacter] ; $7c3e
	add $04 ; $7c41
	ld c, a ; $7c43
	farcall RunStorySceneByMode ; $7c44
	jr .done ; $7c47
.returnToLocation:
	ld b, $02 ; $7c49
	ld a, [wStoryModeGenderOfMainCharacter] ; $7c4b
	ld d, a ; $7c4e
	sla a ; $7c4f
	ld c, a ; $7c51
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $7c52
	xor d ; $7c55
	or c ; $7c56
	ld c, a ; $7c57
	farcall RunStorySceneByMode ; $7c58
.done:
	ld a, STORYLOC_MAIN_MENU ; $7c5b
	ld [wStoryModeCurrentLocation], a ; $7c5d
	ld a, $0a ; $7c60
	ld [wStoryModeEntryPoint], a ; $7c62
	ld a, $ff ; $7c65
	ld [wUnusedExitTriggerIdMirror], a ; $7c67
	ld [wStoryModeExitTriggerRequest], a ; $7c6a
	ret ; $7c6d
ActorScript_0e_22:
	; $7c6e, 40 bytes (actor_script)
	as_halt
	as_anim $00
	as_halt
.L4:
	as_step
	as_wait $01
	as_jump .L4
	as_begin_path
.Lb:
	as_rand_box $02, $02
	as_wait_move2
	as_wait $28
	as_jump .Lb
	as_begin_path
.L15:
	as_rand_box $01, $02
	as_wait_move2
	as_wait $28
	as_jump .L15
	as_begin_path
.L1f:
	as_rand_box $01, $01
	as_wait_move2
	as_wait $28
	as_jump .L1f
MapScriptNop_0e:
	ret ; $7c96
MapScriptClearActiveFlag_0e:
	xor a ; $7c97
	ld [wStoryScriptRan], a ; $7c98
	ret ; $7c9b
MapScriptPlaySoundA2_0e:
	sound SFX_STORY_CUE ; $7c9c
	ret ; $7c9e
MapScriptHideLocationName_0e:
	xor a ; $7c9f
	ld [wStoryModeShowLocationName], a ; $7ca0
	ret ; $7ca3
ActorScript_0e_23:
	; $7ca4, 103 bytes (actor_script)
	as_anim $01
	as_target_rel $0400, $0200
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $fe00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_jump ActorScript_0e_23
	as_anim $00
	as_wait $3c
ActorScript_0e_24:
	; $7d0b, 103 bytes (actor_script)
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $fe00
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0200
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_jump ActorScript_0e_24
	as_anim $00
	as_wait $1e
ActorScript_0e_25:
	; $7d72, 105 bytes (actor_script)
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0200
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $fe00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_jump ActorScript_0e_25
	as_anim $00
	as_wait $1e
	as_wait $3c
ActorScript_0e_26:
	; $7ddb, 99 bytes (actor_script)
	as_anim $01
	as_target_rel $fc00, $fe00
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0200
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_jump ActorScript_0e_26
ActorScript_0e_27:
	; $7e3e, 13 bytes (actor_script)
	as_wait $f0
	as_anim $03
	as_wait $50
	as_anim $03
	as_wait $3c
	as_jump ActorScript_0e_27
ActorScript_0e_28:
	; $7e4b, 15 bytes (actor_script)
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $03
	as_jump ActorScript_0e_28
; Instruction-identical to ComputeRankingProgressIndex_11, ComputeRankingProgressIndex_12 and ComputeRankingProgressIndex_27 (one copy per bank); a change here belongs in every copy.
ComputeRankingProgressIndex_0e:
	test_flag FLAG_DOUBLES ; $7e5a
	jr nz, .doubles ; $7e5d
	ld a, STORYRANK_SINGLES_ACADEMY ; $7e5f
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7e61
	jr z, .store ; $7e64
	ld a, STORYRANK_SINGLES_JUNIOR_CHAMP ; $7e66
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7e68
	jr z, .store ; $7e6b
	ld a, STORYRANK_SINGLES_SENIOR_CHAMP ; $7e6d
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7e6f
	jr z, .store ; $7e72
	ld a, STORYRANK_SINGLES_ISLAND_OPEN ; $7e74
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7e76
	jr z, .store ; $7e79
	ld a, STORYRANK_SINGLES_COMPLETE ; $7e7b
.store:
	ld [wMapSceneStage], a ; $7e7d
	ret ; $7e80
.doubles:
	ld a, STORYRANK_DOUBLES_ACADEMY ; $7e81
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $7e83
	jr z, .store ; $7e86
	ld a, STORYRANK_DOUBLES_JUNIOR_CHAMP ; $7e88
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $7e8a
	jr z, .store ; $7e8d
	ld a, STORYRANK_DOUBLES_SENIOR_CHAMP ; $7e8f
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7e91
	jr z, .store ; $7e94
	ld a, STORYRANK_DOUBLES_ISLAND_OPEN ; $7e96
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7e98
	jr z, .store ; $7e9b
	ld a, STORYRANK_DOUBLES_COMPLETE ; $7e9d
	jr .store ; $7e9f
; This bank's copy of ComputeStoryRankTier_13, identical instruction for instruction: the shared story include carried it into every story bank, and only bank $13's copy is called (by SetStoryRankTier). Nothing calls this one.
Unused_0e_ComputeStoryRankTier:
	ld a, $00 ; $7ea1
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7ea3
	jr z, .storeIsland ; $7ea6
	inc a ; $7ea8
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7ea9
	jr z, .storeIsland ; $7eac
	inc a ; $7eae
	test_flag FLAG_DOUBLES ; $7eaf
	jr nz, .doublesIsland ; $7eb2
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7eb4
	jr z, .storeIsland ; $7eb7
	inc a ; $7eb9
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7eba
	jr z, .storeIsland ; $7ebd
	inc a ; $7ebf
.storeIsland:
	ld [wMapSceneStage], a ; $7ec0
	ret ; $7ec3
.doublesIsland:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7ec4
	jr z, .storeIsland ; $7ec7
	inc a ; $7ec9
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7eca
	jr z, .storeIsland ; $7ecd
	inc a ; $7ecf
	jr .storeIsland ; $7ed0
	; $7ed2, 302 bytes fill to bank end (linker-padded)
