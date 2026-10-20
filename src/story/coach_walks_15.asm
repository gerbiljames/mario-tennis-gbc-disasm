ActorScript_15_16:
	; $7b96, 29 bytes (actor_script)
	as_set_target 47.0, 41.0
	as_wait_move
	as_set_target 47.0, 35.0
	as_wait_move
	as_set_target 45.0, 35.0
	as_wait_move
	as_set_target 39.0, 31.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_15_17:
	; $7bb3, 11 bytes (actor_script)
	as_set_target 41.0, 47.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_15_18:
	; $7bbe, 11 bytes (actor_script)
	as_set_target 45.0, 45.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ReturnCoachWalkToCourtAndStartLesson:
	script_null_script ACTOR_PARTNER ; $7bc9
	script_player_speed 1.0 ; $7bce
	script_set_actor_script ACTOR_TRAINING_COURT_BOB_2, ActorScript_15_19 ; $7bd4
	script_set_actor_script ACTOR_PLAYER, ActorScript_15_20 ; $7bdf
	script_set_actor_script ACTOR_PARTNER, ActorScript_15_21 ; $7bea
	script_move_player 24.0, 39.0 ; $7bf5
	script_wait_actor_script ACTOR_PLAYER ; $7bff
	farcall WaitPlayerMoveDone ; $7c04
	script_wait_actor_script ACTOR_TRAINING_COURT_BOB_2 ; $7c07
	script_wait_frames 5 ; $7c0c
	call PlayerPartnerGestureCutscene ; $7c13
	ld a, STORYLOC_TRAINING_COURT ; $7c16
	ld [wStoryModeCurrentLocation], a ; $7c18
	ld a, ENTRY_TRAINING_COURT_DRILL_RESULT ; $7c1b
	ld [wStoryModeEntryPoint], a ; $7c1d
	ld a, EXITTRIGGER_DIRECT ; $7c20
	ld [wUnusedExitTriggerIdMirror], a ; $7c22
	ld [wStoryModeExitTriggerRequest], a ; $7c25
	ld a, [wCurrentMatchIndex] ; $7c28
	farcall RunTrainingDrillByID ; $7c2b
	ret ; $7c2e
ActorScript_15_19:
	; $7c2f, 29 bytes (actor_script)
	as_set_target 17.0, 41.0
	as_wait_move
	as_set_target 17.0, 37.0
	as_wait_move
	as_set_target 19.0, 37.0
	as_wait_move
	as_set_target 23.0, 31.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_15_20:
	; $7c4c, 11 bytes (actor_script)
	as_set_target 25.0, 47.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_15_21:
	; $7c57, 11 bytes (actor_script)
	as_set_target 19.0, 45.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
MovePartyToServeCoachSpot:
	script_set_speed ACTOR_PLAYER, 0.5 ; $7c62
	script_set_speed ACTOR_PARTNER, 0.5 ; $7c6a
	script_move_target ACTOR_PLAYER, 19.0, 19.0 ; $7c72
	test_flag FLAG_DOUBLES ; $7c7d
	jr z, .waitPlayer ; $7c80
	script_null_script ACTOR_PARTNER ; $7c82
	script_move_target ACTOR_PARTNER, 19.0, 17.0 ; $7c87
	script_wait_move ACTOR_PARTNER ; $7c92
.waitPlayer:
	script_wait_move ACTOR_PLAYER ; $7c97
	script_face ACTOR_PLAYER, FACE_RIGHT ; $7c9c
	script_face ACTOR_PARTNER, FACE_RIGHT ; $7ca3
	script_set_speed ACTOR_PLAYER, 1.0 ; $7caa
	script_set_speed ACTOR_PARTNER, 1.0 ; $7cb2
	ret ; $7cba
MovePartyToNetCoachSpot:
	script_set_speed ACTOR_PLAYER, 0.5 ; $7cbb
	script_set_speed ACTOR_PARTNER, 0.5 ; $7cc3
	script_move_target ACTOR_PLAYER, 45.0, 43.0 ; $7ccb
	test_flag FLAG_DOUBLES ; $7cd6
	jr z, .wait ; $7cd9
	script_null_script ACTOR_PARTNER ; $7cdb
	script_move_target ACTOR_PARTNER, 47.0, 43.0 ; $7ce0
	script_wait_move ACTOR_PARTNER ; $7ceb
.wait:
	script_wait_move ACTOR_PLAYER ; $7cf0
	script_face ACTOR_PLAYER, FACE_LEFT ; $7cf5
	script_face ACTOR_PARTNER, FACE_LEFT ; $7cfc
	script_set_speed ACTOR_PLAYER, 1.0 ; $7d03
	script_set_speed ACTOR_PARTNER, 1.0 ; $7d0b
	ret ; $7d13
MovePartyToReturnCoachSpot:
	script_set_speed ACTOR_PLAYER, 0.5 ; $7d14
	script_set_speed ACTOR_PARTNER, 0.5 ; $7d1c
	script_move_target ACTOR_PLAYER, 19.0, 43.0 ; $7d24
	test_flag FLAG_DOUBLES ; $7d2f
	jr z, .wait ; $7d32
	script_null_script ACTOR_PARTNER ; $7d34
	script_move_target ACTOR_PARTNER, 17.0, 43.0 ; $7d39
	script_wait_move ACTOR_PARTNER ; $7d44
.wait:
	script_wait_move ACTOR_PLAYER ; $7d49
	script_face ACTOR_PLAYER, FACE_RIGHT ; $7d4e
	script_face ACTOR_PARTNER, FACE_RIGHT ; $7d55
	script_set_speed ACTOR_PLAYER, 1.0 ; $7d5c
	script_set_speed ACTOR_PARTNER, 1.0 ; $7d64
	ret ; $7d6c
ActorScript_15_22:
	; $7d6d, 10 bytes (actor_script)
	as_halt
	as_anim ANIM_STILL
	as_halt
.stepLoop:
	as_step
	as_wait 1
	as_jump .stepLoop
ActorScript_15_23:
	; $7d77, 30 bytes (actor_script)
	as_set_wander_home
.wander:
	as_rand_box $02, $02
	as_wait_move2
	as_wait 40
	as_jump .wander
	as_set_wander_home
.wanderNarrow:
	as_rand_box $01, $02
	as_wait_move2
	as_wait 40
	as_jump .wanderNarrow
	as_set_wander_home
.wanderSmall:
	as_rand_box $01, $01
	as_wait_move2
	as_wait 40
	as_jump .wanderSmall
MapScriptNop_15:
	ret ; $7d95
Unused_15_MapScriptClearScriptRan:
	xor a ; $7d96
	ld [wStoryScriptRan], a ; $7d97
	ret ; $7d9a
Unused_15_MapScriptPlayStoryCue:
	sound SFX_STORY_CUE ; $7d9b
	ret ; $7d9d
Unused_15_MapScriptHideLocationName:
	xor a ; $7d9e
	ld [wStoryModeShowLocationName], a ; $7d9f
	ret ; $7da2
Unused_15_ActorScriptStudentSwings:
	; $7da3, 410 bytes (actor_script)
	as_anim ANIM_WALK
	as_move_by 4.0, 2.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_move_by -4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_move_by 4.0, -2.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_move_by -4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_move_by 4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_move_by -4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_jump Unused_15_ActorScriptStudentSwings
	as_anim ANIM_STILL
	as_wait 60
.swingUpSideLoop:
	as_anim ANIM_WALK
	as_move_by -4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_move_by 4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_move_by -4.0, -2.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_move_by 4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_move_by -4.0, 2.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_move_by 4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_jump .swingUpSideLoop
	as_anim ANIM_STILL
	as_wait 30
.swingDownLoop:
	as_anim ANIM_WALK
	as_move_by 4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_move_by -4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_move_by 4.0, 2.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_move_by -4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_move_by 4.0, -2.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_move_by -4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING
	as_wait 75
	as_jump .swingDownLoop
	as_anim ANIM_STILL
	as_wait 30
	as_wait 60
.swingUpDiagonalLoop:
	as_anim ANIM_WALK
	as_move_by -4.0, -2.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_move_by 4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_move_by -4.0, 2.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_move_by 4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_move_by -4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_anim ANIM_WALK
	as_move_by 4.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING
	as_wait 75
	as_jump .swingUpDiagonalLoop
ActorScript_15_25:
	; $7f3d, 28 bytes (actor_script)
	as_wait 240
	as_anim ANIM_NOD
	as_wait 80
	as_anim ANIM_NOD
	as_wait 60
	as_jump ActorScript_15_25
.shakeHeadLoop:
	as_wait 140
	as_anim ANIM_SHAKE
	as_wait 140
	as_anim ANIM_SHAKE
	as_wait 140
	as_anim ANIM_NOD
	as_jump .shakeHeadLoop
	twin_in compute_ranking_progress_index_13, Unused_15_ComputeRankingProgressIndex, 15 ; $7f59 Unused_15_ComputeRankingProgressIndex
	twin compute_story_rank_tier, 15 ; $7fa0 ComputeStoryRankTier_15
	; $7fd1, 47 bytes fill to bank end (linker-padded)
