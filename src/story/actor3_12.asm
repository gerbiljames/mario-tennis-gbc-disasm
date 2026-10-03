Unclassified_12:
	; $7a65, 3 bytes (bytes:3)
	db $fa, $4d, $c9 ; 0x00
PushTextArgFetchedString:
	push_wram_bank WRAM_CHAR3 ; $7a68
	ld de, wTextArgFetchBuffer ; $7a71
	wram_bank WRAM_CHAR1 ; $7a74
	farcall FetchShortTextToBuffer ; $7a7a
	ld hl, wTextArgFetchBuffer ; $7a7d
	farcall PushTextArgString ; $7a80
	pop_wram_bank ; $7a83
	ret ; $7a88
ActorScript_12_51:
	; $7a89, 10 bytes (actor_script)
	as_halt
	as_anim ANIM_STILL
	as_halt
.L4:
	as_step
	as_wait 1
	as_jump .L4
ActorScript_12_52:
	; $7a93, 30 bytes (actor_script)
	as_begin_path
.L1:
	as_rand_box $02, $02
	as_wait_move2
	as_wait 40
	as_jump .L1
	as_begin_path
.Lb:
	as_rand_box $01, $02
	as_wait_move2
	as_wait 40
	as_jump .Lb
	as_begin_path
.L15:
	as_rand_box $01, $01
	as_wait_move2
	as_wait 40
	as_jump .L15
MapScriptNop_12:
	ret ; $7ab1
Unused_12_MapScriptClearActiveFlag:
	xor a ; $7ab2
	ld [wStoryScriptRan], a ; $7ab3
	ret ; $7ab6
Unused_12_MapScriptPlaySoundA2:
	sound SFX_STORY_CUE ; $7ab7
	ret ; $7ab9
Unused_12_MapScriptHideLocationName:
	xor a ; $7aba
	ld [wStoryModeShowLocationName], a ; $7abb
	ret ; $7abe
ActorScript_12_53:
	; $7abf, 99 bytes (actor_script)
	as_anim ANIM_WALK
	as_target_rel $0400, $0200
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel $0400, $fe00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_jump ActorScript_12_53
ActorScript_12_54:
	; $7b22, 103 bytes (actor_script)
	as_anim ANIM_STILL
	as_wait 60
.L4:
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel $fc00, $fe00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel $fc00, $0200
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_jump .L4
ActorScript_12_55:
	; $7b89, 103 bytes (actor_script)
	as_anim ANIM_STILL
	as_wait 30
.L4:
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel $0400, $0200
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel $0400, $fe00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_jump .L4
ActorScript_12_56:
	; $7bf0, 105 bytes (actor_script)
	as_anim ANIM_STILL
	as_wait 30
	as_wait 60
.L6:
	as_anim ANIM_WALK
	as_target_rel $fc00, $fe00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel $fc00, $0200
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_jump .L6
ActorScript_12_57:
	; $7c59, 13 bytes (actor_script)
	as_wait 240
	as_anim ANIM_NOD
	as_wait 80
	as_anim ANIM_NOD
	as_wait 60
	as_jump ActorScript_12_57
ActorScript_12_58:
	; $7c66, 15 bytes (actor_script)
	as_wait 140
	as_anim ANIM_SHAKE
	as_wait 140
	as_anim ANIM_SHAKE
	as_wait 140
	as_anim ANIM_NOD
	as_jump ActorScript_12_58
; Instruction-identical to ComputeRankingProgressIndex_0e, ComputeRankingProgressIndex_11 and Unused_27_ComputeRankingProgressIndex (one copy per bank); a change here belongs in every copy.
	twin_in compute_ranking_progress_index, ComputeRankingProgressIndex_12, 12 ; $7c75 ComputeRankingProgressIndex_12
; This bank's copy of ComputeStoryRankTier_13, identical instruction for instruction: the shared story include carried it into every story bank, and only bank $13's copy is called (by Unused_27_SetStoryRankTier). Nothing calls this one.
Unused_12_ComputeStoryRankTier:
	ld a, $00 ; $7cbc
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7cbe
	jr z, .storeIsland ; $7cc1
	inc a ; $7cc3
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7cc4
	jr z, .storeIsland ; $7cc7
	inc a ; $7cc9
	test_flag FLAG_DOUBLES ; $7cca
	jr nz, .doublesIsland ; $7ccd
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7ccf
	jr z, .storeIsland ; $7cd2
	inc a ; $7cd4
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7cd5
	jr z, .storeIsland ; $7cd8
	inc a ; $7cda
.storeIsland:
	ld [wMapSceneStage], a ; $7cdb
	ret ; $7cde
.doublesIsland:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7cdf
	jr z, .storeIsland ; $7ce2
	inc a ; $7ce4
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7ce5
	jr z, .storeIsland ; $7ce8
	inc a ; $7cea
	jr .storeIsland ; $7ceb
	; $7ced, 787 bytes fill to bank end (linker-padded)
