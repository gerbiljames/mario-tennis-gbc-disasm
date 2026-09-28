ParkMiddleCourtPracticePair:
	script_null_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_RACKET_STUDENT_3 ; $7a76
	script_null_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_RACKET_STUDENT_4 ; $7a7b
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_RACKET_STUDENT_3, ANIM_WALK ; $7a80
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_RACKET_STUDENT_4, ANIM_WALK ; $7a87
	script_set_position ACTOR_JUNIOR_CLASS_COURT_SINGLES_RACKET_STUDENT_3, $1f00, $0b00 ; $7a8e
	script_set_position ACTOR_JUNIOR_CLASS_COURT_SINGLES_RACKET_STUDENT_4, $1f00, $1300 ; $7a99
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_RACKET_STUDENT_3, FACE_LEFT ; $7aa4
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_RACKET_STUDENT_4, FACE_LEFT ; $7aab
	ret ; $7ab2
ParkLeftCourtPracticePairRightSide:
	script_null_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_RACKET_STUDENT_1 ; $7ab3
	script_null_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_RACKET_STUDENT_2 ; $7ab8
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_RACKET_STUDENT_1, ANIM_WALK ; $7abd
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_RACKET_STUDENT_2, ANIM_WALK ; $7ac4
	script_set_position ACTOR_JUNIOR_CLASS_COURT_SINGLES_RACKET_STUDENT_1, $0f00, $0b00 ; $7acb
	script_set_position ACTOR_JUNIOR_CLASS_COURT_SINGLES_RACKET_STUDENT_2, $0f00, $1300 ; $7ad6
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_RACKET_STUDENT_1, FACE_LEFT ; $7ae1
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_RACKET_STUDENT_2, FACE_LEFT ; $7ae8
	script_wait_frames $14 ; $7aef
	ret ; $7af6
ParkLeftCourtPracticePairLeftSide:
	script_null_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_1 ; $7af7
	script_null_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_2 ; $7afc
	script_set_position ACTOR_JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_1, $0500, $0b00 ; $7b01
	script_set_position ACTOR_JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_2, $0500, $1300 ; $7b0c
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_1, FACE_RIGHT ; $7b17
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_2, FACE_RIGHT ; $7b1e
	script_wait_frames $14 ; $7b25
	ret ; $7b2c
ResumeMiddleCourtPractice:
	script_move_target ACTOR_JUNIOR_CLASS_COURT_SINGLES_RACKET_STUDENT_3, $1800, $0b00 ; $7b2d
	script_move_target ACTOR_JUNIOR_CLASS_COURT_SINGLES_RACKET_STUDENT_4, $1c00, $1700 ; $7b38
	script_wait_move ACTOR_JUNIOR_CLASS_COURT_SINGLES_RACKET_STUDENT_4 ; $7b43
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_RACKET_STUDENT_4, FACE_UP ; $7b48
	script_wait_move ACTOR_JUNIOR_CLASS_COURT_SINGLES_RACKET_STUDENT_3 ; $7b4f
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_RACKET_STUDENT_3, ActorScript_11_48 ; $7b54
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_RACKET_STUDENT_4, ActorScript_11_49 ; $7b5f
	ret ; $7b6a
ResumeLeftCourtPractice:
	script_move_target ACTOR_JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_1, $0800, $0b00 ; $7b6b
	script_move_target ACTOR_JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_2, $0c00, $1700 ; $7b76
	script_wait_move ACTOR_JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_2 ; $7b81
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_2, FACE_UP ; $7b86
	script_wait_move ACTOR_JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_1 ; $7b8d
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_1, ActorScript_11_50 ; $7b92
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_2, ActorScript_11_51 ; $7b9d
	ret ; $7ba8
ActorScript_11_45:
	; $7ba9, 10 bytes (actor_script)
	as_halt
	as_anim ANIM_STILL
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
Unused_11_MapScriptClearActiveFlag:
	xor a ; $7bd2
	ld [wStoryScriptRan], a ; $7bd3
	ret ; $7bd6
MapScriptPlaySoundA2_11:
	sound SFX_STORY_CUE ; $7bd7
	ret ; $7bd9
Unused_11_MapScriptHideLocationName:
	xor a ; $7bda
	ld [wStoryModeShowLocationName], a ; $7bdb
	ret ; $7bde
ActorScript_11_48:
	; $7bdf, 99 bytes (actor_script)
	as_anim ANIM_WALK
	as_target_rel $0400, $0200
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $0400, $fe00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_jump ActorScript_11_48
ActorScript_11_49:
	; $7c42, 103 bytes (actor_script)
	as_anim ANIM_STILL
	as_wait $3c
.L4:
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $fc00, $fe00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $fc00, $0200
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_jump .L4
ActorScript_11_50:
	; $7ca9, 103 bytes (actor_script)
	as_anim ANIM_STILL
	as_wait $1e
.L4:
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $0400, $0200
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $0400, $fe00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait $4b
	as_jump .L4
ActorScript_11_51:
	; $7d10, 118 bytes (actor_script)
	as_anim ANIM_STILL
	as_wait $1e
	as_wait $3c
.L6:
	as_anim ANIM_WALK
	as_target_rel $fc00, $fe00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $fc00, $0200
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_anim ANIM_WALK
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait $4b
	as_jump .L6
.L69:
	as_wait $f0
	as_anim ANIM_NOD
	as_wait $50
	as_anim ANIM_NOD
	as_wait $3c
	as_jump .L69
ActorScript_11_52:
	; $7d86, 15 bytes (actor_script)
	as_wait $8c
	as_anim ANIM_SHAKE
	as_wait $8c
	as_anim ANIM_SHAKE
	as_wait $8c
	as_anim ANIM_NOD
	as_jump ActorScript_11_52
; Instruction-identical to ComputeRankingProgressIndex_0e, ComputeRankingProgressIndex_12 and ComputeRankingProgressIndex_27 (one copy per bank); a change here belongs in every copy.
	twin compute_ranking_progress_index, 11 ; $7d95 ComputeRankingProgressIndex_11
; This bank's copy of ComputeStoryRankTier_13, identical instruction for instruction: the shared story include carried it into every story bank, and only bank $13's copy is called (by Unused_27_SetStoryRankTier). Nothing calls this one.
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
