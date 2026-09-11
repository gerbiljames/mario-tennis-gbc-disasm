ParkMiddleCourtPracticePair:
	script_null_script $0e ; $7a76
	script_null_script $0f ; $7a7b
	script_set_anim $0e, $01 ; $7a80
	script_set_anim $0f, $01 ; $7a87
	script_set_position $0e, $1f00, $0b00 ; $7a8e
	script_set_position $0f, $1f00, $1300 ; $7a99
	script_face $0e, FACE_LEFT ; $7aa4
	script_face $0f, FACE_LEFT ; $7aab
	ret ; $7ab2
ParkLeftCourtPracticePairRightSide:
	script_null_script $0c ; $7ab3
	script_null_script $0d ; $7ab8
	script_set_anim $0c, $01 ; $7abd
	script_set_anim $0d, $01 ; $7ac4
	script_set_position $0c, $0f00, $0b00 ; $7acb
	script_set_position $0d, $0f00, $1300 ; $7ad6
	script_face $0c, FACE_LEFT ; $7ae1
	script_face $0d, FACE_LEFT ; $7ae8
	script_wait_frames $14 ; $7aef
	ret ; $7af6
ParkLeftCourtPracticePairLeftSide:
	script_null_script $0c ; $7af7
	script_null_script $0d ; $7afc
	script_set_position $0c, $0500, $0b00 ; $7b01
	script_set_position $0d, $0500, $1300 ; $7b0c
	script_face $0c, FACE_RIGHT ; $7b17
	script_face $0d, FACE_RIGHT ; $7b1e
	script_wait_frames $14 ; $7b25
	ret ; $7b2c
ResumeMiddleCourtPractice:
	script_move_target $0e, $1800, $0b00 ; $7b2d
	script_move_target $0f, $1c00, $1700 ; $7b38
	script_wait_move $0f ; $7b43
	script_face $0f, FACE_UP ; $7b48
	script_wait_move $0e ; $7b4f
	script_set_actor_script $0e, ActorScript_11_48 ; $7b54
	script_set_actor_script $0f, ActorScript_11_49 ; $7b5f
	ret ; $7b6a
ResumeLeftCourtPractice:
	script_move_target $0c, $0800, $0b00 ; $7b6b
	script_move_target $0d, $0c00, $1700 ; $7b76
	script_wait_move $0d ; $7b81
	script_face $0d, FACE_UP ; $7b86
	script_wait_move $0c ; $7b8d
	script_set_actor_script $0c, ActorScript_11_50 ; $7b92
	script_set_actor_script $0d, ActorScript_11_51 ; $7b9d
	ret ; $7ba8
ActorScript_11_45:
	; $7ba9, 10 bytes (actor_script)
	as_halt
	as_anim $00
	as_halt
.L4:
	as_step
	as_wait $01
	as_jump .L4
ActorScript_11_46:
	; $7bb3, 10 bytes (actor_script)
	as_begin_path
.L1:
	as_rand_box $02, $02
	as_wait_move2
	as_wait $28
	as_jump .L1
ActorScript_11_47:
	; $7bbd, 20 bytes (actor_script)
	as_begin_path
.L1:
	as_rand_box $01, $02
	as_wait_move2
	as_wait $28
	as_jump .L1
	as_begin_path
.Lb:
	as_rand_box $01, $01
	as_wait_move2
	as_wait $28
	as_jump .Lb
MapScriptNop_11:
	ret ; $7bd1
MapScriptClearActiveFlag_11:
	xor a ; $7bd2
	ld [wStoryScriptRan], a ; $7bd3
	ret ; $7bd6
MapScriptPlaySoundA2_11:
	sound SFX_STORY_CUE ; $7bd7
	ret ; $7bd9
MapScriptHideLocationName_11:
	xor a ; $7bda
	ld [wStoryModeShowLocationName], a ; $7bdb
	ret ; $7bde
ActorScript_11_48:
	; $7bdf, 99 bytes (actor_script)
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
	as_jump ActorScript_11_48
ActorScript_11_49:
	; $7c42, 103 bytes (actor_script)
	as_anim $00
	as_wait $3c
.L4:
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
	as_jump .L4
ActorScript_11_50:
	; $7ca9, 103 bytes (actor_script)
	as_anim $00
	as_wait $1e
.L4:
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
	as_jump .L4
ActorScript_11_51:
	; $7d10, 118 bytes (actor_script)
	as_anim $00
	as_wait $1e
	as_wait $3c
.L6:
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
	as_jump .L6
.L69:
	as_wait $f0
	as_anim $03
	as_wait $50
	as_anim $03
	as_wait $3c
	as_jump .L69
ActorScript_11_52:
	; $7d86, 15 bytes (actor_script)
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $03
	as_jump ActorScript_11_52
; Instruction-identical to ComputeRankingProgressIndex_0e, ComputeRankingProgressIndex_12 and ComputeRankingProgressIndex_27 (one copy per bank); a change here belongs in every copy.
ComputeRankingProgressIndex_11:
	test_flag FLAG_DOUBLES ; $7d95
	jr nz, .doubles ; $7d98
	ld a, STORYRANK_SINGLES_ACADEMY ; $7d9a
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7d9c
	jr z, .store ; $7d9f
	ld a, STORYRANK_SINGLES_JUNIOR_CHAMP ; $7da1
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7da3
	jr z, .store ; $7da6
	ld a, STORYRANK_SINGLES_SENIOR_CHAMP ; $7da8
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7daa
	jr z, .store ; $7dad
	ld a, STORYRANK_SINGLES_ISLAND_OPEN ; $7daf
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7db1
	jr z, .store ; $7db4
	ld a, STORYRANK_SINGLES_COMPLETE ; $7db6
.store:
	ld [wMapSceneStage], a ; $7db8
	ret ; $7dbb
.doubles:
	ld a, STORYRANK_DOUBLES_ACADEMY ; $7dbc
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $7dbe
	jr z, .store ; $7dc1
	ld a, STORYRANK_DOUBLES_JUNIOR_CHAMP ; $7dc3
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $7dc5
	jr z, .store ; $7dc8
	ld a, STORYRANK_DOUBLES_SENIOR_CHAMP ; $7dca
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7dcc
	jr z, .store ; $7dcf
	ld a, STORYRANK_DOUBLES_ISLAND_OPEN ; $7dd1
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7dd3
	jr z, .store ; $7dd6
	ld a, STORYRANK_DOUBLES_COMPLETE ; $7dd8
	jr .store ; $7dda
; This bank's copy of ComputeStoryRankTier_13, identical instruction for instruction: the shared story include carried it into every story bank, and only bank $13's copy is called (by SetStoryRankTier). Nothing calls this one.
Unused_11_ComputeStoryRankTier:
	ld a, $00 ; $7ddc
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7dde
	jr z, .storeIsland ; $7de1
	inc a ; $7de3
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7de4
	jr z, .storeIsland ; $7de7
	inc a ; $7de9
	test_flag FLAG_DOUBLES ; $7dea
	jr nz, .doublesIsland ; $7ded
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7def
	jr z, .storeIsland ; $7df2
	inc a ; $7df4
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7df5
	jr z, .storeIsland ; $7df8
	inc a ; $7dfa
.storeIsland:
	ld [wMapSceneStage], a ; $7dfb
	ret ; $7dfe
.doublesIsland:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7dff
	jr z, .storeIsland ; $7e02
	inc a ; $7e04
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7e05
	jr z, .storeIsland ; $7e08
	inc a ; $7e0a
	jr .storeIsland ; $7e0b
	; $7e0d, 499 bytes fill to bank end (linker-padded)
